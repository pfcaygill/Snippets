/**
* Fields
*/
public static float accelerationDueToGravity = 1.008;
public static float initialSpeedMin = 1;
public static float initialSpeedMax = 7;
public static float initialYMin = -300;
public static float initialYMax = 0;
public static float maxRadius = 80;
public static float radiusScalar=0.2;
public static float mouseRadius = 30;

public static int maxNumberOfMeteors = 50;
public static final String gameOver= "Game Over/nTry Again?";
public ArrayList<PVector> meteors = new ArrayList<PVector>();
//vector is x,y,acc

void settings(){
size(600,600);
}

void setup(){
  fill(0);
}
void draw(){
  background(255);
  //if(frameCount % frameRate==0)
  drawMouse();
    updateAndDrawMeteors();
}

void gravity(PVector meteor){
meteor.set(meteor.x,meteor.y+meteor.z,meteor.z*accelerationDueToGravity);
}
boolean crashToEarth(PVector meteor){
  if(meteor.y > height)
    return true;
  return false;
}
boolean overlaps(PVector other){
  float r=calcRadius(other);
  if((other.x+r)>mouseX-mouseRadius &&(other.x-r)<mouseX+mouseRadius &&(other.y+r)>mouseY-mouseRadius&&(other.y-r)<mouseY+mouseRadius)return true;
  else return false;
} 
void drawMouse(){
ellipse(mouseX,mouseY,mouseRadius*2,mouseRadius*2);
} 
void newRandomMeteor(){
   meteors.add(new PVector(
   random(width),
   random(initialYMin,initialYMax),
   random(initialSpeedMin,initialSpeedMax)));
}
float calcRadius(PVector meteor){
  return maxRadius/(meteor.z*radiusScalar);
}

void updateAndDrawMeteors(){
  ArrayList<Integer> flagForRemoval = new ArrayList<Integer>();
  for(int i =0;i<meteors.size();i++){
    //move
    gravity(meteors.get(i));
    //check the position of said meteor
    if(crashToEarth(meteors.get(i))){//update
      flagForRemoval.add(i);
    }else{
     ellipse(meteors.get(i).x,meteors.get(i).y,calcRadius(meteors.get(i)),calcRadius(meteors.get(i)));
    }  
  }
  //Remove from the list in reverse order
  for(
  int i = flagForRemoval.size()-1;
  i >= 0; 
  i-=1){
    meteors.remove(flagForRemoval.get(i).intValue());
  }
  
  while(meteors.size() < maxNumberOfMeteors){  
    newRandomMeteor();
  }
}
