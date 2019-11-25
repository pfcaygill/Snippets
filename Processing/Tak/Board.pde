import java.util.Stack;

class Board
{
  //Specific
  Stone[][][] arr;
  //Highlight
  float highX=-1, highY=-1;
  //Initialise a new board
  Board(){
   arr = new Stone[5][][];
   for(int i=0; i<5;i++){
     arr[i] = new Stone[5][];
     for(int j=0; j<5;j++)
     arr[i][j] = new Stone[1];
   }
  }  
  //draw the board filling in square
  void drawBoard(
    float x, float y, float w, float h
    )
  {
    for(int i=0;i<5;i++)
      for(int j=0;j<5;j++){
        fill(fillTile(i,j));
        rect(x+(w/5)*i,y+(h/5)*j,w/5,h/5);
      }
  }
  private color fillTile(float x, float y)
  {
    //highlight
    if(x==highX && y==highY) return color(#FF6F00);
    //black
    if((x+y)%2==0) return color(0);
    //grey
    return color(100);
  }
  //select a tile on the board
  void selectTile(float x, float y)
  {
    this.highX = x; 
    this.highY = y;
  }
}
