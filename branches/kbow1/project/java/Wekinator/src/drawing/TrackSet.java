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
public class TrackSet {
    public int width = 0, height = 0;
    public PApplet p = null;
    PlotTrack[] myTracks = null;
    LabelTrack[] myLabels = null;
    Region[] trackRegions = null;
    Region[] labelRegions = null;
    Region zoomIn = null;
    Region zoomOut= null;
    
    public float vSpace = 10.0f;
    public float hSpace = 10.0f;
    public int minInd = 0;
    public int maxInd = 10;
    public float trackWidth = 100f;
    public float trackHeight = 20f;
    public float labelHeight = 20f; //doesn't change
    public int ctrlRegionHeight = 40;
    private HScrollbar hs1 = null;
    public Region myRegion = null;
    int numPoints = 0;
    PFont myZoomFont = null;
    protected String[] pNames = null;
    protected String [] fNames = null;
    public Region scrollTUp = null;
    public Region scrollTDown = null;
    public Region scrollLUp = null;
    public Region scrollLDown = null;
    protected int minTrack = 0;
    protected int maxTrack = 0;
    protected final int maxNumTracksShown = 5;
    protected int minLabel = 0;
    protected int maxLabel = 0;
    protected final int maxNumLabelsShown = 3;
    protected int numTracksShown;
    protected int numLabelsShown;
    protected float nameWidth = 80;
    protected float vertScrollSize = 10;

    public TrackSet(int w, int h, int numTracks, int numLabels, int numClasses, float[] hues, float[][] data, int[][] labels, PApplet app) {
        p = app;
        minTrack = 0;
        maxTrack = Math.min(numTracks - 1, maxNumTracksShown - 1);
        numTracksShown = maxTrack - minTrack + 1;
        minLabel = 0;
        maxLabel = Math.min(numLabels-1, maxNumLabelsShown-1);
        numLabelsShown = maxLabel - minLabel + 1;

        myZoomFont = p.createFont("Helvetica", 10);

        numPoints = data[0].length;
        width = w;
        height = h;
        trackWidth  = w - 2 * hSpace - nameWidth - vertScrollSize;

        float spaceLeftForTracks = ((float) h - ctrlRegionHeight - numLabelsShown * labelHeight - vSpace * (numTracksShown + numLabelsShown + 2));
        trackHeight = spaceLeftForTracks / numTracksShown;
        //trackHeight = ((float) h - vSpace - ctrlRegionHeight -(numTracks+numLabels + 1)* vSpace - numLabels * labelHeight) / (numTracks);

        float heightSoFar = vSpace + ctrlRegionHeight;
        scrollLUp = new Region(hSpace, heightSoFar, hSpace + vertScrollSize, heightSoFar + vertScrollSize);

        myLabels = new LabelTrack[numLabels];
        labelRegions = new Region[numLabelsShown];
        for (int i = 0; i < numLabels; i++) {
            myLabels[i] = new LabelTrack(trackWidth, labelHeight, minInd, maxInd, numClasses, hues, labels[i], app);
        }
        for (int i = 0; i < numLabelsShown; i++) {
             labelRegions[i] = new Region(hSpace + vertScrollSize + nameWidth, heightSoFar, hSpace + nameWidth + trackWidth + vertScrollSize, heightSoFar + labelHeight);
             heightSoFar += labelHeight + vSpace;
        }

        scrollLDown = new Region(hSpace, heightSoFar - vertScrollSize - vSpace, hSpace + vertScrollSize, heightSoFar - vSpace);



        myTracks = new PlotTrack[numTracks];
        trackRegions = new Region[numTracksShown];
        scrollTUp = new Region(hSpace, heightSoFar, hSpace + vertScrollSize, heightSoFar + vertScrollSize);

        for (int i = 0; i < numTracks; i++) {
            myTracks[i] = new PlotTrack(trackWidth, trackHeight, minInd, maxInd, -2f, 2f, data[i], app);
        }
        for (int i = 0; i < numTracksShown; i++) {
            trackRegions[i] = new Region(hSpace + nameWidth + vertScrollSize, heightSoFar, hSpace + nameWidth + trackWidth + vertScrollSize, heightSoFar + trackHeight);
            heightSoFar += trackHeight + vSpace;
        }
        scrollTDown = new Region(hSpace, heightSoFar - vertScrollSize - vSpace, hSpace + vertScrollSize, heightSoFar - vSpace);


        hs1 = new HScrollbar((int)hSpace, 40, w - 2 *(int)hSpace, 10, 16);
        zoomIn = new Region(hSpace, 20, hSpace + 10, 30);
        zoomOut = new Region(hSpace + 20, 20, hSpace + 30, 30);
        setNames();
    }

