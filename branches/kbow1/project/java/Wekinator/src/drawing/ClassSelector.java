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
public class ClassSelector {
    public float width = 0f, height = 0f;
    public PApplet p = null;

    int numClasses = 0;

    public ClassSelector(float w, float h, int numClasses, PApplet app) {

        width = w;
        height = h;
        this.numClasses = numClasses;
        p = app;
    }

    public static int getPreferredWidth() {
        return 100;
    }

    void processMouseClick(int mouseX, int mouseY, int mouseButton) {
        System.out.println("Mouse clicked in classes");
    }

    public void draw() {
        p.pushMatrix();
        p.pushStyle();
        p.fill(100);
       // p.line(0, 0, 100, 100); 
        p.rect(0, 0, width, height);
        p.popStyle();
        p.popMatrix();
    }
}
