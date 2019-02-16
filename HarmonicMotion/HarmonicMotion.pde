import controlP5.*;

float t = 0;
float x, y = 0;

int numPoints;
float radMult = 0.8;

ControlP5 slider_numPoints;

void setup() {
  size(400,400);
  slider_numPoints = new ControlP5(this);
  slider_numPoints.addSlider("numPoints")
    .setPosition(5,15)
    .setSize(200,20).
    setRange(1,64)
    .setValue(32)
    .setColorCaptionLabel(color(20,20,20));
}

void draw(){
  background(0);
  pushMatrix();
  stroke(255);
  translate(width/2,height/2);
  for (int i = 0; i <numPoints; i++) {
    x = radMult*width/2*cos(float(i+1)/numPoints*t+2*PI/float(numPoints)*i);
    y = 0;
    pushMatrix();
    rotate(2*PI/float(numPoints)*i);
    stroke(128,64);
    line(-width/2*radMult,0,width/2*radMult,0);
    noStroke();
    ellipse(x,y,8,8);
    popMatrix();
  }
  popMatrix();
  t += 0.01; 
}
