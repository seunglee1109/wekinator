/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package wekinator;

import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import weka.core.Attribute;
import weka.core.FastVector;
import weka.core.Instance;
import weka.core.Instances;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Remove;

/**
 *
 * @author Rebecca Fiebrink
 */
public class SimpleDataset implements Serializable {

    private int numParams = 0;
    private int numFeatures = 0; //Total # features being stored, doesn't include my metadata
    private boolean featureParamMask[][] = null;
    private boolean[] isParamDiscrete = null;
    private String[] featureNames = null;
    private String[] paramNames = null;
    private int numParamValues[] = null;
    private Instances allInstances = null;
    private Instances dummyInstances = null; //An empty set of instances with proper heading info
    private Remove[] paramFilters = null;
    private Remove featuresFilter = null;
    private Remove paramsFilter = null;
    private int nextID = 0;
    private List<RawAudioSegment> audioSegments = null;
    private int currentTrainingRound = 0;
    private int numMetaData = 3;
    private int idIndex = 0;
    private int timestampIndex = 1;
    private int trainingIndex = 2;
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("HHmmss");
    public static final SimpleDateFormat prettyDateFormat = new SimpleDateFormat("HH:mm:ss");

    //For serialization
    private static final long serialVersionUID = -6463977379713550249L;

    public SimpleDataset(int numFeatures, int numParams, boolean[] isParamDiscrete, int[] numParamValues, String[] featureNames, String[] paramNames) {
        if (isParamDiscrete == null || isParamDiscrete.length != numParams) {
            throw new IllegalArgumentException("isParamDiscrete.length must match numParams");
        }
        this.numParams = numParams;
        this.numFeatures = numFeatures;

        featureParamMask = new boolean[numFeatures][numParams];
        for (int i = 0; i < this.numFeatures; i++) {
            for (int j = 0; j < this.numParams; j++) {
                featureParamMask[i][j] = true;
            }
        }

        this.featureNames = new String[numFeatures];
        if (featureNames != null && featureNames.length == numFeatures) {
            for (int i = 0; i < this.numFeatures; i++) {
                this.featureNames[i] = featureNames[i];
            }
        } else {
            for (int i = 0; i < numFeatures; i++) {
                this.featureNames[i] = "Feature " + Integer.toString(i);
            }
        }


        this.paramNames = new String[this.numParams];

        if (paramNames != null && paramNames.length == numParams) {
            for (int i = 0; i < numParams; i++) {
                this.paramNames[i] = paramNames[i];
            }
        } else {
            for (int i = 0; i < numParams; i++) {
                this.paramNames[i] = "Param " + i;
            }
        }


        this.isParamDiscrete = new boolean[numParams];
        for (int i = 0; i < numParams; i++) {
            this.isParamDiscrete[i] = isParamDiscrete[i];
        }

        this.numParamValues = new int[numParams];
        for (int i = 0; i < numParams; i++) {
            if (numParamValues != null && numParamValues.length > i) {
                this.numParamValues[i] = numParamValues[i];
            } else {
                this.numParamValues[i] = 0;
            }
        }

        //Set up instances
        FastVector ff = new FastVector(numFeatures + numParams + numMetaData); //Include ID, timestamp, training round
        //add ID, timestamp, and training round #
        ff.addElement(new Attribute("ID"));
        ff.addElement(new Attribute("Timestamp")); //yyMMddHHmmss format; stored as double
        ff.addElement(new Attribute("Training round"));

        //Add features
        for (int i = 0; i < numFeatures; i++) {
            ff.addElement(new Attribute(this.featureNames[i]));
        }

        //Add parameters
        for (int i = 0; i < numParams; i++) {
            if (isParamDiscrete[i]) {
                if (numParamValues == null || numParamValues.length <= i) {
                    System.out.println("Problem: Length is " + numParamValues.length + " i is " + i);
                    throw new IllegalArgumentException("Invalid isParamDiscrete argument: Must be valid length when using discrete parameters");
                }
                //Create fastVector w/ possible
                FastVector classes = new FastVector(numParams);
                for (int val = 0; val < numParamValues[i]; val++) {
                    classes.addElement((new Integer(val)).toString());
                }
                ff.addElement(new Attribute(this.paramNames[i], classes));

            } else {
                ff.addElement(new Attribute(this.paramNames[i]));
            }
        }

        allInstances = new Instances("dataset", ff, 100);

        //Set up dummy instances to reflect state of actual instances
        dummyInstances = new Instances(allInstances);

        try {

            setupFilters();
        } catch (Exception ex) {
            System.out.println("Error: Couldn't set up filters correctly");
            System.exit(0);
        }

        // idMap = new HashMap<Integer, Instance>();
        audioSegments = new LinkedList<RawAudioSegment>();
    }

