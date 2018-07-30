import java.util.HashSet;

HashSet<PVector> map = new HashSet<PVector>();
HashSet<PVector> enclosed = new HashSet<PVector>();
float scale=50;
float minSteps = 20;
float maxSteps= 70;
void settings(){
  fullScreen();
}

void setup(){
  float steps = random(minSteps,maxSteps);
  print(steps);
  map.add(new PVector(0,0));
  for(int i =0;i<steps;i++){
    bindRandomSq();
  }
}

void draw(){
 // stroke(0);
  background(255,0,0);
  for(PVector vec: map){
    drawSq(vec);
  }
//print(enclosed.size());
  for(PVector vec2:enclosed){  
    drawSq(vec2);
  }
}
void drawSq(PVector vec){
  pushMatrix();
  translate(width/2,height/2);
  translate(vec.x*scale,vec.y*scale);
  rectMode(CENTER); 
  if(isEnclosed(vec))
    fill(255);
  else
    if(extrenuous(vec))
      fill(0,255,0);
    else
      fill(0);
  rect(0,0,scale,scale);
  popMatrix();
}
/**
gets a random entry from the set,
not in the enclosed set
*/
PVector bindRandomSq(){
  HashSet<PVector> targets = new HashSet<PVector>(map);
  targets.removeAll(enclosed);
  int seed = (int)random(0,targets.size());
  PVector target=null;
  for(PVector vec:targets){
    if(seed==0)target=vec;
    seed--;
  }
  assert(target!=null);//will always pass
  ArrayList<PVector> choice = new ArrayList<PVector>();
   PVector k= new PVector(target.x-1,target.y);    
   if(!map.contains(k))choice.add(k);
   k= new PVector(target.x+1,target.y);
   if(!map.contains(k))choice.add(k);
   k= new PVector(target.x,target.y-1);
   if(!map.contains(k))choice.add(k);
   k= new PVector(target.x,target.y+1);
   if(!map.contains(k))choice.add(k);
   
  int r = floor(random(0,choice.size()));
  target = choice.get(r);
  //post offset, target proper selected
  map.add(target);
  for(PVector targ:map)
    if(isEnclosed(targ))
      enclosed.add(targ);
  
  return target;
}
boolean extrenuous(PVector target){
  if(isEnclosed(target))return false;
  return 
  !isEnclosed(new PVector( target.x+1,target.y))&&
   !isEnclosed(new PVector( target.x,target.y-1))&&
    !isEnclosed(new PVector( target.x-1,target.y))&&
   !isEnclosed(new PVector( target.x,target.y+1));  
    
}
boolean isEnclosed(PVector target){
  boolean enc =
    map.contains(new PVector( target.x+1,target.y))&&
    map.contains(new PVector( target.x,target.y-1))&&
    map.contains(new PVector( target.x-1,target.y))&&
    map.contains(new PVector( target.x,target.y+1));  
    //if(enc)print('!');
    return enc;
}
