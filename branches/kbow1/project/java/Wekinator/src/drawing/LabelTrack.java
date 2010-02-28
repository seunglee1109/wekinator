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
public class LabelTrack {
    public float width = 0f, height = 0f;
    public double wzoom = 1.0, hzoom = 1.0;
    public PApplet p = null;
   // public int x, y;
    float ppHor = 1.0f;
    float ppVert = 10.0f;

    int minInd = 0;
    int maxInd = 100;
    int numClasses = 0;
    float[] hues;
    int[] labels;
    public int minSelected = -1, maxSelected = -1;
    public int unitWidth = 10;

    public LabelTrack(float w, float h, int mini, int maxi, int numClasses, float[] hues, int[] labels, PApplet app) {
     //   this.x = x;
     //   this.y = y;
        p = app;
        this.hues = hues;
        this.labels = labels;
        width = w;
        height = h;
        //wzoom = wz;
        //hzoom = hz;
        this.minInd = mini;
        this.maxInd = maxi;
        ppHor = ((float)w) / (maxInd - minInd + 1);

        this.numClasses = numClasses;

    }

    public int getUnitWidth() {
        return unitWidth;
    }

    public void setUnitWidth(int w) {
        unitWidth = w;
        maxInd = minInd + w;
        ppHor = width / (maxInd - minInd + 1);
    }



    private float xformx(float x) {
        return (ppHor * (x - minInd));
    }


    public void setVals(float[] x, int[] y) {
            labels = y;
        
    }

    public void draw() {
        p.pushMatrix();
        p.pushStyle();
        p.fill(100, 100, 0);
        p.rect(0, 0, width, height);
      //  p.scale((float)ppHor, (float)ppVert);
        //p.translate(x, y);
        //p.sca
        //p.stroke(0);
        //p.strokeWeight(1.0f);
        p.noStroke();
        p.rectMode(PApplet.CORNER);

       // p.line(0, 0, 100, 100);

       if (labels.length > minInd) {
            int which = 0;
            int i = minInd;
            for (; (i <= maxInd && i < labels.length); i++) {
                if (i >= minSelected && i <= maxSelected) {
                    p.stroke(0, 0, 256);
                    p.fill(hues[labels[i]], 50, 256);
                } else {
                    p.noStroke();
                    p.fill(hues[labels[i]], 256, 256);
                }
               p.rect((ppHor*which++), 0, ppHor, height);
            }
        }

        p.popStyle();
        p.popMatrix();
    }

   public void  leftClick(float x, float y) {
        //Start highlight
        int index = findIndex(x, y);
        minSelected = index;
        if (maxSelected < index)
            maxSelected = index;
   }

   public void clearClick() {
        minSelected = -1;
        maxSelected = -1;
   }

   public void rightClick(float x, float y) {
        int index = findIndex(x, y);
        if (index >= minSelected)
            maxSelected = index;
   }

   private int findIndex(float x, float y) {
        return (int)(x / ppHor) + minInd;
   }
}
