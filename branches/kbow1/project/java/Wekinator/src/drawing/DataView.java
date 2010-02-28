/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package drawing;
import drawing.TrackSet.ClickState;
import processing.core.*;

/**
 *
 * @author rebecca
 */
public class DataView {
    public int width = 0, height = 0;
    public PApplet p = null;
    public TrackSet ts = null;
    public ClassSelector cs = null;
    Region tsRegion = null;
    Region csRegion = null;
    
    public int vSpace = 10;
    public int hSpace = 10;
   
    public int tsWidth = 100;
    public int tsHeight = 20;
    public int csWidth = 40;
    public int csHeight = 200;
    float[] hues;
    int numClasses = 0;
    float[][] data = null;
    int[][] labels = null;

    void processMouseClick(int mouseX, int mouseY, int mouseButton) {
       /* if (clickState == ClickState.NONE && mouseButton == PApplet.LEFT) {
            //look for left click
        } else if (clickState == ClickState.L_LABEL && mouseButto
        *
        * */
        if (tsRegion.inRegion(mouseX, mouseY)) {
            ts.processMouseClick(mouseX - tsRegion.x1, mouseY-tsRegion.y1, mouseButton);
        } else if (csRegion.inRegion(mouseX, mouseY)) {
            int clicked = cs.processMouseClick(mouseX-csRegion.x1, mouseY-csRegion.y1, mouseButton);
            if (ts.clickState == ClickState.LR_LABEL) {
               changeLabels(ts.selectedTrack, ts.getSelectedMin(), ts.getSelectedMax(), clicked);
            }
        }
    }

    public DataView(int w, int h, int numTracks, int numLabels, int numClasses, int numPoints, PApplet app) {
        p = app;
        width = w;
        height = h;
        tsWidth = (int)(w - 3 * hSpace - ClassSelector.getPreferredWidth());
        tsHeight = (int)(h - 2 * vSpace);
        csWidth = ClassSelector.getPreferredWidth();
        csHeight =(int)(h - 2 * vSpace);
        this.numClasses = numClasses;
        setColors();

        tmpPopulate(numTracks, numLabels, numClasses, numPoints);

        cs = new ClassSelector(csWidth, csHeight, numClasses, hues, app);
        ts = new TrackSet(tsWidth, tsHeight, numTracks, numLabels, numClasses, hues, data, labels, app);

        csRegion = new Region(hSpace, vSpace, hSpace + csWidth, vSpace + csHeight);
        tsRegion = new Region(hSpace*2 + csWidth, vSpace, hSpace*2 + csWidth + tsWidth, vSpace + tsHeight);
        ts.myRegion = tsRegion; //hack
    }

    private void tmpPopulate(int numTracks, int numLabels, int numClasses, int numPoints) {
        data = new float[numTracks][numPoints];
        labels = new int[numLabels][numPoints];

        for (int i = 0; i < numTracks; i++) {
            for (int j = 0; j < numPoints; j++) {
                data[i][j] = (float)( Math.random() * 2 - 1);
            }
        }
        for (int i = 0; i < numLabels; i++) {
            for (int j = 0; j < numPoints; j++) {
                labels[i][j] = (int)(Math.random() * numClasses);
            }
        }
    }


/*    private float getOffsetY(int tNum) {
        return vSpace + (tNum * (trackHeight + vSpace)); 
    } */

    public void draw() {
       p.pushMatrix();
        p.translate(csRegion.x1, csRegion.y1);
        cs.draw();
        p.popMatrix();
        p.pushMatrix();
        p.translate(tsRegion.x1, tsRegion.y1);
        ts.draw();
        p.popMatrix();
    }

    //Data model stuff!!!
    private void changeLabels(int selectedTrack, int selectedMin, int selectedMax, int clicked) {
        //TODO!

    }

   private void setColors() {
        hues = new float[numClasses];
        for (int i = 0; i < numClasses; i++) {
            hues[i] = (float)i/numClasses * 256;
        }
    }
}
