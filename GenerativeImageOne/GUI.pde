/* GUI */
ControlFrame addControlFrame(String theName, int theWidth, int theHeight ){
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100,100);
  f.setResizable(true);
  f.setVisible(true);
  return p;
}

// the ControlFrame class - extends PApplet

public class ControlFrame extends PApplet {
  int w,h;
  int abc = 100;
  
  public void setup() {
    size(w,h);
    frameRate(25);
    cp5 = new ControlP5(this);
    /* Need:
      Save
      Pause
      Line
      SmallLine
      Curve
      Circle
      Blotch
      */
    cp5.addButton("Save")
      .setValue(0)
      .setPosition(10,10)
      .setSize(200,10)
      ;
      

    cp5.addButton("Pause")
      .setValue(0)
      .setPosition(10,30)
      .setSize(200,10)
      ;
      
    lineBox = cp5.addCheckBox("useLine")
      .setPosition(10, 50)
      .setColorForeground(color(120))
      .setColorActive(color(255))
      .setColorLabel(color(255))
      .setSize(30,30)
      .addItem("Draw Lines", 0)
      ;
      
    smLineBox = cp5.addCheckBox("useSmallLine")
      .setPosition(10, 90)
      .setColorForeground(color(120))
      .setColorActive(color(255))
      .setColorLabel(color(255))
      .setSize(30,30)
      .addItem("Draw Small Lines", 0)
      ;
      
    curveBox = cp5.addCheckBox("useCurves")
      .setPosition(10, 130)
      .setColorForeground(color(120))
      .setColorActive(color(255))
      .setColorLabel(color(255))
      .setSize(30,30)
      .addItem("Draw Curves", 0)
      ;      
      
    //cp5.addSlider("abc").setRange(0,255).setPosition(10,10);
    //cp5.addSlider("def").plugTo(parent, "def").setRange(0,255).setPosition(10,30);
  }
  
  public void controlEvent(ControlEvent theEvent){
    //println(theEvent.getController().getName());
    if(theEvent.isFrom(lineBox)){
      drawLines = lineBox.getState(0);
    }
    if(theEvent.isFrom(smLineBox)) {
      drawSmLines = smLineBox.getState(0);
    }
    if(theEvent.isFrom(curveBox)) {
      drawCurves = curveBox.getState(0);
    }
  }
  
  
  public void Save(){
    println("Saved!");
  }
  
  public void Pause(){
    pause = !pause;
  }
  
  public void draw(){
    background(abc);
  }
  
  private ControlFrame(){
  }
  
  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }
  
  public ControlP5 control() {
    return cp5;
  }
  
  ControlP5 cp5;
  Object parent;
}
