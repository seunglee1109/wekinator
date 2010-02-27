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
    List<PlotTrack> myTracks = new LinkedList<PlotTrack>();
    LabelTrack myLabel = null;
    public float vSpace = 10.0f;
    public float hSpace = 10.0f;
    public float minX = 0f;
    public float maxX = 100f;
    public float trackWidth = 100f;
    public float trackHeight = 20f;

    public TrackSet(int w, int h, int numTracks, PApplet app) {
     
        width = w;
        height = h;
        trackWidth  = w - 2 * hSpace;
        trackHeight = ((float) h - (numTracks+2)* vSpace) / (numTracks + 1);
        
        myTracks = new LinkedList<PlotTrack>();
        for (int i = 0; i < numTracks; i++) {
            myTracks.add(new PlotTrack(trackWidth, trackHeight, minX, maxX, -2f, 2f, app));
        }
        myLabel = new LabelTrack(trackWidth, trackHeight, minX, maxX, 3, app);
        p = app;

       // tmpPopulate();
    }

    

    private float getOffsetY(int tNum) {
        return vSpace + (tNum * (trackHeight + vSpace)); 
    }

    public void draw() {
        p.pushMatrix();
        p.pushStyle();
        p.fill(10, 10, 256);
        p.rect(0, 0, width, height);
      //  p.scale((float)ppHor, (float)ppVert);
        //p.translate(x, y);
        //p.sca
        p.translate(hSpace, 0);

        p.translate(0, vSpace);
        myLabel.draw();
        p.translate(0, trackHeight);

        for (int i = 0; i < myTracks.size(); i++) {
            p.translate(0, vSpace);
            myTracks.get(i).draw();
            p.translate(0, trackHeight);
        }

        p.popStyle();
        p.popMatrix();
    }
}
