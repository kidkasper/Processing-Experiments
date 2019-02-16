int divisions = 16;
float sizeX, sizeY;
float t = 0;

void setup() {
  size(400,400);
  sizeX = width/float(divisions);
  sizeY = height/float(divisions);
  noStroke();
}

void draw() {
  background(128);
  for (int i = 0; i<divisions; i++) {
     for (int j =0; j<divisions; j++) {
       //Calculate index
       int index = i + j*divisions + j;
       
       //Set fill color
       if (index%2==1){
         fill(0); 
       } else {
         fill(255);
       }
       
       pushMatrix();
       translate(sizeX/2+sizeX*i,sizeY/2+sizeY*j);
       rotate(t*(1-(index%2)*2)*PI);
       rectMode(CENTER);
       rect(0,0,0.7*sizeX,0.7*sizeY);
       popMatrix();
     }
  }
  
  t += 0.01;
}
