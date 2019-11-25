enum ViewMode
{
  Board, Move
}
ViewMode mode = ViewMode.Board;

void setup()
{
  setupUI();
}
void draw()
{
  switch(mode)
  {
    case Board: drawBoard(); break;
    case Move: break;
  }
}
void mousePressed()
{
  detectBoardTouch();
}