    void setFeatureValue(int index, int featNum, double value) {
        if (featNum < 0 || featNum >= numFeatures) {
            throw new IllegalArgumentException("Invalid feature number in setFeatureValue");
        }
        Instance i = allInstances.instance(index);
        if (i != null) {
            i.setValue(numMetaData + featNum, value);

        } //else TODO ?
    }

    void setParameterMissing(int index, int paramNum) {
        if (paramNum >= 0 && paramNum < numParams) {
            Instance i = allInstances.instance(index);
            i.setMissing(numMetaData + numFeatures + paramNum);
        }
    }

    void setParameterValue(int index, int paramNum, double value) {
        if (paramNum < 0 || paramNum >= numParams) {
            throw new IllegalArgumentException("Invalid parameter number in setParameterValue");
        }

        Instance i = allInstances.instance(index);
        if (i == null) {
            return;
        }

        if (isParamDiscrete[paramNum]) {
            int v = (int) value;
            Attribute a = i.attribute(numMetaData + numFeatures + paramNum);
            if (a.isNominal() && v >= 0 && v <= maxLegalDiscreteParamValue(paramNum)) {
                i.setValue(numMetaData + numFeatures + paramNum, v);

            } else {
                System.out.println("error: attribute value out of range");
            //TODO: CHeck this
            }
        } else {
            //Don't care about error checking for real-valued parameter
            i.setValue(numMetaData + numFeatures + paramNum, value);
        }
    }

    private Instances createInstancesForParameter(int paramNum) {
        if (paramNum < 0 || paramNum >= numParams) {
            throw new IllegalArgumentException("Invalid paramNum");
        }

        //use filter[paramNum];
        Instances i;
        try {
            i = Filter.useFilter(allInstances, paramFilters[paramNum]);
            //set class index
            i.setClassIndex(i.numAttributes() - 1);
            return i;
        } catch (Exception ex) {
            System.out.println("COuldn't filter");
            Logger.getLogger(SimpleDataset.class.getName()).log(Level.SEVERE, "bad news!", ex);
            return null;
        }

    }

    private void updateFilter(int filterNum) throws Exception {
        assert (filterNum > 0 && filterNum < paramFilters.length);

        //Get rid of metadata, other params, and non-used features
        paramFilters[filterNum] = new Remove();

        String removeString = ""; //string is index starting w/ 1

        for (int j = 0; j < numMetaData; j++) {
            removeString += Integer.toString(j + 1) + ",";
        }

        //Remove unused features
        for (int i = 0; i < numFeatures; i++) {
            if (!featureParamMask[i][filterNum]) {
                removeString += Integer.toString(numMetaData + i + 1) + ",";
            }
        }

        //Get rid of other params
        for (int i = 0; i < numParams; i++) {
            if (i != filterNum) {
                removeString += Integer.toString(numMetaData + numFeatures + i + 1) + ",";
            }
        }

        //Remove last comma
        removeString = removeString.substring(0, removeString.length());

        paramFilters[filterNum].setAttributeIndices(removeString);

        paramFilters[filterNum].setInputFormat(dummyInstances);

    }

