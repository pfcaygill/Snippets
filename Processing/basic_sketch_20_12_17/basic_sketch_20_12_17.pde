public ArrayList<Point> Satelites;
public static final Float orbSize = 10f;//used just for drawing

public static final Float airFriction = 1.005f;
public static final Float CONSTANT_MASS = 0.5f;

public PVector randomVector(){
return new PVector(
random(-1,1),
random(-1,1)
);
}
void settings(){
size(600,600);
}
void setup(){
Satelites = new ArrayList<Point>();
  
Satelites.add(new Point(width/2,height/2));
Satelites.add(new Point(width/2,height/2));
Satelites.add(new Point(width/2,height/2));
Satelites.add(new Point(width/2,height/2));


}
void draw(){
for (Point orb: Satelites){
  ellipse(orb.drawAtX(),orb.drawAtY(),orbSize,orbSize);//draw the object
  orb.UpdatePosition();
  if(mousePressed){
  orb.Accelerate(new PVector(mouseX,mouseY));
  }else{
  orb.Decelerate();
  }
}

}
public class Point{
  
  private PVector position;
  private PVector speed;
  public Point(int x1,int y1){
      this.position = new PVector(x1,y1);
      this.speed = randomVector();
}
  
  public float drawAtX(){return position.x;}
  public float drawAtY(){return position.y;}
  
  public void Accelerate(PVector gravityPosition){
    float d = PVector.dist(position,gravityPosition);
    PVector directionToMouse = PVector.sub(gravityPosition,position);
    directionToMouse.normalize();
    directionToMouse.mult(CONSTANT_MASS/d*d);
    this.speed= this.speed.add(directionToMouse);
    //https://www.openprocessing.org/sketch/79572
    //Calculations for gravit made using grav method from this sketch
  }
  public void Decelerate(){
    this.speed = this.speed.div(airFriction);
  }
  public void UpdatePosition(){
    this.position = this.position.add(speed);
  }
} 