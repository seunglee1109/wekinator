/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package wekinator.LearningAlgorithms;

import be.ac.ulg.montefiore.run.jahmm.Hmm;
import be.ac.ulg.montefiore.run.jahmm.ObservationDiscrete;
import be.ac.ulg.montefiore.run.jahmm.ObservationVector;
import be.ac.ulg.montefiore.run.jahmm.OpdfMultiGaussian;
import be.ac.ulg.montefiore.run.jahmm.OpdfMultiGaussianFactory;
import be.ac.ulg.montefiore.run.jahmm.learn.BaumWelchLearner;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import weka.core.Instance;
import weka.core.Instances;

/**
 *
 * @author rebecca
 */
public class HmmLearningAlgorithm extends LearningAlgorithm {

    protected int numStates;
   // protected Instance[] buffer = null;
    protected ArrayDeque<Instance> buffer = new ArrayDeque<Instance>();
    protected int buffSize = 10;
    protected List<Hmm<ObservationVector>> hmms = null;

    @Override
    public LearningAlgorithm copy() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public LearningAlgorithmSettingsPanel getSettingsPanel() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public String getName() {
        return "HMM";
    }

    @Override
    public double classify(Instance instance) throws Exception {
        double[] d = distributionForInstance(instance);
        double max = -1.0;
        int maxIndex = 0;
        for (int i = 0; i < d.length; i++) {
            if (d[i] > max) {
                max = d[i];
                maxIndex = i;
            }
        }
        return maxIndex;
    }

    protected List<ObservationVector> getUpdatedSequence(Instance instance) {
        return new LinkedList<ObservationVector>();
    }

    @Override
    public double[] distributionForInstance(Instance instance) throws Exception {
        double[] probs = new double[hmms.size()];
        for (int i = 0; i < probs.length; i++) {
            probs[i] = hmms.get(i).probability(getUpdatedSequence(instance));
        }
        return probs;
    }

    @Override
    public void train(Instances instances) throws Exception {
        if (instances.numInstances() == 0) {
            return;
        }
        int numFeats = instances.numAttributes() - 1;
        int numClassValues = 5; //HACK ABC
        if (hmms == null) {
            hmms = new ArrayList<Hmm<ObservationVector>>(numClassValues);
        }
        while (hmms.size() < numClassValues) {
            hmms.add(null);
        }
        while (hmms.size() > numClassValues) {
            hmms.remove(hmms.size()-1);
        }

        TrainingState backupState = this.trainingState;
        setTrainingState(TrainingState.TRAINING);
        List<Hmm<ObservationVector>> backups = new ArrayList<Hmm<ObservationVector>>(numClassValues);
        for (int i = 0; i < hmms.size(); i++) {
              backups.add(hmms.get(i));
        }

        try {
            List<List<List<ObservationVector>>> sequences = getSequences(instances);
            for (int i = 0; i < numClassValues; i++) {
                Hmm<ObservationVector> initHmm = new Hmm<ObservationVector>(numStates, new OpdfMultiGaussianFactory(numFeats));
                BaumWelchLearner bwl = new BaumWelchLearner();
                hmms.set(i, bwl.learn(initHmm, sequences.get(i)));
            }

            setTrainingState(TrainingState.TRAINED);
        } catch (Exception ex) {
            hmms = backups;
            setTrainingState(backupState);
            throw ex;
        }
    }

    protected List<List<List<ObservationVector>>> getSequences(Instances instances) {
        // List<vector> is a single sequence
        // List<List<vector>> is a set of sequences
        // we have a set of sequences for each param class

        //// return new LinkedList<new LinkedList<ObservationVector>>();
        //  LinkedList<ObservationVector> l1 = new LinkedList<ObservationVector>();
        List<List<List<ObservationVector>>> l2 = new LinkedList<List<List<ObservationVector>>>();
        //for each parameter, a

        return l2;
    }

    @Override
    public void forget() {
        hmms = null;
        setTrainingState(trainingState.NOT_TRAINED);
    }

    @Override
    public double computeAccuracy(Instances instances) throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public double computeCVAccuracy(int numFolds, Instances instances) throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void writeToOutputStream(ObjectOutputStream o) throws IOException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public int getNumStates() {
        return numStates;
    }

    public void setNumStates(int n) {
        numStates = n;
    }

    public int getBuffSize() {
        return buffSize;
    }

    public void setBuffSize(int b) {
        buffSize = b;
     //   buffer = new Instance[b];
    }
}
