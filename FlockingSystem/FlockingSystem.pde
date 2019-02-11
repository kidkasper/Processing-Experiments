Tracker[] trackers; 

int[] partitionIndex;

void setup() {
  size(400,400); 
  trackers = new Tracker[20];
  partitionIndex = new int[20];
  for (int i = 0; i<trackers.length; i++) {
    trackers[i] = new Tracker(random(width), random(height), i);
  }
}

void draw() {
  background(0);
  for (int i = 0; i<trackers.length; i++) {
    trackers[i].updateSpeed();
    trackers[i].updatePos();
    //t1.Partition(2);
    //t1.Partition(4);
    //t1.Partition(8);
    //t1.Partition(16);
    trackers[i].drawTracker();
    partitionIndex[i]=trackers[i].partitionIndex;
  }
}

class Tracker {
  float xpos, ypos, mass;
  int partitionIndex, seed;
  PVector speed;
  Tracker(float x, float y, int i) {
    xpos = x;
    ypos = y;
    seed = i;
    speed = new PVector(random(-1,1),random(-1,1));
    mass = random(3,20);
  }
  
  void drawTracker() {
    stroke(0);
    fill(255);
    ellipse(xpos,ypos,mass,mass);   
  }
  
  void updateSpeed() {
    PVector force = new PVector(mouseX-xpos,mouseY-ypos);
    Float magnitude = force.mag();
    float mag_remap =constrain(map(magnitude,0,400,0.5,0),0,0.5);
    force.normalize();
    force.mult(mag_remap);
    //speed.limit(4);
    speed.add(force);
    PVector noise = new PVector(2*noise(xpos*0.05,ypos*0.05,seed*2375)-1,2*noise(xpos*0.05+2000,ypos*0.05+2137,seed*6547)-1);
    noise.mult(2);
    speed.add(noise);
    speed.mult(0.95);
  }
  
  void updatePos() {
    xpos += speed.x;
    ypos += speed.y;
    xpos = xpos%width;
    ypos = ypos%height;
  }
  
  void calculateIndex(int n){
    //Calculate box size
    float xSize = width/float(n);
    float ySize = height/float(n);
   //Calculate index
    int x = floor(xpos/xSize);
    int y = floor(ypos/ySize);
    int i = x + y*n; 
    // println(i);
    partitionIndex = i;
  }
  
  void Partition(int n) {
    float xSize = width/float(n);
    float ySize = height/float(n);
    float xrad = xSize/2*0.99;
    float yrad = ySize/2*0.99;
    
    //Calculate index
    int x = floor(xpos/xSize);
    int y = floor(ypos/ySize);
    int i = x + y*n;
    
    rectMode(RADIUS);
    //Draw outer bounds
    stroke(0,0,255);
    noFill();
    rect(xSize*(x-1+0.5),ySize*(y-1+0.5),xrad,yrad);
    rect(xSize*(x+1+0.5),ySize*(y-1+0.5),xrad,yrad);
    rect(xSize*(x-1+0.5),ySize*(y+1+0.5),xrad,yrad);
    rect(xSize*(x+1+0.5),ySize*(y+1+0.5),xrad,yrad);
    
    //Draw cross
    stroke(0,255,0);
    noFill();
    rect(xSize*(x-1+0.5),ySize*(y+0.5),xrad,yrad);
    rect(xSize*(x+1+0.5),ySize*(y+0.5),xrad,yrad);
    rect(xSize*(x+0.5),ySize*(y-1+0.5),xrad,yrad);
    rect(xSize*(x+0.5),ySize*(y+1+0.5),xrad,yrad);
    
    //Draw central square
    stroke(255,0,0);
    noFill();
    rect(xSize*(x+0.5),ySize*(y+0.5),xrad,yrad);
  }
  
}
