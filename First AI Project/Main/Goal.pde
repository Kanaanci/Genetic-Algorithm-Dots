class Goal { 
  PVector goal;
  
  float x;
  float y;
  
  Goal(float x, float y) { 
    this.x = x;
    this.y = y;
    goal = new PVector(x, y);
  }

/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
  void show() {
    fill(255, 0, 0);
    ellipse(goal.x, goal.y, 10, 10);
  }
}
