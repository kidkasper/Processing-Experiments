int[] x = new int[4];
int[] y = new int[4]; 
float rad = 2;
float adjustDist = 120;
float t = 0;

void setup() {
  size(400,400);
  for (int i = 0; i<x.length; i++) {
    x[i] =  floor(random(401));
    y[i] =  floor(random(401));
  }
  noFill();
}

void draw() {
  background(144);
 
 
 //Find closest point
 int close = findClosest(x,y);
 float closeDist = dist(x[close],y[close],mouseX,mouseY);
 
 if(closeDist<adjustDist){
   // Draw indicator circle
   if (!mousePressed){
     noFill();
     stroke(255,0,255,128);
     ellipse(x[close],y[close],closeDist*2,closeDist*2);
   }
   
   //Update point position
   if (mousePressed) {
     x[close] = mouseX;
     y[close] = mouseY;
     if((keyPressed) && (keyCode==SHIFT)){
       x[close] = floor(float(mouseX)/10.0)*10;
       y[close] = floor(float(mouseY)/10.0)*10;
     }
   }
 }
 
 //Connect points
 stroke(0);
 //connectPoints(x,y);
 
 //Draw midpoints
 stroke(0,255,0,128);
 //drawMidPoints(x,y);
 
 //Draw tangent
 stroke(0,0,255,128);
 //drawTangent(x,y);
 
 //Draw points
 stroke(0);
 for(int i =0; i<x.length; i++) {
    ellipse(x[i],y[i],rad,rad); 
 }
 
 // Draw Bezier
 stroke(255,0,0,128);
 bezier(x[0], y[0], x[1], y[1], x[2], y[2], x[3], y[3]);
 
 generateBezier(x, y, t);
 
 t+=0.002;
 t=t%1;
}

void connectPoints(int[] x, int[] y){
 for (int i = 0; i < x.length-1; i++) {
  line(x[i],y[i],x[i+1],y[i+1]); 
 }
}

void drawPoints(int[] x, int[] y){
 stroke(0);
 for(int i =0; i<x.length; i++) {
    ellipse(x[i],y[i],rad,rad); 
 } 
}

void drawMidPoints(int[] x, int[] y) {
  for (int i = 0; i < 2; i++) {
    line((x[i]+x[i+1])/2,(y[i]+y[i+1])/2,(x[i+1]+x[i+2])/2,(y[i+1]+y[i+2])/2); 
 }
}

void drawTangent(int[] x, int[] y) {
   float x1 =  (x[0]+x[1])/2;
   float x2 =  (x[1]+x[2])/2;
   float x3 =  (x[2]+x[3])/2;
   float y1 =  (y[0]+y[1])/2;
   float y2 =  (y[1]+y[2])/2;
   float y3 =  (y[2]+y[3])/2;
   line((x1+x2)/2,(y1+y2)/2,(x2+x3)/2,(y2+y3)/2);
}
 
int findClosest(int[] x, int[] y){
  int xPos = mouseX;
  int yPos = mouseY;
  int closestIndex = -1;
  float minDist = 9999999;
  for (int i = 0; i < x.length; i++) {
    float tempDist = dist(x[i],y[i],xPos,yPos);
    if (tempDist < minDist) {
       minDist = tempDist;
       closestIndex =i;
    }
  }
  return closestIndex;
}

void generateBezier(int[] x, int[] y, float t){
  int[] qx = new int[3];
  int[] qy = new int[3];
  int[] rx = new int[2];
  int[] ry = new int[2];
  int[] sx = new int[1];
  int[] sy = new int[1];
  
  qx = generatePoints(x,t);
  qy = generatePoints(y,t);
  rx = generatePoints(qx,t);
  ry = generatePoints(qy,t);
  sx = generatePoints(rx,t);
  sy = generatePoints(ry,t);
  
  // Connect curve points
  stroke(0);
  connectPoints(x,y);
  
  stroke(0,255,0,128);
  connectPoints(qx, qy);
  
  stroke(0,0,255,128);
  connectPoints(rx, ry);
  
  // Draw points on curve
  drawPoints(qx, qy);
  drawPoints(rx, ry);
  drawPoints(sx, sy);
}

int[] generatePoints(int[] x, float t) {
  int size = x.length-1;
  int[] qx = new int[size]; 
  for (int i = 0; i < size; i++){
    qx[i] = floor(float(x[i])*t+float(x[i+1])*(1-t)); 
  }
  return qx; 
}
