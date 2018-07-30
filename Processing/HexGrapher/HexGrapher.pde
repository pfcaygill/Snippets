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
PVector loop = new PVector(1,-1,1);

PVector reduceHex(PVector hexField){
  PVector h = hexField;
  if(h.x==0||h.y==0||h.z==0)
    return h;
  //detect a loop
  if(h.y<0){
    if(h.x>0&&h.z>0){}
  }else if (h.x<0&&h.z<0){}
  //non reduceable
  return h;
}

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
  new PVector(c.x,c.y,c.z+1)//needs reduction. check the 2 loops 1,-1,1 and -1,1,-1 and reduce coords
  };
  for(int i = 0;i<adjMatrix.length;i++){
    adjMatrix[i] = reduceHex(adjMatrix[i]);
    
    if(!hexMap.containsKey(adjMatrix[i]))
      hexMap.put(adjMatrix[i],new HexInfo(null,null));
  }  
}
/*--------------------------------------------
CONSTANTS AND FIELDS
----------------------------------------------*/
//render center
PVector center;
//the length of one side of the hexagon (formed using equilateral triangles)
float hexLen = 50.0f;
//initial values pre running
void settings(){
  size(600,600);
  hexMap = new HashMap<PVector,HexInfo>();
  center = new PVector(0,0,0);
  //add the default values
  hexMap.put(center, new HexInfo(null,null));//add the center
  addAdjacent(center);
}

void draw(){
  pushMatrix();
  translate(width/2,height/2);
  //render relative to the center hex position (not always 0,0,0)
  //map center is always 0,0,0
  //render center uses a coordinate to allow for 
  for(PVector key:hexMap.keySet()){
    if(hexMap.get(key)!=null)
      drawHexagon(key,hexMap.get(key));
  } 
  popMatrix();
}
/*------------------------------------------------
Render Helper Code
--------------------------------------------------*/
/**
Draws a hexagon at a specific X,Y based on the size of the hexagon
*/
void drawHexagon(PVector hexPosition,HexInfo nonNull){
  PVector coord = findCenterOfHex(hexPosition);
  pushMatrix();
  float altLen=sin(radians(60))*hexLen;
  beginShape();
  vertex(coord.x+hexLen,coord.y);
  vertex(coord.x+hexLen/2,coord.y+altLen);//TODO translate to radians
  vertex(coord.x-hexLen/2,coord.y+altLen);
  vertex(coord.x-hexLen,coord.y);
  vertex(coord.x-hexLen/2,coord.y-altLen);
  vertex(coord.x+hexLen/2,coord.y-altLen);
  endShape(CLOSE);
  popMatrix();
}

PVector findCenterOfHex(PVector hexPosition){
PVector actual = center.sub(hexPosition);
float altLen=sin(radians(60))*hexLen;
return new PVector(
  actual.x*1.5*hexLen+
  actual.y*1.5*hexLen,
  -actual.x*altLen+
  actual.y*altLen+
  actual.z*2*altLen
);
}
