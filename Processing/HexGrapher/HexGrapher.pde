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
/*-------------------------------------------------------------
Helper methods to perform shorthand additions to the map
--------------------------------------------------------------*/
/**
Adds the default adjacent hexEntries to the map if they are not already present
*/
void addAdjacent(PVector c){
  PVector[] adjMatrix = {
  new PVector(c.x-1,c.y,c.z),
  new PVector(c.x+1,c.y,c.z),
  new PVector(c.x,c.y-1,c.z),
  new PVector(c.x,c.y+1,c.z),
  new PVector(c.x,c.y,c.z-1),
  new PVector(c.x,c.y,c.z+1)
  };
  for(int i = 0;i<adjMatrix.length;i++){
    if(!hexMap.containsKey(adjMatrix[i]))
      hexMap.put(adjMatrix[i],new HexInfo(null,null));
  }  
}
/*--------------------------------------------
CONSTANTS AND FIELDS
----------------------------------------------*/
//render center
PVector center;
//initial values pre running
void settings(){
  hexMap = new HashMap<PVector,HexInfo>();
  center = new PVector(0,0,0);
  //add the default values
  hexMap.put(center, new HexInfo(null,null));//add the center
  addAdjacent(center);
}

void draw(){
  //render relative to the center hex position (not always 0,0,0)
  //map center is always 0,0,0
  //render center uses a coordinate to allow for 
  
}
/*------------------------------------------------
Render Helper Code
--------------------------------------------------*/

void drawHexagon(PVector coord,HexInfo nonNull){

}
