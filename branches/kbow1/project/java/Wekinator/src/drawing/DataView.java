/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package drawing;
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

    void processMouseClick(int mouseX, int mouseY, int mouseButton) {
       /* if (clickState == ClickState.NONE && mouseButton == PApplet.LEFT) {
            //look for left click
        } else if (clickState == ClickState.L_LABEL && mouseButto
        *
        * */
        if (tsRegion.inRegion(mouseX, mouseY)) {
            ts.processMouseClick(mouseX, mouseY, mouseButton);
        } else if (csRegion.inRegion(mouseX, mouseY)) {
            cs.processMouseClick(mouseX, mouseY, mouseButton);
        }
    }

    public DataView(int w, int h, int numTracks, int numLabels, int numClasses, PApplet app) {
        p = app;
        width = w;
        height = h;
        tsWidth = (int)(w - 3 * hSpace - ClassSelector.getPreferredWidth());
        tsHeight = (int)(h - 2 * vSpace);
        csWidth = ClassSelector.getPreferredWidth();
        csHeight =(int)(h - 2 * vSpace);

        cs = new ClassSelector(csWidth, csHeight, numClasses, app);
        ts = new TrackSet(tsWidth, tsHeight, numTracks, numLabels, numClasses, app);
    }
 

/*    private float getOffsetY(int tNum) {
        return vSpace + (tNum * (trackHeight + vSpace)); 
    } */

    public void draw() {
        p.pushMatrix();
        p.translate(hSpace, vSpace);
        cs.draw();
        p.translate(csWidth + hSpace, 0);
        ts.draw();
        p.popMatrix();
    }
}
