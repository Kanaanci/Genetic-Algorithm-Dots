class Brain {
  PVector[] directions;
  int steps = 0;
  
  Brain(int size) {
    directions = new PVector[size];
    randomize();  
  }

/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
  //Start by moving randomly; Set each direction in the array to random angle
  void randomize() {
    for(int i = 0; i < directions.length; i++) {
      float randomAngle = random(2 * PI); //Generate a random angle that is from 0 to 2*PI
      directions[i] = PVector.fromAngle(randomAngle); //fromAngle calculates an angle based on the number passed. Idk how, so don't ask
    } 
  }
   
  //Copying the directions from the selected parent to the child
  Brain clone() { 
    Brain clone = new Brain(directions.length);
    
    for(int i = 0; i < directions.length; i++) {
      clone.directions[i] = directions[i].copy();
    }
    return clone;
  }
  
  /*
  This is where we can mutate the genes (directions) that are passed on to the children
  We have a 1% chance that the direction passed on will be overwritten by a new random angle
  This chance is determined by mutationRate
  We generate a random number from 0 to 1 and if the rand is less than the mutationRate, we generate a new direction
  NOTE - Usually you'd just want to tweak them slightly, but this is a simple project and overwriting is fine
  */
  void mutate() { 
    float mutationRate = 0.01;
    
    for(int i = 0; i < directions.length; i++) {
      float rand = random(1);
      
      if(rand < mutationRate) {
        float randomAngle = random(2 * PI);
        directions[i] = PVector.fromAngle(randomAngle);
      }
    }
  }
}
