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
public class PlotTrack {
    public float width = 0f, height = 0f;
    public double wzoom = 1.0, hzoom = 1.0;
    public PApplet p = null;
   // public int x, y;
    float ppHor = 1.0f;
    float ppVert = 10.0f;
    float[] xvals = new float[0];
    float[] yvals = new float[0];
    float minX = 0;
    float maxX = 100;
    float minY = -1;
    float maxY = -1;

    public PlotTrack(float w, float h, float minx, float maxx, float miny, float maxy, PApplet app) {
     //   this.x = x;
     //   this.y = y;
        width = w;
        height = h;
        //wzoom = wz;
        //hzoom = hz;
        this.minX = minx;
        this.minY = miny;
        this.maxX = maxx;
        this.maxY = maxy;

        ppHor = ((float)w) / (maxX - minX);
        ppVert = ((float)h) / (maxY - minY);
        p = app;
        setTempVals();
    }

    private void setTempVals() {
       // xvals = {1.0f, 2.0f, 3.0f};
       // yvals = new float[3];
        float[] x1 = {1.f, 2.f, 3.f};
        float[] y1 = {-1f, 1f, -1f};
        xvals = x1;
        yvals = y1;
    }

    private float xformx(float x) {
        return (ppHor * (x - minX));
    }

    private float xformy(float y) {
        return (ppVert * (maxY - y));
    }

    public void setVals(float[] x, float[] y) {
        if (x.length == y.length) {
            xvals = x;
            yvals = y;
        }
    }

    public void draw() {
        p.pushMatrix();
        p.pushStyle();
        p.fill(30, 100, 100);
        p.rect(0, 0, width, height);
      //  p.scale((float)ppHor, (float)ppVert);
        //p.translate(x, y);
        //p.sca
        p.stroke(0);
        p.strokeWeight(1.0f);
       // p.line(0, 0, 100, 100);

        if (xvals.length > 0) {
            for (int i= 0; i < xvals.length-1; i++) {
               p.line(xformx(xvals[i]), xformy(yvals[i]), xformx(xvals[i+1]), xformy(yvals[i+1]));
            }
        }

        p.popStyle();
        p.popMatrix();
    }
}