    private void setNames() {
        pNames = new String[myLabels.length];
        for (int i= 0; i < pNames.length; i++ ){
            pNames[i] = "Param_" + i;
        }
        fNames = new String[myTracks.length];
        for (int i = 0; i < fNames.length; i++) {
            fNames[i] = "Feat_" + i;
        }
    }

    protected int zoomLevel = 0;
    protected int getWidthForZoomLevel() {
        switch (zoomLevel) {
            case 0:
                return 20;
            case -1:
                return 50;
            case -2: return 100;
            case 1:
                return 10;
            case 2:
                return 5;
        }

        if (zoomLevel > 2) {
            zoomLevel = 3;
            return 2;
        }
        if (zoomLevel < -2) {
            return (int)(100 * Math.pow(2, (-1 * zoomLevel) - 2));
        }
        return 50;
    }

    void processMouseClick(float mouseX, float mouseY, int mouseButton) {
       /* if (clickState == ClickState.NONE && mouseButton == PApplet.LEFT) {
            //look for left click
        } else if (clickState == ClickState.L_LABEL && mouseButto
        *
        * */


        if (mouseButton == PApplet.LEFT) {
                if (zoomIn.inRegion(mouseX, mouseY)) {
                    zoomLevel++;
                    int w = getWidthForZoomLevel();
                    for (int i = 0; i < myTracks.length; i++) {
                        myTracks[i].setUnitWidth(w);
                    }
                     for (int i = 0; i < myLabels.length; i++) {
                        myLabels[i].setUnitWidth(w);
                    }
                    return;
                } else if (zoomOut.inRegion(mouseX, mouseY)) {
                    zoomLevel--;
                    int w = getWidthForZoomLevel();
                    for (int i = 0; i < myTracks.length; i++) {
                        myTracks[i].setUnitWidth(w);
                    }

                     for (int i = 0; i < myLabels.length; i++) {
                        myLabels[i].setUnitWidth(w);
                    }
                    return;
                } else if (scrollLDown.inRegion(mouseX, mouseY)) {
                    if (maxLabel < myLabels.length - 1) {
                        minLabel++;
                        maxLabel++;
                        
                    }
                    return;
                } else  if (scrollLUp.inRegion(mouseX, mouseY)) {
                    if (minLabel > 0) {
                        minLabel--;
                        maxLabel--;
                    }
                    return;
                } else  if (scrollTDown.inRegion(mouseX, mouseY)) {
                    if (maxTrack < myTracks.length - 1) {
                        minTrack++;
                        maxTrack++;
                    }
                    return;
                } else  if (scrollTUp.inRegion(mouseX, mouseY)) {
                    if (minTrack > 0) {
                        minTrack--;
                        maxTrack--;
                    }
                }



            //if click in label, clear any existing region
                int region = findRegion(labelRegions, mouseX, mouseY);
                int labelNum = findLabelForRegion(region);

                if (labelNum != -1) {
                    if (selectedTrack != labelNum && clickState != ClickState.NONE) {
                        myLabels[selectedTrack].clearClick();
                    }
                    selectedTrack = labelNum;
                    myLabels[labelNum].leftClick(mouseX - labelRegions[region].x1, mouseY - labelRegions[region].y1);
                    clickState = ClickState.L_LABEL;
                } else if (clickState != ClickState.NONE) {
                    //User has clicked outside a label
                    myLabels[selectedTrack].clearClick();
                    selectedTrack = -1;
                    clickState = ClickState.NONE;
                }
        } else if (mouseButton == PApplet.RIGHT && clickState != ClickState.NONE) {
              int region = findRegion(labelRegions, mouseX, mouseY);
                int labelNum = findLabelForRegion(region);
              if (labelNum != -1 && labelNum == selectedTrack) {
                 myLabels[selectedTrack].rightClick(mouseX - labelRegions[region].x1, mouseY - labelRegions[region].y1);
                 clickState = ClickState.LR_LABEL;
              }
        }
    }

    public int getSelectedMin() {
        if (selectedTrack == -1 || clickState != ClickState.LR_LABEL)
            return -1;

        return myLabels[selectedTrack].minSelected;
    }

    public int getSelectedMax() {
        if (selectedTrack == -1 || clickState != ClickState.LR_LABEL)
            return -1;

        return myLabels[selectedTrack].maxSelected;
    }

