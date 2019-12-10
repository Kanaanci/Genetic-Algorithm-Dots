Population test;
Goal goal;
Obstacles obs1;
Obstacles obs2;


void setup() {
  size(800, 800);
  test = new Population(1000);
  goal = new Goal(400, 10);
  obs1 = new Obstacles(0, 500, 600, 10);
  obs2 = new Obstacles(300, 250, 600, 10);
  //frameRate(1); //this is to see it all very slow motion
}

void draw() {
  background(255);
  goal.show();
  obs1.show();
  obs2.show();
  
  if(test.allDotsDead()) {
    test.calculateFitness();
    test.naturalSelection();
    test.mutateChildren();
  }
  
  test.show();
  test.update();
}
