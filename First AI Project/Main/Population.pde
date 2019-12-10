class Population {
  Dots dotsPop[]; //creating an array of dots
  
  float fitnessSum;
  
  int generation = 1;
  int bestDot = 0;
  int minSteps = 400;

  
  Population(int size) { 
    dotsPop = new Dots[size];

    for(int i = 0; i < size; i++) { 
      dotsPop[i] = new Dots();
    }
  }
  
/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
//These call the show and update methods in the Dots class for each object in the array
  void show() { 
    for(int i = 0; i < dotsPop.length; i++) {
      dotsPop[i].show(); 
    }
    dotsPop[0].show();
    
    fill(0, 0, 255);
    text("Generation: " + generation + "\nFewest Steps: " + minSteps, 15, 15);
  }
  
  void update() { 
    for(int i = 0; i < dotsPop.length; i++) {
      if(dotsPop[i].brain.steps > minSteps) { //If a dot takes more steps than the best dot, it dies
        dotsPop[i].dead = true; 
      }
      else {
        dotsPop[i].update(); 
      }
    }
  }
  
  boolean allDotsDead() {
    for(int i = 0; i < dotsPop.length; i++) {
      if(!dotsPop[i].dead && !dotsPop[i].reachedGoal) {
         return false; 
      }
    } 
    return true;
  }
  
/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
  void calculateFitness() {
    for(int i = 0; i < dotsPop.length; i++) {
      dotsPop[i].calculateFitness(); 
    }
  }
  
  void naturalSelection() {
    Dots[] dotsNewPop = new Dots[dotsPop.length];
    setBestDot();
    calculateFitnessSum();
    
    dotsNewPop[0] = dotsPop[bestDot].makeChild();
    dotsNewPop[0].isBest = true;
    
    for(int i = 1; i < dotsNewPop.length; i++) { //Start at 1 so we don't overwrite the best dot (always at [0]
      //Select parent based on fitness
      Dots parent = selectParent(); 
      
      //Adding the child to the new population
      dotsNewPop[i] = parent.makeChild(); 
    }
    dotsPop = dotsNewPop.clone();
    generation++;
  }
  
  void calculateFitnessSum() {
    //Adding up all the fitness scores
    fitnessSum = 0;
    
    for(int i = 0; i < dotsPop.length; i++) {
      fitnessSum += dotsPop[i].fitness;
    }
    //System.out.println(fitnessSum);
  }
  
  /**
  We have a bunch of fitnesses and we want the probability that the dot selected for reproduction will be proportional to these fitnesses
  This means if we have a dot with fitness 1 and a dot with fitness 2, the dot with fitness 2 should be twice as likely to be chosen
  
  We do this by adding the up all the fitnesses and choose a random number from 0 to the sum of the fitnesses
  If the random number falls in a particular dots zone, then that dot is chosen
  **/
  Dots selectParent() {
   float rand = random(fitnessSum); //Random number from 0 to the fitnessSum
   float runningSum = 0;
   
   //Adding up all the fitnesses again, if the current runningSum is greater than the random number, return that dot
   for(int i = 0; i < dotsPop.length; i++) {
     runningSum += dotsPop[i].fitness;
     
     if(runningSum > rand) { 
       return dotsPop[i];
     }
   }
    //Just in case
    return null;
  }
  
  
  void mutateChildren() { 
    for(int i = 1; i < dotsPop.length; i++) { //Start at 1 so we don't mutate the best dot (always at [0]) 
      dotsPop[i].brain.mutate();
          }
  }
  
  //We don't want the best dot to be mutated negatively, so we make it immortal and pass it into the next population automatically
  void setBestDot() { 
    float max = 0;
    int maxIndex = 0;
    
    //Compare the fitness of all the dots to calculate the best one
    for(int i = 0; i < dotsPop.length; i++) {
      if(dotsPop[i].fitness > max) {
        max = dotsPop[i].fitness;
        maxIndex = i;
      }
    }
    bestDot = maxIndex;
    
    //If the best dot made it to the goal, the steps allowed to take by the dots is set to the best dots steps
    if(dotsPop[bestDot].reachedGoal){
      minSteps = dotsPop[bestDot].brain.steps;
      //System.out.println("Fewest Steps " + minSteps);
    }   
  }
}