    //TODO: test this
    private void setupFilters() throws Exception {
        paramFilters = new Remove[numParams];
        for (int p = 0; p < numParams; p++) {
            updateFilter(p);
        }

        //Filter so only features are present
        featuresFilter = new Remove();
        int[] indicesToRemove = new int[numMetaData + numParams];
        for (int i = 0; i < numMetaData; i++) {
            indicesToRemove[i] = i;
        }
        for (int i = 0; i < numParams; i++) {
            indicesToRemove[numMetaData + i] = numMetaData + numFeatures + i;
        }
        featuresFilter.setAttributeIndicesArray(indicesToRemove);
        featuresFilter.setInputFormat(dummyInstances);

        //Filter so only params are present
        paramsFilter = new Remove();
        indicesToRemove = new int[numMetaData + numFeatures];
        for (int i = 0; i < numMetaData; i++) {
            indicesToRemove[i] = i;
        }
        for (int i = 0; i < numFeatures; i++) {
            indicesToRemove[numMetaData + i] = numMetaData + i;
        }
        paramsFilter.setAttributeIndicesArray(indicesToRemove);
        paramsFilter.setInputFormat(dummyInstances);
    }


    //TODO: Problem here: Should only be able to change this @ beginning... ideally will never change it.
    //Get rid of all references!!
/*    public void setNumParameters(int num) {
    assert(num == numParams);

    } */
    public int getNumDatapoints() {
        return allInstances.numInstances();
    }

    public int getNumFeatures() {
        return numFeatures;
    }

    public int getNumFeaturesForParam(int paramNum) {
        if (paramNum < 0 || paramNum >= numParams) {
            System.out.println("Error: Unexpected paramNum: invalid range");
            return 0;
        }

        int sum = 0;
        for (int i = 0; i < numFeatures; i++) {
            if (featureParamMask[i][paramNum]) {
                sum++;
            }
        }
        return sum;
    }

    public int getNumParameters() {
        return numParams;
    }

    /**
     * Convert an array of doubles to an array of classifiable instances
     * @param d the double array
     * @return an Instance array; each instance corresponds to a parameter
     */
    public Instance[] convertToClassifiableInstances(double[] d) {
        if (d == null || d.length != numFeatures) {
            throw new IllegalArgumentException("Wrong d size");
        }
        double data[] = new double[numMetaData + numFeatures + numParams];

        for (int i = 0; i < numFeatures; i++) {
            data[numMetaData + i] = d[i];
        }

        Instance[] is = new Instance[numParams];
        for (int i = 0; i < numParams; i++) {
            is[i] = new Instance(1.0, data);
            Instances tmp = new Instances(dummyInstances);
            tmp.add(is[i]);
            try {
                tmp = Filter.useFilter(tmp, paramFilters[i]);
                tmp.setClassIndex(tmp.numAttributes() - 1);
                is[i] = tmp.firstInstance();
            } catch (Exception ex) {
                System.out.println("Error: could not filter");
                Logger.getLogger(SimpleDataset.class.getName()).log(Level.SEVERE, null, ex);
            }
            tmp.setClassIndex(tmp.numAttributes() - 1);
        }

        return is;
    }


    /**
     *
     * @param index the Instance ID
     * @param c the class number (between 0 and numParams - 1)
     * @return a classifier-ready Instance, or null if it doesn't exist
     */
    /*public double[] getFeatures(int index) {
    if (idMap.containsKey(index)) {
    Instance i = new Instance(idMap.get(index));
    featuresFilter.input(i);
    Instance ii = featuresFilter.output();
    return ii.toDoubleArray();
    } else {
    System.out.println("No such key found" + index);
    return null;
    }
    }*/
    public double[] getFeatures(int index) {


        Instance i = allInstances.instance(index);
        if (i == null) {
            return null;
        }

        featuresFilter.input(i);
        Instance ii = featuresFilter.output();
        return ii.toDoubleArray();
    }

