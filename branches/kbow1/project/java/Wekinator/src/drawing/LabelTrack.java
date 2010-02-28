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
    int[] yvals = new int[0];
    float[] hues = new float[0];

    int minInd = 0;
    int maxInd = 100;
    int numClasses = 0;

    public int minSelected = -1, maxSelected = -1;

    public LabelTrack(float w, float h, int mini, int maxi, int numClasses, PApplet app) {
     //   this.x = x;
     //   this.y = y;
        p = app;

        width = w;
        height = h;
        //wzoom = wz;
        //hzoom = hz;
        this.minInd = mini;
        this.maxInd = maxi;

        System.out.println("width is " + w);
        System.out.println("max is " + maxInd);
        System.out.println("min is " + minInd);


        ppHor = ((float)w) / (maxInd - minInd + 1);
        System.out.println("width of each is " + ppHor);

        this.numClasses = numClasses;
        setColors();

        setTempVals();
    }

    private void setColors() {
        hues = new float[numClasses];
        for (int i = 0; i < numClasses; i++) {
            hues[i] = (float)i/numClasses * 256;
        }
    }

    private void setTempVals() {
        int[] y1 = {0, 1, 2};
        yvals = y1;
    }

    private float xformx(float x) {
        return (ppHor * (x - minInd));
    }


    public void setVals(float[] x, int[] y) {
            yvals = y;
        
    }

    public void draw() {
        p.pushMatrix();
        p.pushStyle();
        p.fill(100, 100, 256);
        p.rect(0, 0, width, height);
      //  p.scale((float)ppHor, (float)ppVert);
        //p.translate(x, y);
        //p.sca
        //p.stroke(0);
        //p.strokeWeight(1.0f);
        p.noStroke();
        p.rectMode(PApplet.CORNER);

       // p.line(0, 0, 100, 100);

       if (yvals.length > minInd) {
            //if draw #0
          /*  if (minInd < yvals.length) {
                p.fill(hues[yvals[minInd]]);
                p.rect(0, 0, (ppHor * .5f), height);
            }
             */

            for (int i = minInd; (i <= maxInd && i < yvals.length); i++) {
          //                  for (int i = minInd; (i <= maxInd && i < yvals.length); i++) {
           
               //TODO: if no class given - should be black
                //TODO: offset 50% to left
               // int c = hues[yvals[i]];

                //int c  = hues[yvals[i]];
                if (i >= minSelected && i <= maxSelected) {
                    p.stroke(0, 0, 256);
                    p.fill(hues[i], 50, 256);
                } else {
                    p.noStroke();
                    p.fill(hues[i], 256, 256);
                }

               p.rect((ppHor*i), 0, ppHor, height);

            } 


      //  p.fill(30, 100, 100, 100);
      //  p.rect( 30, 0, 150, 200);

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
        return (int)(x / ppHor);
   }
}
