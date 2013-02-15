import processing.pdf.*;
import java.util.Calendar;

boolean savePDF = false;

PImage img;

int x,y;
int curvePointX = 0;
int curvePointY = 0;
int pointCount = 1;
float diffusion = 50;

void setup() {
  
  //size(640,480);
  img = loadImage("image.jpg");
  size(img.width, img.height);
  background(255);
  x = width/2;
  y = height/2;

}

void draw() {
  colorMode(HSB, 360,100,100);    
  smooth();
  noFill();
    
  
  int pixelIndex = ((img.width-1-x) + y*img.width);
  color c = img.pixels[pixelIndex];
  color(c,random(1,255));
  
  strokeWeight(hue(c)/(int)random(30,50));
  stroke(c);
  
  beginShape();
  curveVertex(x,y);
  curveVertex(x,y);
  for( int i = 0; i<pointCount; i++) {
    curvePointX = (int)constrain(x+random(-50, 50), 0, width-1);
    curvePointY = (int)constrain(y+random(-50,50),0, height-1);
    curveVertex(curvePointX, curvePointY);
  }   
  curveVertex(curvePointX, curvePointY);
  endShape();
  x = curvePointX;
  y = curvePointY;
  
  // change the size
  pointCount = (int)random(1,5);
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

