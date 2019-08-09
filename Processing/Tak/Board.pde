import java.util.Stack;

class Board{
  Stack[][] arr;
  //Initialise a new board
  Board(){
   arr = new Stack[5][];
   for(int i=0; i<5;i++){
     arr[i] = new Stack[5];
     for(int j=0; j<5;j++)
     arr[i][j] = new Stack();
   }
  }
  //draw the board filling in square
  void drawBoard(float x, float y, float w, float h){
    for(int i=0;i<5;i++)
      for(int j=0;j<5;j++){
        fill(((j+i)%2==0)?(0):(100));
        rect(x+(w/5)*i,y+(h/5)*j,w/5,h/5);
      }
  }
}
