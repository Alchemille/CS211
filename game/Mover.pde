float Y = 0.5; // if higher, effets de bord Processing
float R = 24;

class Mover {

  PVector location;
  PVector velocity;
  PVector gravity;

  Mover() { // constructor
    location = new PVector(0, 0, 0); // reaferential of board
    velocity = new PVector(0, 0, 0);
    gravity = new PVector(0, 0, 0);
  }
  void update() {
    //gravity.x = sin(rotZ) * Y;
    //gravity.z = sin(rotX) * Y;
    velocity.add(gravity);
    location.add(velocity);
  }
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    sphere(R);
  }
  void checkEdges() {
    if (location.x > width-24) {
      velocity.x = velocity.x * -1;
      location.x = width-24;
    } else if (location.x < 24) {
      velocity.x = velocity.x * -1;
      location.x = 24;
    }
    if (location.y > height-24) {
      velocity.y = velocity.y * -1;
      location.y = height-24;
    } else if (location.y < 24) {
      velocity.y = velocity.y * -1;
      location.y = 24;
    }
  }
}
