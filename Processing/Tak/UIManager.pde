//Fixed sketch values
float margin = 32;
//Board fixed values
Board board;
float bx, by, bw, bh, chunkSize;
void setupUI()
{
  board = new Board();
  bw = width - margin*2;
  bh = bw;
  bx = margin;
  by = (height - bh)/3;
  chunkSize = by - margin*2;
}

//Board control area
void drawBoard()
{
  board.drawBoard(bx, by, bw, bh);
  drawStack();
  drawButtons();
}
void detectBoardTouch()
{
  //detect the touch if it is within the area of the board
  if(by <= mouseY && mouseY<= (by+bh))
  {
  float shiftX = mouseX-bx;
  float shiftY = mouseY-by;
  int x = (int)(shiftX/(bw/5f));
  int y = (int)(shiftY/(bh/5f));
  board.selectTile(x,y);
  } 
}
//Stack control area
void drawStack()
{
  float bannerWidth = width - margin*2;
  float bannerHeight = chunkSize;
  float bannerX = margin;
  float bannerY = margin;
  //Setup the color for the background
  fill(#7EFFFF);
  rect(bannerX,bannerY,bannerWidth,bannerHeight);
}
//Button control area
void drawButtons()
{
  pushMatrix();
  
  float bannerWidth = width - margin*2;
  float bannerHeight = chunkSize;
  float bannerX = margin;
  float bannerY = bh + bannerHeight + margin*3;
  translate(bannerX,bannerY);
  ellipseMode(CORNER);
  noStroke();
  //outer fill
  fill(#7EFFFF);
  //background area 1
  ellipse(0,0,chunkSize,chunkSize);
  ellipse(chunkSize + margin, 0, chunkSize, chunkSize);
  rect(chunkSize/2, 0, chunkSize+margin, chunkSize);
  //background area 2
  ellipse(bannerWidth-chunkSize, 0, chunkSize, chunkSize);
  //inner fill
  fill(#6EDEDD);
  //buttons 1
  ellipse(margin, margin, chunkSize-2*margin, chunkSize-2*margin);
  ellipse(chunkSize + margin*2, margin, chunkSize-2*margin, chunkSize-2*margin);
  //buttons 2
  ellipse(bannerWidth-chunkSize+margin, margin, chunkSize-2*margin,chunkSize-2*margin);
  
  popMatrix();
}
