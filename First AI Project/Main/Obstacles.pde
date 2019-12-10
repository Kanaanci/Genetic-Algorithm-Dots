class Obstacles {
  PVector obs;
  
  float x;
  float y;
  float w;
  float h;
  
  Obstacles(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    obs = new PVector(x, y);
  }
  
  void show() {
   fill(150, 0, 255);
   rect(obs.x, obs.y, w, h);
  }
}
