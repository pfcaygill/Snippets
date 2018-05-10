  //simple program: boredom killer. should increase at an exponential rate up to a cap
//every n frames produce a bubble.
//store the bubbles as a bubble object.
//bubble object has an x,y,radius, and an overlap method that returns a boolean
color[] pall={#fff8f8,#c4cbff,#5fb1ea,#008080,#3e0d60,#FF0000};
ArrayList<bubble> bArray;
int rate= 300;//rate of the bubbles spawning
final int rateMin=20;
int score=0; 
boolean gameState =true;
float timer;//variables related to timer function
//Variables for controling game outcomes
final float percentNormal = 0.6f;
final float timerMax=100;
final float timerRate=1;
final int maxBubbles=30;
final int minBubbleR = 40;
void setup(){
  fullScreen();
  reset();
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(64);
  noStroke();
  rectMode(CORNERS);
}
void reset(){
  bArray = new ArrayList<bubble>();
  for(int i=0;i<30;i++)
    bArray.add(new bubble(width,height));
  rate=100;  score=0;
  timer=timerMax;
}
void draw(){
  // fill(pall[4],40);      //blur function/fade
  //rect(0,0,width,height);
  background(pall[4]); //solid function
  
  if(frameCount%(rate*5)==0&&gameState)
    flipOne();
  if(frameCount%rate==0&&gameState)
    newBubble();
  if(frameCount%rate*rate==0&&rate>rateMin&&gameState)
    rate=(int)(rate/1.5);
  updateAll();
  doTimer();
  if(gameState){
    fill(0);
    text(score,width/2,height/2);
    drawTimer();//timer before bubbles puts it in ba
    drawBubbles();
  }else{
    fill(255);
    rect(width/4,height*7/16,width*3/4,height*9/16);
    fill(0);
    text("Play new game!",width/2,height*15/32);
    fill(#CE51BE);
    text("Previous score: "+score,width/2,height*17/32);
  }
}
void newBubble(){
if(bArray.size()<maxBubbles){
  bubble b =new bubble(width,height);
    bArray.add(b);
}}
void drawBubbles(){
for(int i =bArray.size()-1;i>=0;i--){
  bArray.get(i).drawMe();
  } 
}
void updateAll(){
  for(int i =bArray.size()-1;i>=0;i--){
    bArray.get(i).updateVector(width,height);
    bArray.get(i).moveBubble();
  }
}
void flipOne(){
  for(int i =0;i<bArray.size();i++){
    if(!bArray.get(i).type){
      bArray.get(i).flipType();
      return;
    }
  }
}
void doTimer(){
if(timer==0&&gameState)endGame();
else if(gameState){
timer-=timerRate;
  }
}
void drawTimer(){
  rect(
    width/2-(timer/timerMax*(width/2)),
    height*15/16,
    width/2+(timer/timerMax*(width/2)),
    height*14/16);
}
 //draws a line with a certain thickness
 //which has a length away from the center point equal to
 //the value of timer*(the max value/the width)
 void endGame(){
 bArray = new ArrayList<bubble>();
 gameState=false;
 }
void mouseReleased(){
  int removeMe=-1;
  boolean found = false;
  int i=0;
  while((!found)&&(i<bArray.size()))//looks for the bubble underneath
    if(bArray.get(i).overlaps(mouseX,mouseY)){
      removeMe=i;
      found=true;
    }else i++;  
  if(removeMe>=0)
    popBubble(removeMe);//has the value to be removed of the bubble, unless it couldnt be found
  if(!gameState&&
  mouseX>(width/4)&&
  mouseX<(width*3/4)&&
  mouseY>(height*7/16)&&
  mouseY<(height*9/16)
  //checks if within bounding box.
  ){
    //rect(width/4,height*7/16,width*3/4,height*9/16); 
    //psuedo button location
    reset();
    gameState=true;
  } 
}
void popBubble(int i){
  if(bArray.get(i).getType()){
    bArray.remove(i);
    score++;
    timer=timerMax;
  }else{
    endGame();
  }
}
class bubble{
  float x,y,r;
  int col;
  PVector velocity;
  boolean type;
  public bubble(int w, int h){
    r = random(40,120);
    x = random(r,w-r);
    y = random(r,h-r);
    col=(int)random(3);
    velocity=PVector.fromAngle(random(0,2*PI));
    float val=random(0,1);
    type=(val<=percentNormal);
      //println(val+""+type);
    }
    public boolean overlaps(double x1, double y1){
      if((x+r)>x1&&(x-r)<x1&&(y+r)>y1&&(y-r)<y1)return true;
      else return false;
    } 
    public void updateVector(float xMax,float yMax){
      if(x>xMax||x<0)velocity.set(-velocity.x,velocity.y);
      if(y>yMax||y<0)velocity.set(velocity.x,-velocity.y);
    }
    public void moveBubble(){
      x+=velocity.x;y+=velocity.y;
    }
    public void increaseSpeed(float scale){
      velocity.mult(scale);
    }
    public void flipType(){
    if(!type)type=!type;
    }
    public float getX(){return x;}
    public float getY(){return y;}
    public float getR(){return r;}
    public int getCol(){return col;}
    public boolean getType(){return type;}
    public void drawMe(){
      if(type)fill(pall[col]);
      else fill(pall[5]);
      ellipse(x,y,r*2,r*2);
      
    }
}
