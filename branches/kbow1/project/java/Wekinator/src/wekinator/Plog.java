/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package wekinator;

import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import wekinator.LearningAlgorithms.LearningAlgorithm;
import wekinator.WekinatorLearningManager.Mode;

/**
 *
 * @author rebecca
 */
public class Plog {
    protected static final Plog ref = new Plog();

    static FileWriter fw = null;
    static PrintWriter p = null;
    static FileWriter rfw = null;
    static PrintWriter r = null;
    static int runRound = 0;
    static String logDir = null;
    static String filename = null;
    static String rfilename = null;
    public static boolean isLogging = true;
    static int lsNum = 0;
    static int fcNum = 0;

    private Plog() {
        
    }
     

    protected static void lmChanged(PropertyChangeEvent evt) {
        System.out.println("plog got prop change");
        /* if (evt.getPropertyName().equals(WekinatorLearningManager.PROP_MODE)) {
            WekinatorLearningManager.Mode oldmode = (WekinatorLearningManager.Mode)evt.getOldValue();
                        WekinatorLearningManager.Mode newMode = (WekinatorLearningManager.Mode)evt.getNewValue();
            if (newMode == Mode.RUNNING && oldmode != Mode.RUNNING) {
                    runStart();
            } else if (oldmode == Mode.RUNNING && newMode != Mode.RUNNING) {
                log(Msg.RUN_STOP);
            } else if (newMode == Mode.TRAINING && oldmode != Mode.TRAINING) {
                trainStarted(WekinatorLearningManager.getInstance().getTrainingMask());
            } else if (oldmode == Mode.TRAINING && newMode != Mode.TRAINING) {
                trainCompleted();
            }
        } */
    }
    

    public static void log(Msg which) {
        log(which, "");
    }

    public enum Msg {
        LOAD,
        NEW_SESSION,
        RESET,
        CLOSE,
        CHUCK_CONFIG_EDIT_BUTTON,
        CHUCK_CONFIG_LOAD_BUTTON,
        CHUCK_CONFIG_LOADED,
        CHUCK_CONFIG_SAVE_BUTTON,
        CHUCK_CONFIG_SAVED,
        CHUCK_CONFIG_CANCEL_BUTTON,
        CHUCK_CONFIG_OK_BUTTON,
        CHUCK_CONFIG_SELECTED,
        CHUCK_RUN_BUTTON,
        CHUCK_STOP_BUTTON,
        CHUCK_RUNNER_STATE_NOT,
        CHUCK_RUNNER_STATE_TRYING,
        CHUCK_RUNNER_STATE_RUNNING,
        OSC_CONNECT_BUTTON,
        OSC_DISCONNNECT_BUTTON,
        OSC_STATE_NOT_CONNECTED,
        OSC_STATE_CONNECTING,
        OSC_STATE_CONNECTED,
        OSC_STATE_FAIL,
        FEAT_CONF_LOAD_BUTTON,
        FEAT_CONF_SAVE_BUTTON,
        FEAT_CONF_LOADED,
        FEAT_CONF_SAVED,
        FEAT_CONF_SET,
        DATASET_FILE_CHOOSE_BUTTON,
        DATASET_FILE_LOADED,
        DATASET_FILE_ERROR,
        LEARNING_SYSTEM_LOAD_BUTTON,
        LEARNING_SYSTEM_LOADED,
        LEARNING_SYSTEM_SET,
        LEARNING_ALGORITHM_SET_WITH_LS,
        PANEL_COLLECT_VIEWED,
        PANEL_TRAIN_VIEWED,
        PANEL_RUN_VIEWED,
        PANEL_CONFIG_VIEWED,
        SCORE_START_BUTTON,
        SCORE_STOP_BUTTON,
        AUDIO_OFF_BUTTON,
        SYNTH_PLAY_THESE_SELECTED,
        SYNTH_SEND_HERE_SELECTED,
        SYNTH_PLAY_ON_DEMAND_SELECTED,
        SYNTH_NOTHING_SELECTED,
        BUTTON_PLAY_HIT,
        PARAM_MASK_EDITED,
        PARAM_VALUES_CHANGED, //TODO: make sure happens w/ playalong too? can differentiate?
        PARAM_CLIPBOARD_ADDED_IN_PANEL,
        PARAM_CLIPBOARD_VIEWED,
        PARAM_CLIPBOARD_LISTENED,
        PARAM_CLIPBOARD_ADDED_IN_CLIPBOARD,
        PARAM_CLIPBOARD_DELETE,
        PARAM_CLIPBOARD_REARRANGED,
        PARAM_CLIPBOARD_CLOSED,
        BUTTON_RECORD_START,
        BUTTON_RECORD_STOP,
        DATASET_CLEARED,
        DATA_VIEWER_OPENED,
        DATA_VIWER_DELETE_SELECTED, //include # deleted
        DATA_VIEWER_ADD_ROW,
        DATA_VIEWER_LISTEN,
        DATA_VIEWER_SAVE_ARFF_BUTTON,
        DATA_VIEWER_DONE,
        DATA_VIEWER_DATA_EDITED,
        BUTTON_UNTRAIN,
        BUTTON_TRAIN_CANCELLED, //special: still log stuff! -- log ls so far & training data
        TRAIN_STARTED, //special
        TRAIN_FINISHED, //special
        BUTTON_RUN_START,
        BUTTON_RUN_STOP, // TODO: really want to be recording these examples... sigh... TODO TODO TODO Can I create another simple-ish dataset??
        RUN_START, //special
        RUN_STOP,

