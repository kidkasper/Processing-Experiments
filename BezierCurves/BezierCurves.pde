float[] x = new float[4];
float[] y = new float[4]; 
float rad = 2;
float adjustDist = 120;
float t = 0;
int close = 0;

float lerpSpeed = 0.15;
float[] targetx = new float[4];
float[] targety = new float[4];



void setup() {
  size(400,400);
  for (int i = 0; i<x.length; i++) {
    x[i] =  floor(random(401));
    y[i] =  floor(random(401));
    targetx[i] =  floor(random(401));
    targety[i] =  floor(random(401));
    
  }
  noFill();
}

void draw() {
  background(144);
 
 
 //Find closest point
 if(!mousePressed) {
   close = findClosest(x,y);
 }
 float closeDist = dist(x[close],y[close],mouseX,mouseY);
 
 if(closeDist<adjustDist){
   // Draw indicator circle
   if (closeDist>5){
     noFill();
     stroke(255,0,255,128);
     ellipse(x[close],y[close],closeDist*2,closeDist*2);
   }
   
   //Update point position
   if (mousePressed) {
     targetx[close] = mouseX;
     targety[close] = mouseY;
     if((keyPressed) && (keyCode==SHIFT)){
       targetx[close] = floor(float(mouseX)/10.0)*10;
       targety[close] = floor(float(mouseY)/10.0)*10;
     }
   }
 }
 
 // Lerp to target points
 for (int i = 0; i<x.length; i++){
   x[i] = lerp(x[i], targetx[i], lerpSpeed);
   y[i] = lerp(y[i], targety[i], lerpSpeed);
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
 
 // 
 generateBezier(x, y, t);
 
 t+=0.002;
 t=t%1;
 
 // Randomise target points
 if(keyPressed) {
   if(keyCode==UP){
      for(int i =0; i < x.length; i++){
        targetx[i] = random(width*0.8)+0.1*width;
        targety[i] = random(height*0.8)+0.1*height;
      }
   }
 }
}
 
int findClosest(float[] x, float[] y){
  float xPos = mouseX;
  float yPos = mouseY;
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

void generateBezier(float[] x, float[] y, float t){
  float[] qx = new float[3];
  float[] qy = new float[3];
  float[] rx = new float[2];
  float[] ry = new float[2];
  float[] sx = new float[1];
  float[] sy = new float[1];
  
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

float[] generatePoints(float[] x, float t) {
  int size = x.length-1;
  float[] qx = new float[size]; 
  for (int i = 0; i < size; i++){
    qx[i] = x[i]*t+x[i+1]*(1-t); 
  }
  return qx; 
}

void connectPoints(float[] x, float[] y){
 for (int i = 0; i < x.length-1; i++) {
  line(x[i],y[i],x[i+1],y[i+1]); 
 }
}

void drawPoints(float[] x, float[] y){
 stroke(0);
 for(int i =0; i<x.length; i++) {
    ellipse(x[i],y[i],rad,rad); 
 } 
}

// DEPRECATED MIDPOINT CALCULATION FORMULA
void drawMidPoints(float[] x, float[] y) {
  for (int i = 0; i < 2; i++) {
    line((x[i]+x[i+1])/2,(y[i]+y[i+1])/2,(x[i+1]+x[i+2])/2,(y[i+1]+y[i+2])/2); 
 }
}

// DEPRECATED TANGENT CALCULATION FORMULA
void drawTangent(float[] x, float[] y) {
   float x1 =  (x[0]+x[1])/2;
   float x2 =  (x[1]+x[2])/2;
   float x3 =  (x[2]+x[3])/2;
   float y1 =  (y[0]+y[1])/2;
   float y2 =  (y[1]+y[2])/2;
   float y3 =  (y[2]+y[3])/2;
   line((x1+x2)/2,(y1+y2)/2,(x2+x3)/2,(y2+y3)/2);
}
