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
    float[] xvals = new float[0];
    int[] yvals = new int[0];
    int[] colors = new int[0];

    float minX = 0;
    float maxX = 100;
    int numClasses = 0;

    public LabelTrack(float w, float h, float minx, float maxx, int numClasses, PApplet app) {
     //   this.x = x;
     //   this.y = y;
        p = app;

        width = w;
        height = h;
        //wzoom = wz;
        //hzoom = hz;
        this.minX = minx;
        this.maxX = maxx;

        ppHor = ((float)w) / (maxX - minX);

        this.numClasses = numClasses;
        setColors();

        setTempVals();
    }

    private void setColors() {
        colors = new int[numClasses];
        for (int i = 0; i < numClasses; i++) {
            colors[i] = p.color(((float)i)/numClasses * 256, 256, 256);
        }
    }

    private void setTempVals() {
       // xvals = {1.0f, 2.0f, 3.0f};
       // yvals = new float[3];
        float[] x1 = {1.f, 2.f, 3.f};
        int[] y1 = {0, 1, 2};
        xvals = x1;
        yvals = y1;
    }

    private float xformx(float x) {
        return (ppHor * (x - minX));
    }


    public void setVals(float[] x, int[] y) {
        if (x.length == y.length) {
            xvals = x;
            yvals = y;
        }
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

        if (xvals.length > 0) {
            for (int i= 0; i < xvals.length-1; i++) {
               //TODO: if no class given - should be black
                p.fill(colors[yvals[i]]);
               //p.line(xformx(xvals[i]), xformy(yvals[i]), xformx(xvals[i+1]), xformy(yvals[i+1]));
               p.rect((ppHor*i), 0, (ppHor*(i+1)), height);
            }

            if (xvals.length > 1) {
                 p.fill(colors[yvals[xvals.length-1]]);
               //p.line(xformx(xvals[i]), xformy(yvals[i]), xformx(xvals[i+1]), xformy(yvals[i+1]));
               p.rect((ppHor*xvals.length-1), 0, (ppHor*(xvals.length-1+1)), height);
            }
        }




        p.popStyle();
        p.popMatrix();
    }
}
