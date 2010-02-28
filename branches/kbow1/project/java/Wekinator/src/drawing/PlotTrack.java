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
    int minX = 0;
    int maxX = 100;
    float minY = -1;
    float maxY = -1;
    float[] data = null;
    int unitWidth = 10;

    public PlotTrack(float w, float h, int minx, int maxx, float miny, float maxy, float[] data, PApplet app) {
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
        this.data = data;

        ppHor = ((float)w) / (maxX - minX+1);
        ppVert = ((float)h) / (maxY - minY);
        p = app;
    }

    public int getUnitWidth() {
        return unitWidth;
    }

    public void setUnitWidth(int w) {
        unitWidth = w;
        maxX = minX + w;
        ppHor = width / (maxX - minX+1);
    }

    private float xformx(float x) {
        return ppHor*.5f + (ppHor * (x - minX));
    }

    private float xformy(float y) {
        return (ppVert * (maxY - y));
    }

    public void setVals(float[] y) {
      
            data = y;
        
    }

    public void draw() {
        p.pushMatrix();
        p.pushStyle();
        p.fill(200);
        p.rect(0, 0, width, height);
      //  p.scale((float)ppHor, (float)ppVert);
        //p.translate(x, y);
        //p.sca
        p.stroke(0);
        p.strokeWeight(1.0f);
       // p.line(0, 0, 100, 100);

        if (data.length > minX) {
            for (int i= minX; (i < maxX && i < (data.length-1)); i++) {
               p.line(xformx(i), xformy(data[i]), xformx(i+1), xformy(data[i+1]));
            }
        }
        p.popStyle();
        p.popMatrix();
    }
}
