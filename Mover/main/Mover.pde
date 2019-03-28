float Y = 0.5; // if higher, effets de bord Processing

class Mover {

  PVector location;
  PVector velocity;
  PVector gravity;

  Mover() { // constructor
    location = new PVector(width/2, height/2);
    velocity = new PVector(3, 3);
    gravity = new PVector(0, Y);
  }
  void update() {
    velocity.add(gravity);
    location.add(velocity);
  }
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(location.x, location.y, 48, 48);
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
