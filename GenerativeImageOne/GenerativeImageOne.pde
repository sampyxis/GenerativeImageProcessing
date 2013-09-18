/* 
  To do: show original picture below the generative code
         change the strokes - more random
         add specific colors randomly (I want some bright red - maybe 2%)
         - do not flip the image when I load the pixles - I want
         it the same as the original image
         
         Also - I want to scan the image - find the bright spots and
         accentue them- and then do the same for the very dark spots
         and leave the rest the same
*/
/* Those were old notes - revisiting now (Setp 15, 2013)

  Still valid notes - would also like to blend out the original picture a bit 
  
  I want to put some more randomness in with the different types of lines, as well as the opposite color - I like that.
  
  I'd also like to add a side window for some control to change some things around.  May need to refactor this for that.
  
  Also, I HATE that the image is flipped - need to fix that.
  */
  /* Sept 16 2013 - adding GUI */
  /* to do 
    opening the original picture in a new window*/
  
import processing.pdf.*;
import java.util.Calendar;

// GUI
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

private ControlP5 cp5;

CheckBox lineBox;
CheckBox smLineBox;
CheckBox curveBox;
CheckBox smallCurveBox;
CheckBox smallLineBox;

ControlFrame cf;
ImageFrame imageFrame;


boolean savePDF = false;

PImage img;

int x,y;
int curvePointX = 0;
int curvePointY = 0;
int pointCount = 1;
int loopNum = 0;
int numOpp = 100;
int loopNumLine = 0;
int numOppLine = 100;
float lineWeight = 0;
float diffusion = 50;

boolean save = false;
boolean pause = false;
boolean drawLines = false;
boolean drawSmLines = false;
boolean drawCurves = false;

boolean smCurves = false;
boolean smLines = false;

boolean showTint = false;

void setup() {
  
  textSize(32);
  //size(640,480);
  //img = loadImage("image.jpg");
  //img = loadImage("KatheSnowAccrossLake.jpg");
  //img = loadImage("Family.jpg");
  //img = loadImage("Luzern Bridge 2013.jpg");
  //img = loadImage("Grueyre.jpg");
  //img = loadImage("Beach.jpg");
  //img = loadImage("Large_Cow.jpg");
  //img = loadImage("ourHouse.jpg");
  img = loadImage("BrentAboveLake.jpg");
  //img = loadImage("train_texture.jpg");
  size(img.width, img.height);
  x = width/2;
  y = height/2;
  
  // Flip the image and put on an alpha
  // Right now the code going through flips the image when it draws - so to stay
  // consistant, I'm flipping it too
  // Just temporary
  setUpImage();
 
 // Control frame
 cp5 = new ControlP5(this);
 cf = addControlFrame("Tools", 250,350);
 
 // Image Frame
 imageFrame = addImageFrame("Original", img.width, img.height);
 
 save = false;
 pause = false;
}

void draw() {
  colorMode(HSB, 360,100,100);    
  smooth();
  noFill();
  
  // Draw the original window
  imageFrame.draw();
  
//  int pixelIndex = ((img.width-1-x) + y*img.width);
// The code below doesn't reverse the image - yay!
  int pixelIndex = ( x+ (y*img.width ));
  color c = img.pixels[pixelIndex];
  color(c,random(1,255));
  
  // The last random function adds more thickness to the line
  lineWeight = hue(c)/(int)random(30,50) * random(1,5);  
  strokeWeight(lineWeight/2);
  
  //printText("Color: " + str(c), 10, 20);
  //printText("Hue: " + str(hue(c)), 10, 20);
  //printText("Weight: " + str(lineWeight), 10, 40);
  
  // Every 100 times - get the opposite color
  if( loopNum == numOpp) {
    loopNum = 0;
    float R = red(c);
    float G = green(c);
    float B = blue(c);
    float minRGB = min(R,min(G,B));
    float maxRGB = max(R,max(G,B));
    float minPlusMax = minRGB + maxRGB;
    color complement = color(minPlusMax-R, minPlusMax-G, minPlusMax-B);
    stroke(complement);
  } else {
    stroke(c);
    loopNum ++;
  }
  
  // how to draw
  // Default all to true to start
 //  drawLines = true;
//  drawSmLines = true;
//  drawCurves = true;
  if(!pause) {
    if( drawLines ) {
      drawLines();
    }
    if(drawSmLines) {
      drawSmallLines();
    }
    if(drawCurves) {
      drawCurves();
    }
  }
  
  // change the size
  pointCount = (int)random(1,5);
}

void drawSmallLines(){
  strokeWeight(random(.1,3));
  if (loopNumLine >= numOppLine) {
    if(smLines){
      line(x,y, x+ random(-width, width)/8, y + random(-height, height)/8);
    } else {
      line(x,y, x+ random(-width, width)/2, y + random(-height, height)/2);
    }
    loopNumLine = 0;
  } else {
    line(x, y, x+ random(3,30), y+ random(3,30));
    loopNumLine = loopNumLine + (int)random(-1,5);
    x = (int)random(0, width);
    y  = (int)random(0, height);
  }
}

void drawCurves() {
    // every numOpp times - do a stright line
  if( loopNumLine >= numOppLine ) {
    if(smLines){
      line(x,y, x+ random(-width, width)/8, y + random(-height, height)/8);
    } else {
      line( x, y, x + random(-width,width)/2, y + random(-height,height)/2);
    }
    loopNumLine = 0;
    printText("Line!!!!!!!!!!!!!!!!!!!!!",10,20);
  } else {
    beginShape();
    curveVertex(x,y);
    curveVertex(x,y);
    for( int i = 0; i<pointCount; i++) {
      if(smCurves) {
        curvePointX = (int)constrain(x+random(-10, 10), 0, width-1);
        curvePointY = (int)constrain(y+random(-10,10),0, height-1);        
      } else {
        curvePointX = (int)constrain(x+random(-50, 50), 0, width-1);
        curvePointY = (int)constrain(y+random(-50,50),0, height-1);
      }
      curveVertex(curvePointX, curvePointY);
    }   
    curveVertex(curvePointX, curvePointY);
    endShape();
    x = curvePointX;
    y = curvePointY;
    loopNumLine = loopNumLine + (int)random(-1,5);
  }
}

void drawLines() {
  if (loopNumLine >= numOppLine) {
    if(smLines){
      line(x,y, x+ random(-width, width)/8, y + random(-height, height)/8);
    } else {
      line(x,y, x+ random(-width, width)/2, y + random(-height, height)/2);
    }
    loopNumLine = 0;
  } else {
    line(x, y, x+ random(1,10), y+ random(1,10));
    loopNumLine = loopNumLine + (int)random(-1,5);
    x = (int)random(0, width);
    y  = (int)random(0, height);
  }
  
}

void printText(String text, int locationX, int locationY) {
  //text(text, locationX, locationY);
  println(text);
}

void keyReleased(){
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  
  if (key == 'r' || key == 'R'){  
    background(360);
    beginRecord(PDF, timestamp()+".pdf");
  }
  if (key == 'e' || key == 'E'){  
    endRecord();
  }

  if (key == 'q' || key == 'S') noLoop();
  if (key == 'w' || key == 'W') loop();
  
  if (keyCode == UP) pointCount = min(pointCount+1, 30);
  if (keyCode == DOWN) pointCount = max(pointCount-1, 1); 

}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

void setUpImage(){
  //pushMatrix();
  //scale(-1.0, 1.0);
  //if(showTint){
  //  tint(255,255);
 // }
//  image(img,-img.width,0);
  image(img,0,0);
  //popMatrix();
}


