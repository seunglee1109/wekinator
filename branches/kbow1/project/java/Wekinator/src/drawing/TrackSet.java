/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package drawing;
import java.util.LinkedList;
import java.util.List;
import processing.core.*;

/**
 *
 * @author rebecca
 */
public class TrackSet {
    public int width = 0, height = 0;
    public PApplet p = null;
    PlotTrack[] myTracks = null;
    LabelTrack[] myLabels = null;
    Region[] trackRegions = null;
    Region[] labelRegions = null;
    
    public float vSpace = 10.0f;
    public float hSpace = 10.0f;
    public int minInd = 0;
    public int maxInd = 2;
    public float trackWidth = 100f;
    public float trackHeight = 20f;
    public float labelHeight = 20f; //doesn't change

    void processMouseClick(int mouseX, int mouseY, int mouseButton) {
       /* if (clickState == ClickState.NONE && mouseButton == PApplet.LEFT) {
            //look for left click
        } else if (clickState == ClickState.L_LABEL && mouseButto
        *
        * */

        if (mouseButton == PApplet.LEFT) {
            //if click in label, clear any existing region
                int region = findRegion(labelRegions, mouseX, mouseY);
                if (region != -1) {
                    if (selectedTrack != region && clickState != ClickState.NONE) {
                        myLabels[selectedTrack].clearClick();
                    }
                    selectedTrack = region;
                    myLabels[region].leftClick(mouseX, mouseY);
                    clickState = ClickState.L_LABEL;
                } else if (clickState != ClickState.NONE) {
                    //User has clicked outside a label
                    myLabels[selectedTrack].clearClick();
                    selectedTrack = -1;
                    clickState = ClickState.NONE;
                }
        } else if (mouseButton == PApplet.RIGHT && clickState != ClickState.NONE) {
              int region = findRegion(labelRegions, mouseX, mouseY);
              if (region == selectedTrack) {
                 myLabels[selectedTrack].rightClick(mouseX, mouseY);
                 clickState = ClickState.LR_LABEL;
              }
        }
    }

    private int findRegion(Region[] regions, float x, float y) {
        int r = -1;
        for (int i = 0; i < regions.length; i++) {
            if (regions[i].inRegion(x, y))
                return i;
        }
        return r;
    }

    public enum ClickState {
        NONE,
        L_LABEL,
        LR_LABEL
    };

    protected ClickState clickState = ClickState.NONE;
    protected int selectedTrack = -1;

    public TrackSet(int w, int h, int numTracks, int numLabels, int numClasses, PApplet app) {
        p = app;
        width = w;
        height = h;
        trackWidth  = w - 2 * hSpace;
        trackHeight = ((float) h - (numTracks+numLabels + 1)* vSpace - numLabels * labelHeight) / (numTracks);

        float heightSoFar = vSpace;
        myLabels = new LabelTrack[numLabels];
        labelRegions = new Region[numLabels];
        for (int i = 0; i < numLabels; i++) {
            myLabels[i] = new LabelTrack(trackWidth, labelHeight, minInd, maxInd, numClasses, app);
            labelRegions[i] = new Region(hSpace, heightSoFar, trackWidth, heightSoFar + labelHeight);
            heightSoFar += labelHeight + vSpace;
        }

        myTracks = new PlotTrack[numTracks];
        trackRegions = new Region[numTracks];
        for (int i = 0; i < numTracks; i++) {
            trackRegions[i] = new Region(hSpace, heightSoFar, trackWidth, heightSoFar + trackHeight);
            myTracks[i] = new PlotTrack(trackWidth, trackHeight, minInd, maxInd, -2f, 2f, app);
            heightSoFar += trackHeight + vSpace;
        }
    }
 

/*    private float getOffsetY(int tNum) {
        return vSpace + (tNum * (trackHeight + vSpace)); 
    } */

    public void draw() {
        p.pushStyle();
        p.fill(10, 10, 256);
        p.rect(0, 0, width, height);

        for (int i = 0; i < myLabels.length; i++) {
            p.pushMatrix();
            p.translate(labelRegions[i].x1, labelRegions[i].y1);
            myLabels[i].draw();
            p.popMatrix();
        }

        for (int i = 0; i < myTracks.length; i++) {
            p.pushMatrix();
            p.translate(trackRegions[i].x1, trackRegions[i].y1);
            myTracks[i].draw();
            p.popMatrix();
        }

        p.popStyle();
    }


}
