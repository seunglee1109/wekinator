package drawing;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import processing.core.*;
import processing.*;

/**
 *
 * @author rebecca
 */
public class Drawing extends PApplet {
   // PlotTrack tr;
    DataView dv;

    public static void main(String[] args) {
       // must match the name of your class ie "letsp5.Main" = packageName.className
       PApplet.main( new String[]{"drawing.Drawing"} );
   }

  

    @Override
   public void setup () {
       size( 400, 400);
       colorMode(HSB);
       background(50, 0, 256);
       dv = new DataView(300, 300, 3, 2, 3, this);

   }

    @Override
   public void draw () {
    //tr.draw();
        dv.draw();
   }

    @Override
   public void mouseDragged() {
       line(mouseX, mouseY, pmouseX, pmouseY);
   }

    @Override
   public void mouseClicked() {
       dv.processMouseClick(mouseX, mouseY, mouseButton);
   }

}
