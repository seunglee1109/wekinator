/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package wekinator;

import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author rebecca
 */
public class HidSetup implements Serializable {

    private int numAxes = 0;
    private int numHats = 0;
    private int numButtons = 0;
    private float[] initAxes = new float[0];
    private int[] initHats = new int[0];
    private int[] initButtons = new int[0];
    private int[] axesMask = new int[0];
    private int[] hatsMask = new int[0];
    private int[] buttonsMask = new int[0];

    public HidSetup() {
        setHidState(HidState.NONE);
    }
    
    public enum HidState {

        NONE, SETUP_REQUESTED, SETUP_BEGUN, INIT_REQUESTED,
        INIT_DONE, SETTINGS_REQUESTED, SETTINGS_RECEIVED,
        SETUP_STOP_REQUESTED, SETUP_STOPPED, ERROR
    };

    protected HidState hidState = HidState.NONE;
    public static final String PROP_HIDSTATE = "hidState";
    protected boolean usable = false;
    public static final String PROP_USABLE = "usable";

    /**
     * Get the value of usable
     *
     * @return the value of usable
     */
    public boolean isUsable() {
        return usable;
    }

    /**
     * Set the value of usable
     *
     * @param usable new value of usable
     */
    private void setUsable(boolean usable) {
        boolean oldUsable = this.usable;
        this.usable = usable;
        propertyChangeSupport.firePropertyChange(PROP_USABLE, oldUsable, usable);
    }


    /**
     * Get the value of hidState
     *
     * @return the value of hidState
     */
    public HidState getHidState() {
        return hidState;
    }

    /**
     * Set the value of hidState
     *
     * @param hidState new value of hidState
     */
    private void setHidState(HidState hidState) {
        System.out.println("SOME hid state is being set to " + hidState);
        HidState oldHidState = this.hidState;
        this.hidState = hidState;
        propertyChangeSupport.firePropertyChange(PROP_HIDSTATE, oldHidState, hidState);
    }
    private PropertyChangeSupport propertyChangeSupport = new PropertyChangeSupport(this);

    /**
     * Add PropertyChangeListener.
     *
     * @param listener
     */
    public void addPropertyChangeListener(PropertyChangeListener listener) {
        propertyChangeSupport.addPropertyChangeListener(listener);
    }

    /**
     * Remove PropertyChangeListener.
     *
     * @param listener
     */
    public void removePropertyChangeListener(PropertyChangeListener listener) {
        propertyChangeSupport.removePropertyChangeListener(listener);
    }

    public String getStatusMessage() {
        switch (hidState) {
            case INIT_DONE:
                return "HID loaded from file successfully.";
            case INIT_REQUESTED:
                return "Communicating HID setup to ChucK.";
            case NONE:
                return "No HID set up.";
            case SETTINGS_RECEIVED:
                return "HID is set up.";
            case SETTINGS_REQUESTED:
                return "Requesting HID description from ChucK.";
            case SETUP_BEGUN:
                return "HID setup begun. Please engage all axes, buttons, and hats now.";
            case SETUP_REQUESTED:
                return "Trying to start HID setup.";
            case SETUP_STOP_REQUESTED:
                return "Stopping HID setup.";
            case SETUP_STOPPED:
                return "HID setup complete.";
            case ERROR:
                return "HID encountered an error";
        }
        return "unknown state";

    }

    /**
     * Request HidDiscoverer to start setup phase
     * @throws java.io.IOException
     */
    public void requestHidSetup() throws IOException {
        setHidState(HidState.SETUP_REQUESTED);
        setUsable(false);
        OscHandler.getOscHandler().requestHidSetup();
    }

    /**
     * Notify me that ChucK says hid setup has begun
     */
    public void setupBegun() {
        setHidState(HidState.SETUP_BEGUN);
    }