    public double getFeature(int index, int featNum) {
        Instance i = allInstances.instance(index);
        if (i == null || i.numAttributes() < (featNum + numMetaData)) {
            return Double.NaN;
        }
        return i.value(featNum + numMetaData);
    }

    public double getParam(int index, int paramNum) {
        Instance i = allInstances.instance(index);
        if (i == null || i.numAttributes() < (numFeatures + numMetaData + paramNum)) {
            return Double.NaN;
        }
        if (i.isMissing(numMetaData + numFeatures + paramNum)) {
            return Double.NaN;
        }
        return i.value(numMetaData + numFeatures + paramNum);
    }

    public double getID(int index) {
        //   if (idMap.containsKey(index)) {
        if (index >= 0 && index < allInstances.numInstances()) {

            //Instance i = idMap.get(index);
            Instance in = allInstances.instance(index);
            if (in != null) {
                return in.value(idIndex);
            }
        }
        return 0;
    }

    public double getTimestamp(int index) {
        //   if (idMap.containsKey(index)) {
        if (index >= 0 && index < allInstances.numInstances()) {

            //Instance i = idMap.get(index);
            Instance in = allInstances.instance(index);
            if (in != null) {
                return in.value(timestampIndex);
            }
        }
        return 0;
    }

    public void setTimestamp(int index, String timestamp) throws ParseException {
        if (index >= 0 && index < allInstances.numInstances()) {
            Instance in = allInstances.instance(index);
            if (in != null) {
                Date d = prettyDateFormat.parse(timestamp);
                in.setValue(timestampIndex, Double.parseDouble(dateFormat.format(d)));
                return;
            }
        }
    //Else throw exception? TODO
    }

    public int getTrainingRound(int index) {
        if (index >= 0 && index < allInstances.numInstances()) {

            //Instance i = idMap.get(index);
            Instance in = allInstances.instance(index);
            if (in != null) {
                return (int) in.value(trainingIndex);
            }
        }
        return -1;
    }

    public void setTrainingRound(int index, int round) {
        Instance in = allInstances.instance(index);
        if (in != null) {
            in.setValue(trainingIndex, round);
            if (round > currentTrainingRound) {
                currentTrainingRound = round + 1;
            }
        }


    }

    /**
     *
     * @param index the Instance ID
     * @return an array of all parameter values
     */
    public double[] getParameters(int index) {
        if (index >= 0 && index < allInstances.numInstances()) {
            Instance i = allInstances.instance(index);
            paramsFilter.input(i);
            Instance ii = paramsFilter.output();
            return ii.toDoubleArray();
        } else {
            System.out.println("No such index found" + index);
            return null;
        }
    }

    //TODO: use this!
    public void startNewTrainingRound() {
        currentTrainingRound++;
    }

    //How do we handle missing features or missing parameters??
    public void addInstance(double[] featureVals, double paramVals[], boolean paramMask[], Date timeStamp) {

        if (featureVals == null || featureVals.length != numFeatures) {
            throw new IllegalArgumentException("Wrong feature vals");
        }
        if (paramVals == null || paramVals.length != numParams || paramMask == null || paramMask.length != numParams) {
            throw new IllegalArgumentException("Wrong parameter values or mask");
        }



        int thisId = nextID;
        nextID++;

        double myVals[] = new double[numMetaData + numFeatures + numParams];
        myVals[idIndex] = thisId;
        myVals[trainingIndex] = currentTrainingRound;
        myVals[timestampIndex] = Double.parseDouble(dateFormat.format(timeStamp));

        for (int i = 0; i < numFeatures; i++) {
            myVals[numMetaData + i] = featureVals[i];
        }

        for (int i = 0; i < numParams; i++) {
            if (isParamDiscrete[i] && (paramVals[i] < 0 || paramVals[i] >= numParamValues[i])) {
                throw new IllegalArgumentException("Invalid value for this discrete parameter");
            }

            myVals[numMetaData + numFeatures + i] = paramVals[i];
        }

        Instance in = new Instance(1.0, myVals);
        for (int i = 0; i < paramMask.length; i++) {
            if (!paramMask[i]) {
                in.setMissing(numMetaData + numFeatures + i);
            }
        }
        in.setDataset(allInstances);
        allInstances.add(in);



    // idMap.put(thisId, in);

    }

