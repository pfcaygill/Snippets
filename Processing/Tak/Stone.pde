enum StoneType{ 
  flat("F"),
  standing("S"),
  capstones("C");
  public final String toString;
  private StoneType(String toString){
    this.toString = toString;
  }
}
class Stone{
  StoneType type;
  public boolean canStackOn(){
    return StoneType.flat == this.type;
  }
  public String toString(){
    return type.toString;
  }
}