    /**
     * Request HidDiscoverer to stop setup phase
     * @throws java.io.IOException
     */
    public void requestSetupStop() throws IOException {
        System.out.println("Requested stop");
        setHidState(HidState.SETUP_STOP_REQUESTED);

        OscHandler.getOscHandler().requestHidSetupStop();

    }

    /**
     * Notify me that ChucK says setup has stopped
     * @throws java.io.IOException
     */
    public void setupStopped() throws IOException {
        setHidState(HidState.SETUP_STOPPED);
        startHidRequestSettings();
    }

    /**
     * Start HID init phase, for new device
     * @throws java.io.IOException
     */
    public void startHidInit() throws IOException {
        setUsable(false);
        setHidState(HidState.INIT_REQUESTED);
        OscHandler.getOscHandler().sendHidInit(numAxes, numHats, numButtons);
    }

    /**
     * Notify me that ChucK is waiting for init hid values
     * @throws java.io.IOException
     */
    public void receivedSendHidInitValues() throws IOException {
        if (hidState == HidState.INIT_REQUESTED) {
         setUsable(true);
        setHidState(HidState.INIT_DONE);

//        System.out.println("sending and #buttons is " + initButtons.length);
        OscHandler.getOscHandler().sendHidValues(initAxes, initHats, initButtons, axesMask, hatsMask, buttonsMask);
        System.out.println("state should be done now!");
        }
    }

    /**
     * Request current HID settings from HidDiscoverer
     * @throws java.io.IOException
     */
    public void startHidRequestSettings() throws IOException {
        setHidState(HidState.SETTINGS_REQUESTED);

        OscHandler.getOscHandler().sendHidSettingsRequest();
    }

    /**
     * Request that HidDiscoverer begin running, using current settings
     * @throws java.io.IOException
     */
    public void startHidRun() throws IOException {
        OscHandler.getOscHandler().startHidRun();
    }

