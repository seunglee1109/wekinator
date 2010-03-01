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
       size( 600, 400);
       colorMode(HSB);
       smooth();
       background(50, 0, 256);
       dv = new DataView(600, 400, 10, 5, 3, 100, this);

    //   noLoop();
    //   String[] fontList = PFont.list();
             // smooth();

  //println(fontList);
        
       

   }

    @Override
   public void draw () {
       background(255);
        dv.draw();


   }

   @Override
   public void mouseClicked() {
       
       System.out.println("mouse clicked");
       dv.processMouseClick(mouseX, mouseY, mouseButton);
   }



}
