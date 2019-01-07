ArrayList<PVector> points = new ArrayList<PVector>();

void setup(){
  size(600,600,P3D);
  points.add(new PVector(0,0,0));  
  points.add(new PVector(0,0,1)); 
  points.add(new PVector(1,0,1));  
  points.add(new PVector(1,0,0));
  points.add(new PVector(1,1,0));
  points.add(new PVector(1,1,1)); 
  points.add(new PVector(0,1,1));
  points.add(new PVector(0,1,0));  
  background(0);
  lights();
}

PVector rotation =new PVector(0,0,0);
float scale =100;
float size = 0.01f;
void draw(){
  background(0);
  pushMatrix();
  translate(width/2,height/2);
  
  rotateX(rotation.x);
  rotateY(rotation.y);
  scale(scale); 
  strokeWeight(1/scale);
  //perform scaling only for the distance and not for the line width
  translate(-0.5,-0.5);//centring applied post scaling, so that the translation matrix has the correct units
 // noFill();   
  stroke(255);
 
  beginShape(QUADS);
  
  for(PVector point:points){
    pushMatrix();
    //noStroke();
    //fill(255);       
    vertex(point.x,point.y,point.z);      
    //vertex(0,0,0);
    popMatrix();
  }
  endShape(CLOSE);
  pushMatrix();
  beginShape(LINES);
  stroke(255,0,0);
  vertex(0,0,0);
  vertex(100,0,0);
  stroke(0,255,0);
  vertex(0,0,0);
  vertex(0,100,0);
  stroke(0,0,255);
  vertex(0,0,0);
  vertex(0,0,100);
  endShape();
  popMatrix();
  popMatrix();
}
int mouseXOld;
int mouseYOld;
void mousePressed(){
  mouseXOld = mouseX;mouseYOld=mouseY;
}
void mouseReleased(){
  int x = mouseX - mouseXOld;
  int y = mouseY - mouseYOld;
  rotation = new PVector(rotation.x+x,rotation.y+y,rotation.z);
}
void keyPressed(){
if(key=='r')rotation=new PVector(0,0,0);
}
