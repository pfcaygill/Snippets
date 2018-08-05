
float ff1 = 0.0;
float ff2 = 0.0;
void settings(){size(200,200);}
void setup(){ellipseMode(RADIUS);noFill();stroke(120);}
void draw(){
  background(200);
  
  float rad = sin(radians(frameCount))*width/16+width/4;
  float stroke = (cos(radians(frameCount))+1)*width/8;
  strokeWeight(stroke);
  ellipse(width/2,height/2,rad,rad);
  saveFrame("frames/####.tif");
  //saving stuff
  if(ff1==rad&&ff2==stroke)
   exit(); 
  if(frameCount == 1){
   ff1=rad;ff2=stroke;
  }  
}