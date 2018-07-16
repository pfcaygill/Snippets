/**
Enum adds a rendering property that draws a single icon on a tile.
*/
enum HexIcon{
None
}
/**
Enum determines the rendering properties of a single hex
(color and geographical render)
*/
enum HexType{
Blank
}
/**
Class stores information about a hex tile and is used to determine
*/
class HexInfo{
  public final HexType type;
  public final HexIcon icon;
  
  /* Allows for null initialisation */
  public HexInfo(
  HexType isBlank,
  HexIcon isNone  
  ){
    this.type =(isBlank==null)?HexType.Blank:isBlank;
    this.icon =(isNone ==null)?HexIcon.None:isNone;
  }
}
/**
Hex mapping tool using xyz vectors re-mapped to fit relative coordinates
Using the centre hex as 0,0,0 we can generate vectors for each of its neighbors
eg. (1,0,0),(0,1,0),(0,0,1),(-1,0,0),(0,-1,0),(0,0,-1)
This can be applied for any given hex, and used to determine relative coords from any point
*/
HashMap<PVector,HexInfo> hexMap;

void settings(){
  hexMap = new HashMap<PVector,HexInfo>();
}

void draw(){

}