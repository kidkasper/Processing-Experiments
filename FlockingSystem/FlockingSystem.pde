Tracker t1 = new Tracker(width/2, height/2);

void setup() {
  size(400,400); 
}

void draw() {
  background(0);
  t1.updateSpeed();
  t1.updatePos();
  t1.Partition(2);
  t1.Partition(4);
  t1.Partition(8);
  t1.Partition(16);
  t1.drawTracker();
}

class Tracker {
  float xpos, ypos, mass;
  PVector speed;
  Tracker(float x, float y) {
    xpos = x;
    ypos = y;
    speed = new PVector(random(-1,1),random(-1,1));
    mass = 3;
  }
  
  void drawTracker() {
    stroke(0);
    fill(255);
    ellipse(xpos,ypos,mass,mass);   
  }
  
  void updateSpeed() {
    PVector force = new PVector(mouseX-xpos,mouseY-ypos);
    Float magnitude = force.mag();
    float mag_remap =constrain(map(magnitude,0,400,1,0),0,1);
    force.normalize();
    force.mult(mag_remap);
    speed.limit(4);
    speed.add(force);
  }
  
  void updatePos() {
    xpos += speed.x;
    ypos += speed.y;
    xpos = xpos%width;
    ypos = ypos%height;
  }
  void Partition(float n) {
    int x = floor(xpos/width*n);
    int y = floor(ypos/height*n);
    float recx = width/n*x;
    float recy = height/n*y;
    stroke(255,0,0);
    noFill();
    rect(recx,recy,width/n,height/n);
  }
  
}
