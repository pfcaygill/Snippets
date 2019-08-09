
float ff1 = 0.0;
float ff2 = 0.0;
PGraphics pg;
void settings(){size(200,200);}
void setup(){ellipseMode(RADIUS);noFill();stroke(120);frameRate(60);
}
void draw(){
  background(200);
  pg = createGraphics(200,200);
  float rad = sin(radians(frameCount*2))*width/16+width/4;
  float stroke = (cos(radians(frameCount*2))+1)*width/8;
  pg.beginDraw();
  pg.noFill();pg.stroke(120);
  pg.strokeWeight(stroke);
  pg.ellipse(width/2,height/2,rad,rad);
  pg.endDraw();
  pg.save("frames/"+frameCount+".png");
  //saving stuff
  if(ff1==rad&&ff2==stroke)
   exit(); 
  if(frameCount == 1){
   ff1=rad;ff2=stroke;
  }  
}