    public void addInstance(double[] featureVals, double paramVals[], Date timestamp) {
        boolean mask[] = new boolean[numParams];
        /*for (boolean m : mask) {
        m = false;
        System.out.println("added true");
        }*/
        for (int i = 0; i < mask.length; i++) {
            mask[i] = true;
        }
        addInstance(featureVals, paramVals, mask, timestamp);
    }

    public void addInstance(double[] featureVals, double paramVals[]) {
        Date now = new Date();
        addInstance(featureVals, paramVals, now);
    }

    /**
     *
     * @param index
     * @return true if deleted
     */
    public boolean deleteInstance(int index) {
        if (index >= 0 && index < allInstances.numInstances()) {
            allInstances.delete(index);
            return true;

        } else {
            return false;
        }
    }

    /**
     * Delete all instances (doesn't reset data like #feats, #params, etc.)
     */
    public void deleteAll() {
        allInstances.delete();
    }

    /**
     * 
     * @param c
     * @return a Weka Instances object corresponding to the learning problem for this parameter #
     */
    public Instances getClassifiableInstances(int paramNum) {
        if (paramNum < 0 || paramNum >= numParams) {
            throw new IllegalArgumentException("Invalid paramNum");
        }
        try {
            Instances in = Filter.useFilter(allInstances, paramFilters[paramNum]);
            in.setClassIndex(in.numAttributes() - 1);
            in.deleteWithMissingClass();
            return in;
        } catch (Exception ex) {
            Logger.getLogger(SimpleDataset.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public void setIsFeatureActiveForParameter(boolean isActive, int featNum, int paramNum) {
        if (featNum < 0 || featNum >= numFeatures || paramNum < 0 || paramNum >= numParams) {
            throw new IllegalArgumentException("Invalid paramNum or featNum");

        }

        if (featureParamMask[featNum][paramNum] != isActive) {
            featureParamMask[featNum][paramNum] = isActive;
            try {
                updateFilter(paramNum);
            } catch (Exception ex) {
                System.out.println("Error: Couldn't update filter");
                Logger.getLogger(SimpleDataset.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    //TODO
    //If not active, do we really want to delete it? Probably not; keep it around just in case.
    }

    public boolean isFeatureActiveForParameter(int featNum, int paramNum) {
        if (featNum < 0 || featNum >= numFeatures || paramNum < 0 || paramNum >= numParams) {
            System.out.println("Error: invalid featNum / paramNum");
            return false;
        }

        return featureParamMask[featNum][paramNum];
    }

    public void setFeatureName(int featureNum, String name) {
        if (featureNum >= 0 && featureNum < numFeatures) {
            featureNames[featureNum] = name;
        }
    }

    public String getFeatureName(int featureNum) {
        if (featureNum >= 0 && featureNum < numFeatures) {
            return featureNames[featureNum];
        }
        return null;
    }

    public void setParameterName(int paramNum, String name) {
        if (paramNum >= 0 && paramNum < numParams) {
            paramNames[paramNum] = name;
        }
    }

    public String getParameterName(int paramNum) {
        if (paramNum >= 0 && paramNum < numParams) {
            return paramNames[paramNum];
        }
        return null;
    }

    public boolean isParameterDiscrete(int paramNum) {
        if (paramNum >= 0 && paramNum < numParams) {
            return isParamDiscrete[paramNum];
        } else {
            return false;
        }
    }

    public int maxLegalDiscreteParamValue(int paramNum) {
        if (paramNum >= 0 && paramNum < numParams && isParamDiscrete[paramNum]) {
            return numParamValues[paramNum] - 1;
        }

        return -1; //TODO: something better?
    }

    public String datasetToString() {
        return allInstances.toString();
    }

    /**
     *
     * @param name
     * @param isDiscrete
     * @return the parameter number of this new param
     */
    /* public int addParameter(String name, boolean isDiscrete) {
    //TODO: create new instances, adjust bookkeeping variabless
    return 0;
    }*/
    /**
     *
     * @param name
     * @return the number of the new feature
     */
    /* public int addFeature(String name) {
    //TODO
    return 0;
    }*/
    public String dateDoubleToString(double d) { //TODO: test!
        Date date;
        try {
            date = dateFormat.parse(Double.toString(d));
            return prettyDateFormat.format(date);

        } catch (ParseException ex) {
            Logger.getLogger(SimpleDataset.class.getName()).log(Level.WARNING, "bad date", ex);
            System.out.println("Here");
            return "";
        }
    }

    public void exportAsArffFiles(String filePrefix) {
        //TODO: export arff files, 1 per parameter, as filePrefix_p1.arff ... filePrefix_pN.arff
    }

    public void exportAsArffFile(String filename) {
        //TODO: export arff file - 1 file, each param as an attribute, no class set
    }

    public void importFromArffFile(String filename) {
        //TODO: import from arff filename; 
    }

    //TODO: add
    /* raw audio support
     * ability to add metafeatures based on statistics of these features (esp.: moving average, time deltas)
     * 
     * */
    public static void main(String[] args) {
        boolean isDiscrete[] = {true, false};
        int numVals[] = {3, 3};
        String featureNames[] = {"F1", "f2", "F3", "f4", "f5"};
        String paramNames[] = {"P1", "p2"};
        SimpleDataset s = new SimpleDataset(5, 2, isDiscrete, numVals, featureNames, paramNames);

        double fvals[] = {1.0, 2.0, 3.0, 4.0, 5.0};
        double pvals[] = {0.0, 1.5};
        s.addInstance(fvals, pvals);

        double fvals2[] = {2.0, 2.0, 3.0, 4.0, 5.0};
        double pvals2[] = {2.0, 3.5};

        boolean mask1[] = {false, false};
        s.startNewTrainingRound();
        s.addInstance(fvals2, pvals2, mask1, new Date());

        s.setIsFeatureActiveForParameter(false, 1, 0);

        s.setIsFeatureActiveForParameter(false, 2, 0);

        //System.out.println(s.isFeatureActiveForParameter(1, 0));


        //       Instances i = s.getClassifiableInstances(1);
        //       System.out.println(i);

        /*      double newfvals[] = {2.0, 4.0, 6.0, 8.0, 10.0};
        Instance is[] = s.convertToClassifiableInstances(newfvals);
        for (int i =0; i < is.length; i++) {
        System.out.println(is[i]);
        System.out.println(is[i].classIndex());
        }*/

        System.out.println(s.datasetToString());

        /* System.out.println("Instance 0");

        double f[] = s.getFeatures(0);
        for (int i = 0; i < f.length; i++) {
        System.out.print(f[i] + " ");
        }
        System.out.println("");
        double p[] = s.getParameters(1); //TODO: Problem here: doesn't do ints right

        for (int i = 0; i < p.length; i++) {
        System.out.print(p[i] + " ");
        }
        System.out.println("");
        System.out.println(s.getTrainingRound(3));
        System.out.println(s.getTimestamp(3));
        double t = s.getTimestamp(3);
        System.out.println("String is " + s.dateDoubleToString(t));
         */

        /*Instances ii = s.getClassifiableInstances(1);
        System.out.println(ii);
         * */

        System.out.println("***");
        double[] d = s.getParameters(1);
        for (int i = 0; i < d.length; i++) {
            System.out.println(d[i]);
        }


    }
}