        FEATURE_VIEWER_OPENED,
        FEATURE_VIEWER_CLOSED,
        FEATURE_VIEWER_STARTED,
        FEATURE_VIEWER_STOPPED,
        MENU_STUFF, //TODO
                ERROR


    };

    public static void setWekinatorLearningManager(WekinatorLearningManager lm) {
        lm.addPropertyChangeListener(new PropertyChangeListener() {
            public void propertyChange(PropertyChangeEvent evt) {
                lmChanged(evt);
            }
        });
    }

    public static void setup(String parentDir) throws IOException {
            
    
        filename = parentDir + File.separator + "log.txt";
            rfilename = parentDir + File.separator + "run.txt";
            logDir = parentDir + File.separator;
            fw = new FileWriter(filename, true);
            p = new PrintWriter(fw);
            rfw = new FileWriter(rfilename, true);
            r = new PrintWriter(rfw);
            log(Msg.NEW_SESSION);
            resetRun();
            
    }

    public static void startPlog() {
        try {
            p.close();
            fw.close();
            fw = new FileWriter(filename, false);
            p = new PrintWriter(fw);
            log(Msg.RESET);
            resetRun();
        } catch (Exception ex) {
            System.out.println("problem starting log.");
        }
    }

    private static void resetRun() {
        r.println(ts() + ",#RESET#");
        runRound = 0;
    }

    public static void close() throws IOException {
        p.flush();
        p.close();
        fw.close();
    }

    protected static String ts() {
        return Long.toString((new Date()).getTime());
    }

    public static void log(Msg which, String m) {


        p.println(ts() + "," +  which.ordinal() + "," + which + "," + m);
    }

    public static void featConfigSet(FeatureConfiguration f) {
        //log feat config properties as well as save to file
    }

    public static void lsSet(LearningSystem l) {
        //log ls properties, including each algorithm and which feature used; save to file
    }

    public static void datasetLoaded(SimpleDataset d) {
        //log dataset properties (# instances), save to file
    }

    public static void chuckConfigSet(ChuckConfiguration c) {

    }

    public void learningAlgorithmSet(LearningAlgorithm la, int paramNum) {

    }

    public static void trainStarted(boolean[] trainMask) {
      /*  String s = "MASK=(";
        for (int i = 0; i < trainMask.length; i++) {
            s += trainMask[i] + ",";
        }
        s += ")";
        log(Msg.TRAIN_STARTED, s); */
    }

    public static void trainCompleted() {
       /* //save ls and dataset so I can compute train error later and eval against other learners
        lsNum++;
        log(Msg.TRAIN_FINISHED, "" + lsNum);
        saveLearningSystem(lsNum, WekinatorInstance.getWekinatorInstance().getLearningSystem()); */
    }

    protected static void saveLearningSystem(int num, LearningSystem ls) {
      /* File f = new File(logDir + "ls" + num + ".log");
        try {
            ls.writeToFile(f);
        } catch (IOException ex) {
            log(Msg.ERROR, "Couldn't write ls number " + num + " to file: " + ex.getMessage());
        } */
    }

    public static void paramClipboardUsed() {
        //log contents of clipboard
    }

    public static void beginRecording(boolean[] paramMask) {
        //log when, mask
    }

    public static void stopRecording(SimpleDataset d) {
        //log # examples now

    }

    protected void popupError(String err) {
       // JOptionPane er = new JOptionPane("Error with logging!" + err, JOptionPane.ERROR_MESSAGE);
       // er.sho
        JOptionPane.showMessageDialog(null, err, "Error with logging!", JOptionPane.ERROR_MESSAGE );
    }

    public static void runStart() {
        runRound++;
        log(Msg.RUN_START, runRound + "," + lsNum);
    }

    public static void runStep(double[] features, double[] params) {
        //Really want to log this in a file; 1 file per run round.
        r.print(ts() + "," + "RunRound," + runRound + ",numFeats," + features.length + ",numParams," + params.length);
        for (int j = 0; j < features.length; j++) {
            r.print("," + features[j]);
        }
        for (int j = 0; j < params.length; j++) {
            r.print("," + params[j]);
        }
        r.print("\n");
    }

    public  static void evalStart(int paramNum, boolean isCV, int numFolds) {

    }

    public static void evalFinish(int paramNum, boolean isCV, int numFolds, int results) { //need better results rep and indication of whether canceled

    }


}