    private int findLabelForRegion(int regionNum) {
        
        if (regionNum == -1)
            return -1;
        
        int labelNum = minLabel + regionNum;
        if (labelNum <= maxLabel)
            return labelNum;
        
        return -1;
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

    

/*    private float getOffsetY(int tNum) {
        return vSpace + (tNum * (trackHeight + vSpace)); 
    } */

    public void update() {
        float f = hs1.getPos();
        int min = (int)(f * numPoints);
        if (min < 0) min = 0;
        if (min > numPoints) min = numPoints;
        for (int i = 0; i < myTracks.length; i++) {
            myTracks[i].minX = min;
            myTracks[i].maxX = min + myTracks[i].getUnitWidth(); //hack
         //   System.out.println("min is " + min);
        }

        for (int i = 0; i < myLabels.length; i++) {
            myLabels[i].minInd = min;
            myLabels[i].maxInd = min + myLabels[i].getUnitWidth(); //hack
        }
    }

    public void draw() {
        update();
        p.pushStyle();
        p.fill(10, 10, 256);
        p.rect(0, 0, width, height);
         p.textFont(myZoomFont);
            p.fill(0);
            p.textAlign(PApplet.RIGHT, PApplet.TOP);
        int rowNum = 0;
        for (int i = minLabel; i <= maxLabel; i++) {
            p.pushMatrix();
            p.translate(labelRegions[rowNum].x1, labelRegions[rowNum].y1);
            myLabels[i].draw();
            p.text(pNames[i], -5, 0);
            p.popMatrix();
            rowNum++;
        }

        rowNum = 0;
        for (int i = minTrack; i <= maxTrack; i++) {
            p.pushMatrix();
            p.translate(trackRegions[rowNum].x1, trackRegions[rowNum].y1);
            myTracks[i].draw();
            p.text(fNames[i], -5, 0);
            p.popMatrix();
            rowNum++;
        }

        hs1.update(p.mousePressed, p.mouseX - (int)myRegion.x1, p.mouseY - (int) myRegion.y1);
        hs1.display();

        p.fill(200);
        p.rect(zoomIn.x1, zoomIn.y1, 10, 10);
        p.textFont(myZoomFont);
        p.fill(0);
        p.textAlign(PApplet.CENTER, PApplet.CENTER);
        p.text("+", zoomIn.x1 + 5, zoomIn.y1+5);

        p.fill(200);
        p.rect(zoomOut.x1, zoomOut.y1, 10, 10);
         p.fill(0);
        p.text("-", zoomOut.x1 + 5, zoomOut.y1+5);

        p.pushMatrix();
        p.translate(scrollLDown.x1, scrollLDown.y1);
        p.fill(200);
        p.rect(0, 0, vertScrollSize, vertScrollSize);
        p.popMatrix();


        p.pushMatrix();
        p.translate(scrollLUp.x1, scrollLUp.y1);
        p.fill(200);
        p.rect(0, 0, vertScrollSize, vertScrollSize);
        p.popMatrix();



        p.pushMatrix();
        p.translate(scrollTUp.x1, scrollTUp.y1);
        p.fill(200);
        p.rect(0, 0, vertScrollSize, vertScrollSize);
        p.popMatrix();


        p.pushMatrix();
        p.translate(scrollTDown.x1, scrollTDown.y1);
        p.fill(200);
        p.rect(0, 0, vertScrollSize, vertScrollSize);
        p.popMatrix();

        p.popStyle();
    }

class HScrollbar
{
  int swidth, sheight;    // width and height of bar
  int xpos, ypos;         // x and y position of bar
  float spos, newspos;    // x position of slider
  int sposMin, sposMax;   // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (int xp, int yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    //spos = xpos + swidth/2 - sheight/2;
    spos = 0;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update(boolean mousePressed, int mouseX, int mouseY) {
    if(over(mouseX, mouseY)) {
      over = true;
    } else {
      over = false;
    }
    if(mousePressed && over) {
      locked = true;
    }
    if(!mousePressed) {
      locked = false;
    }
    if(locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if(Math.abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  int constrain(int val, int minv, int maxv) {
    return Math.min(Math.max(val, minv), maxv);
  }

  boolean over(int mouseX, int mouseY) {
    if(mouseX > xpos && mouseX < xpos+swidth &&
    mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    p.fill(255);
    p.rect(xpos, ypos, swidth, sheight);
    if(over || locked) {
      p.fill(153, 102, 0);
    } else {
      p.fill(102, 102, 102);
    }
    p.rect(spos, ypos, sheight, sheight);
     // System.out.println(getPos());
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return (spos - xpos-1) / (swidth - sheight-2);
  }
}


}