    public boolean writeToFile(File f) {
        FileOutputStream outstream = null;
        ObjectOutputStream objout = null;
        boolean success = false;
        try {
            outstream = new FileOutputStream(f);
            objout = new ObjectOutputStream(outstream);
            objout.writeObject(this);
            success = true;
        } catch (FileNotFoundException ex) {
            Logger.getLogger(HidSetup.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(HidSetup.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (objout != null) {
                    objout.close();
                }
                if (outstream != null) {
                    outstream.close();
                }
            } catch (IOException ex) {
                Logger.getLogger(HidSetup.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return success;
    }

    public static HidSetup readFromFile(File f) {
        FileInputStream instream = null;
        ObjectInputStream objin = null;
        HidSetup setup = null;
        try {
            instream = new FileInputStream(f);
            objin = new ObjectInputStream(instream);
            setup = (HidSetup) objin.readObject();
        } catch (FileNotFoundException ex) {
            Logger.getLogger(HidSetup.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(HidSetup.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(HidSetup.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (objin != null) {
                    objin.close();
                }
                if (instream != null) {
                    instream.close();
                }
            } catch (IOException ex) {
                Logger.getLogger(HidSetup.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
        return setup;
    }

    public String print(int a[]) {
        String s = "";
        for (int i = 0; i < a.length; i++) {
            s += Integer.toString(a[i]);
        }
        return s;
    }

    public int getNumAxesTotal() {
        return initAxes.length;
    }

    public int getNumHatsTotal() {
        return initHats.length;
    }

    public int getNumButtonsTotal() {
        return initButtons.length;
    }

    public int getNumAxesReal() {
        int s = 0;
        for (int i = 0; i < axesMask.length; i++) {
            s += axesMask[i];
        }
        return s;
    }

    public int getNumHatsReal() {
        int s = 0;
        for (int i = 0; i < hatsMask.length; i++) {
            s += hatsMask[i];
        }
        return s;
    }

    public int getNumButtonsReal() {
        int s = 0;
        for (int i = 0; i < buttonsMask.length; i++) {
            s += buttonsMask[i];
        }
        return s;
    }

    public int getNumFeaturesUsed() {
       return getNumAxesReal() + getNumHatsReal() + getNumButtonsReal();
        //tmptmp
       // return 1;
    }

    public float[] getInitAxes() {
        return initAxes;
    }

    public int[] getInitHats() {
        return initHats;
    }

    public int[] getInitButtons() {
        return initButtons;
    }

    void receivedHidSettingsAll(Object[] o) {
        setUsable(false);

        System.out.println("In received hid settings all!");
        if (o.length < 3) {
            System.out.println("Error: too short o");
            setHidState(HidState.ERROR);
            return;
        }
        if (!(o[0] instanceof Integer && o[1] instanceof Integer && o[2] instanceof Integer)) {
            System.out.println("Error: wrong args to o");
            setHidState(HidState.ERROR);
            return;
        }
        numAxes = (Integer) o[0];
        numHats = (Integer) o[1];
        numButtons = (Integer) o[2];
        axesMask = new int[numAxes];
        hatsMask = new int[numHats];
        buttonsMask = new int[numButtons];
        initAxes = new float[numAxes];
        initHats = new int[numHats];
        initButtons = new int[numButtons];

        if (o.length != 3 + numAxes * 2 + numHats * 2 + numButtons * 2) {
            System.out.println("Expecting different length of o: it's " + o.length);
            System.out.println("Expected " + 3 + numAxes * 2 + numHats * 2 + numButtons * 2);
            System.out.println("Wrong num hid args received");
            setHidState(HidState.ERROR);
                        return;
        }

        for (int i = 0; i < numAxes; i++) {
            if (!(o[3 + i] instanceof Float)) {
                System.out.println("Expected axis val float");
            }
            initAxes[i] = (Float) o[3 + i];
        }
        for (int i = 0; i < numHats; i++) {
            if (!(o[3 + numAxes + i] instanceof Integer)) {
                System.out.println("Expected hat val int");
            }
            initHats[i] = (Integer) o[3 + numAxes + i];
        }
        for (int i = 0; i < numButtons; i++) {
            if (!(o[3 + numAxes + numHats + i] instanceof Integer)) {
                System.out.println("Expected but val int");
            }
            initButtons[i] = (Integer) o[3 + numAxes + numHats + i];
        }

        //Now mask: axes, hats buttons
        int startMask = 3 + numAxes + numHats + numButtons;
        for (int i = 0; i < numAxes; i++) {
            if (!(o[startMask + i] instanceof Integer)) {
                System.out.println("Expected axis mask int");
            }
            axesMask[i] = (Integer) o[startMask + i];
        }
        for (int i = 0; i < numHats; i++) {
            if (!(o[startMask + numAxes + i] instanceof Integer)) {
                System.out.println("Expected hats mask int");
            }
            hatsMask[i] = (Integer) o[startMask + numAxes + i];
        }
        for (int i = 0; i < numButtons; i++) {
            if (!(o[startMask + numAxes + numHats + i] instanceof Integer)) {
                System.out.println("Expected buttons mask int");
            }
            buttonsMask[i] = (Integer) o[startMask + numAxes + numHats + i];
        }
        setUsable(true);
        setHidState(HidState.SETTINGS_RECEIVED);
    }

    public String getDescription() {
        if (isUsable()) {
        float a[] = getInitAxes();
        int b[] = getInitHats();
        int c[] = getInitButtons();
        String aa = "";
        String bb = "";
        String cc = "";
        for (int i = 0; i < a.length; i++) {
            aa += Float.toString(a[i]) + " ";
        }
        for (int i = 0; i < b.length; i++) {
            bb += Integer.toString(b[i]) + " ";
        }
        for (int i = 0; i < c.length; i++) {
            cc += Integer.toString(c[i]) + " ";
        }

        String s = getNumAxesReal() + " axes, " + getNumHatsReal() + " hats," + getNumButtonsReal() + " buttons";
        return s;
        } else {
            return "No HID set up.";
        }
    }
}