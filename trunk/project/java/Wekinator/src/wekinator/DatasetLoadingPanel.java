/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * DatasetLoadingPanel.java
 *
 * Created on Dec 3, 2009, 5:11:23 PM
 */
package wekinator;

import java.io.File;
import java.io.IOException;
import java.io.OptionalDataException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import wekinator.util.Util;

/**
 *
 * @author rebecca
 */
public class DatasetLoadingPanel extends javax.swing.JPanel {

    SimpleDataset currentDataset = null;
    SimpleDataset loadedDataset = null;

    /** Creates new form DatasetLoadingPanel */
    public DatasetLoadingPanel() {
        initComponents();
        updateCurrentDatasetText();
        updateLoadedDatasetText();
    }

    public DatasetLoadingPanel(SimpleDataset s) {
        initComponents();
        setCurrentDataset(s);
        updateLoadedDatasetText();
    }

    public SimpleDataset getProposedDatasetNoncommittal() {
        SimpleDataset s = null;
        if (radioUseCurrent.isSelected()) {
            if (currentDataset != null) {
                s = currentDataset;
            } else {
                //Create one!
                s = createNewDataset();

            }
        } else {
            s = loadedDataset;
        }
        return s;
    }

    protected SimpleDataset createNewDataset() {
        SimpleDataset s = new SimpleDataset(
                WekinatorLearningManager.getInstance().getFeatureConfiguration().getNumFeaturesEnabled(),
                ChuckSystem.getChuckSystem().getNumParams(),
                ChuckSystem.getChuckSystem().isParamDiscrete,
                ChuckSystem.getChuckSystem().getNumSynthMaxParamVals(),
                WekinatorLearningManager.getInstance().getFeatureConfiguration().getAllEnabledFeatureNames(),
                ChuckSystem.getChuckSystem().getParamNames());
        return s;
    }

