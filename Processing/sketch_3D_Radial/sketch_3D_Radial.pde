ArrayList<PVector> points = new ArrayList<PVector>();

void setup(){
  size(600,600,P3D);
  background(0);
  //lights();
  for(int i=0;i<=360;i+=15){
    points.add(new PVector(100,i,0));
   // println(15,i,100);
  }
}

PVector rotation =new PVector(0,0,0);
float scale = 100;

void draw(){  
  pushMatrix();
  translate(width/2,height/2,-100);
  rotateView();
  background(0);
  
  stroke(255);
  
  beginShape();
  for(PVector point:points){//radial calculation
    vertex(0,0,0);
    vecv(cylToCart(point));
  }
  endShape(); 
  
  drawAxis();
  
  popMatrix();
}
void vecv(PVector vect){
  vertex(vect.x,vect.y,vect.z);
}
PVector cylToCart(PVector cylindrical){
  return new PVector(
    cylindrical.x * cos(radians(cylindrical.y)),  //x
    cylindrical.x * sin(radians(cylindrical.y)),  //y
    cylindrical.z  //z
  );
}
PVector sphToCart(PVector spherical){
  return new PVector(
    spherical.x * sin(radians(spherical.y)) * cos(radians(spherical.z)),
    spherical.x * sin(radians(spherical.y)) * sin(radians(spherical.z)),
    spherical.x * cos(radians(spherical.y))
  );
}
void drawAxis(){
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
}
int mouseXOld;
int mouseYOld;
void mousePressed(){
  mouseXOld = mouseX;
  mouseYOld = mouseY;
}
void rotateView(){
  if(mousePressed){
    float x = rotation.x + ( mouseX - mouseXOld );
    float y = rotation.y + ( mouseY - mouseYOld );
    rotateX(radians(y));
    rotateY(radians(x));
    
  }else{
    rotateX(radians(rotation.y));
    rotateY(radians(rotation.x));
    rotateZ(radians(rotation.z));
  }
}
void mouseReleased(){
  int x = mouseX - mouseXOld;
  int y = mouseY - mouseYOld;
  rotation = new PVector(rotation.x+x,rotation.y+y,rotation.z);
}
void keyPressed(){
if(key=='r')
rotation=new PVector(0,0,0);
}

//  else{
//pushMatrix();
//beginShape(LINES);
//translate(width/2,height/2);
//fill(120);
//stroke(255);

////pushMatrix();
////rotateX(PI/3.0);
////rect(-26, -26, 52, 52);
////popMatrix();

//for(int i=0;i<=360;i+=15){
//  pushMatrix();
//  // translate(0,0,100);
//    vertex(0,0,0);
//    //rotateY(radians(i));   
//    //box(100);
//    vecv(cylToCart(new PVector(100,i,0)));
//  popMatrix();
//}
//endShape();
//popMatrix();
//}}
