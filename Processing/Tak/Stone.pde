enum Stone{
  //Three types of stones
  flat,
  standing,
  capstone;

  public String toString()
  {
    switch(this)
    {
      case capstone: return "C";
      case standing: return "S";
      case flat: 
      default: return "F";
    }
  }
  public boolean canBeStackedOnBy(Stone other)
  {
    switch(this)
    {
      case capstone: return false;
      case standing: return other == Stone.capstone;
      case flat:
      default: return true;
    }
  }
}