    public SimpleDataset commitAndGetSelectedDataset() {

        if (radioUseCurrent.isSelected()) {
            if (currentDataset != null) {
                return currentDataset;
            } else {
                //Create one!
                SimpleDataset s = createNewDataset();
                setCurrentDataset(s);
            }
        } else {
            setCurrentDataset(loadedDataset);
            setLoadedDataset(null); //TODO TODO TODO: Manage this case with flag that file usable
        }
        return currentDataset;

    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        buttonGroup1 = new javax.swing.ButtonGroup();
        radioUseCurrent = new javax.swing.JRadioButton();
        radioUseFile = new javax.swing.JRadioButton();
        buttonChooseFile = new javax.swing.JButton();
        labelCurrent = new javax.swing.JLabel();
        labelFile = new javax.swing.JLabel();
        jLabel1 = new javax.swing.JLabel();

        buttonGroup1.add(radioUseCurrent);
        radioUseCurrent.setSelected(true);
        radioUseCurrent.setText("Use current dataset");
        radioUseCurrent.setVerticalTextPosition(javax.swing.SwingConstants.BOTTOM);

        buttonGroup1.add(radioUseFile);
        radioUseFile.setText("Use dataset from file");
        radioUseFile.setEnabled(false);
        radioUseFile.setVerticalTextPosition(javax.swing.SwingConstants.BOTTOM);

        buttonChooseFile.setText("Choose file...");
        buttonChooseFile.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonChooseFileActionPerformed(evt);
            }
        });

        labelCurrent.setText(": 150 datapoints recorded");

        labelFile.setText(": 150 datapoints recorded");
        labelFile.setEnabled(false);

        jLabel1.setFont(new java.awt.Font("Lucida Grande", 1, 13)); // NOI18N
        jLabel1.setText("Configure dataset");

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(layout.createSequentialGroup()
                        .addContainerGap()
                        .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(layout.createSequentialGroup()
                                .add(27, 27, 27)
                                .add(buttonChooseFile))
                            .add(layout.createSequentialGroup()
                                .add(radioUseCurrent)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(labelCurrent))
                            .add(layout.createSequentialGroup()
                                .add(radioUseFile)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(labelFile))))
                    .add(jLabel1))
                .addContainerGap(150, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .add(jLabel1)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(radioUseCurrent)
                    .add(labelCurrent))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(radioUseFile)
                    .add(labelFile))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(buttonChooseFile)
                .addContainerGap(org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void buttonChooseFileActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonChooseFileActionPerformed
        loadDatasetFromFile();
}//GEN-LAST:event_buttonChooseFileActionPerformed

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton buttonChooseFile;
    private javax.swing.ButtonGroup buttonGroup1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel labelCurrent;
    private javax.swing.JLabel labelFile;
    private javax.swing.JRadioButton radioUseCurrent;
    private javax.swing.JRadioButton radioUseFile;
    // End of variables declaration//GEN-END:variables

    public void setCurrentDataset(SimpleDataset s) {
        currentDataset = s;
        updateCurrentDatasetText();
    }

    protected void setLoadedDataset(SimpleDataset s) {
        loadedDataset = s;
        updateLoadedDatasetText();
        boolean isNull = (s == null);
        radioUseFile.setEnabled(!isNull);
        labelFile.setEnabled(!isNull);
        if (isNull) {
            radioUseCurrent.setEnabled(true);
        }
    }

    public void setCurrentDatasetSelected() {
        radioUseCurrent.setSelected(true);
    }

    //TODO: bind to current dataset? Or make sure to set current every time this is displayed.
    protected void updateCurrentDatasetText() {
        if (currentDataset == null) {
            radioUseCurrent.setText("Create new dataset");
            labelCurrent.setText("");
        } else {
            radioUseCurrent.setText("Use current dataset");
            labelCurrent.setText(": " + currentDataset.getNumDatapoints() + " examples recorded");
        }
    }

    protected void updateLoadedDatasetText() {
        radioUseFile.setText("Use dataset from file");
        if (loadedDataset == null) {
            labelFile.setText(": No file loaded");
        } else {
            labelFile.setText(": " + loadedDataset.getNumDatapoints() + " examples recorded");
        }
    }

    private void loadDatasetFromFile() {

        File f = chooseLoadFile();
        if (f == null) {
            return;
        }

        SimpleDataset s = null;
        Exception e = null;
        boolean success = false;
        try {
            s = SimpleDataset.readFromFile(f);
            success = true;
        } catch (Exception ex) {
            e = ex;
        }

        if (!success) {
            s = createNewDataset();
            try {
                s.loadInstancesFromArff(f);
                success = true;
            } catch (IOException ex) {
                e = ex;
            }
        }
        if (!success) {
            if (e != null && e instanceof OptionalDataException) {
                Logger.getLogger(DatasetLoadingPanel.class.getName()).log(Level.SEVERE, null, e);
                JOptionPane.showMessageDialog(this, "Invalid dataset file", "Could not load dataset from file", JOptionPane.ERROR_MESSAGE);
                return;
            } else if (e != null) {

                Logger.getLogger(DatasetLoadingPanel.class.getName()).log(Level.SEVERE, null, e);
                JOptionPane.showMessageDialog(this, "Could not load dataset from file: " + e.getMessage(), "Could not load dataset from file", JOptionPane.ERROR_MESSAGE);
                return;
            }
            Logger.getLogger(DatasetLoadingPanel.class.getName()).log(Level.SEVERE, null, e);
            JOptionPane.showMessageDialog(this, "Could not load dataset from file for unspecified reason", "Could not load dataset from file for unspecified reason", JOptionPane.ERROR_MESSAGE);
            return;

        }
        if (s != null) {
            //TODO: Ultimately ensure no null problems here! (e.g. null featureconfiguration)
            if (s.getNumFeatures() != WekinatorLearningManager.getInstance().getFeatureConfiguration().getNumFeaturesEnabled()) {
                JOptionPane.showMessageDialog(this, "The number of features of this dataset does not match the number of features currently being extracted.", "Dataset not usable", JOptionPane.ERROR_MESSAGE);
                return;
            }

            ChuckSystem cs = ChuckSystem.getChuckSystem();
            if (s.getNumParameters() != cs.getNumParams()) {
                JOptionPane.showMessageDialog(this, "The number of parameters of this dataset does not match the number of parameters used by your current synth.", "Dataset not usable", JOptionPane.ERROR_MESSAGE);
                return;
            }

            boolean[] isPDiscrete = cs.isIsParamDiscrete();
            int[] maxClasses = cs.getNumSynthMaxParamVals();
            for (int i = 0; i < isPDiscrete.length; i++) {
                if (isPDiscrete[i] != s.isParameterDiscrete(i)) {
                    JOptionPane.showMessageDialog(this, "The type of parameters used in this dataset does not match the type of parameters used by your current synth - mismatch of real/discrete parameter number " + i, "Dataset not usable", JOptionPane.ERROR_MESSAGE);
                    return;
                }
                //TODO: Fix this to give warning instead of error
                //If loaded dataset has values too high, delete those rows
                //If loaded dataset has values too low, expand ceiling
                if (isPDiscrete[i] && (maxClasses[i] != s.getMaxLegalDiscreteParamValues()[i])) {
                    JOptionPane.showMessageDialog(this, "The type of parameters used in this dataset does not match the type of parameters used by your current synth - mismatch of # of legal parameter values", "Dataset not usable", JOptionPane.ERROR_MESSAGE);
                    return;
                }
            }

            String[] currentFeats = WekinatorLearningManager.getInstance().getFeatureConfiguration().getAllEnabledFeatureNames();
            String[] dbFeats = s.getFeatureNames();
            String warning = "There is a mismatch between the following features being extracted and the features stored in the dataset:\n";
            int numMismatch = 0;
            for (int i = 0; i < currentFeats.length; i++) {
                if (!currentFeats[i].equalsIgnoreCase(dbFeats[i])) {
                    numMismatch++;
                    warning += currentFeats[i] + " != " + dbFeats[i] + "\n";
                }
            }
            if (numMismatch > 0) {
                warning += "Proceed anyway?";
                int response = JOptionPane.showConfirmDialog(this,
                        warning, "",
                        JOptionPane.YES_NO_OPTION);

                if (response != JOptionPane.YES_OPTION) {
                    return;
                }
            }

            String[] currentParams = cs.getParamNames();
            String[] dbNames = s.getParameterNames();
            warning = "There is a mismatch between the following parameters being used and the parameters stored in the dataset:\n";
            numMismatch = 0;
            for (int i = 0; i < currentParams.length; i++) {
                if (!currentParams[i].equalsIgnoreCase(dbNames[i])) {
                    numMismatch++;
                    warning += currentParams[i] + " != " + dbNames[i] + "\n";
                }
            }
            if (numMismatch > 0) {
                warning += "Proceed anyway?";
                int response = JOptionPane.showConfirmDialog(this,
                        warning, "",
                        JOptionPane.YES_NO_OPTION);

                if (response != JOptionPane.YES_OPTION) {
                    return;
                }
            }

            //Made it here? Then we're good to go.
            setLoadedDataset(s);
            radioUseFile.setSelected(true);
        }
    }

    private File chooseLoadFile() {
        WekinatorInstance wek = WekinatorInstance.getWekinatorInstance();
        JFileChooser fc = new JFileChooser();
        fc.setFileSelectionMode(JFileChooser.FILES_ONLY);
        String location = wek.getSettings().getLastClassifierFileLocation();
        if (location == null || location.equals("")) {
            location = wek.getSettings().getDefaultClassifierFileLocation();
        }
        fc.setCurrentDirectory(new File(location)); //TODO: Could set directory vs file here according to above results

        boolean success = true;
        File file = null;
        int returnVal = fc.showOpenDialog(this);

        if (returnVal == JFileChooser.APPROVE_OPTION) {
            file = fc.getSelectedFile();
        }
        if (file != null) {
            wek.getSettings().setLastClassifierFileLocation(Util.getCanonicalPath(file));
        }
        return file;
    }

    public static void main(String[] args) {
        JFrame f = new JFrame();
        DatasetLoadingPanel p = new DatasetLoadingPanel();
        boolean[] isParamDiscrete = {true, true};
        int[] numParamValues = {5, 3};
        String[] featureNames = {"F1", "F2", "F3", "F4", "F5"};
        String[] paramNames = {"p1", "p2"};
        SimpleDataset s = new SimpleDataset(5, 2, isParamDiscrete, numParamValues, featureNames, paramNames);
        try {
            s.writeToFile(new File("tmp.dataset"));
        } catch (Exception ex) {
            Logger.getLogger(DatasetLoadingPanel.class.getName()).log(Level.SEVERE, null, ex);
        }

        p.setCurrentDataset(s);

        FeatureConfiguration fc = new FeatureConfiguration();
        fc.setUseCustomOscFeatures(true);
        fc.setNumCustomOscFeatures(5);

        WekinatorLearningManager.getInstance().setFeatureConfiguration(fc);

        f.add(p);
        f.setVisible(true);

    }
}
