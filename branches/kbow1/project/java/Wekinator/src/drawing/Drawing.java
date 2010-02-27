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
    TrackSet ts;

    public static void main(String[] args) {
       // must match the name of your class ie "letsp5.Main" = packageName.className
       PApplet.main( new String[]{"drawing.Drawing"} );
   }

  

    @Override
   public void setup () {
       size( 400, 400 );
       colorMode(HSB);
       background(50, 0, 256);
       ts = new TrackSet(300, 300, 3, this);

   }

    @Override
   public void draw () {
    //tr.draw();
        ts.draw();
   }

    @Override
   public void mouseDragged() {
       line(mouseX, mouseY, pmouseX, pmouseY);
   }



}
