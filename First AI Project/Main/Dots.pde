class Dots {
  //Dots will have position, acceleration, and velocity
  PVector pos;
  PVector acc;
  PVector vel;
  
  Brain brain;
  
  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;
  
  float fitness = 0.0;
  
  Dots() {
    //Setting the starting location and the acceleration and velocity
    pos = new PVector(width/2, height - 10);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
    
    brain = new Brain(400);
  }
 
/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
  //Show dots position on screen
  void show() {
    if(isBest) { //If it's the best from the previous generation make it green and bigger
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    }
    else{
      fill(0);
      ellipse(pos.x, pos.y, 4, 4); 
    }
  }
  
  //Move the dots around.
  //If it runs out of moves, then it dies
  void move() { 
    //If the steps is less than the amount of directions, set accelerationt to the nth (steps) direction and increment steps
    if(brain.directions.length > brain.steps) { 
       acc = brain.directions[brain.steps]; 
       brain.steps++;
    }
    else {
      dead = true;
    }
    
    vel.add(acc);
    vel.limit(5); //limit the velocity to a maximum of 5
    pos.add(vel);

    //System.out.println(brain.steps);
  }
  
  //If the Dots aren't dead and haven't reached the goal, move. Then check if the Dots are out of bounds or if reached it
  void update() {
    if(!dead && !reachedGoal) { 
      move();
      
      if(pos.x < 1 || pos.y < 5 || pos.x > width - 5 || pos.y > height - 5) {
        dead = true;
      }
      else if(dist(pos.x, pos.y, goal.x, goal.y) < 5){
         reachedGoal = true; //Check if the dot made it to the goal
      }
      else if(pos.x < (obs1.x + obs1.w) && pos.y < (obs1.y + obs1.h + 5) && pos.x > (obs1.x - obs1.w) && pos.y > (obs1.y - obs1.h + 5)){ //Obstacle 1
        dead = true;
      }
      else if(pos.x < abs((obs2.x + obs2.w)) && pos.y < abs((obs2.y + obs2.h + 5)) && pos.x > abs((obs2.x - obs2.w)) && pos.y > abs((obs2.y - obs2.h + 5))){ //Obstacle 2 -- did abs() becuase subtracting results in negative
        dead = true;
      }
    }
    calculateFitness();
  }
  
/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
  void calculateFitness() { 
    //Fitness should be based on the amount of steps they took. Dots that reached the goal in fewest steps should have a higher fitness
    if(reachedGoal) { 
      fitness = 1.0 / 16.0 + 10000.0 / (float)(brain.steps * brain.steps);
    }
    else {
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0 / (distanceToGoal * distanceToGoal); //The fitness is the inverse of the dots distance to the goal. Squared so that a smaller step towards the goal provides a higher fitness
      //System.out.println("Test " + distanceToGoal);
    }
    
  }
  
  //Making an identical child of the parent.
  //In a more complex program you would copy genes of two parents into one child. This program is a little simple for that, though
  Dots makeChild() {
    Dots child = new Dots();
    child.brain = brain.clone();
    
    return child;
  }
}
