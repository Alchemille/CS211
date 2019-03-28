PVector location;
PVector velocity;

void settings() {
  size(1000, 300);
}

void setup() {
  background(0);
  location = new PVector(100, 100);
  velocity = new PVector(3, 3); // speed vector along each axis
}

void draw() {
  
  //background(255); // si actif, enlève toute la trace
  noStroke(); // WHY ??
  // WHY REMAINS TRACE OF TRACE ??
  fill(255, 10); // 10 is the level of opacity (to get the "trace" effect)
  // opacity => the previous positions are preserved by the change of background
  // more opacity => less preserved previous positions
  rect(0, 0, width, height); // to progressively erase the trace of circles. Every time, new rect applied

  // Add the current speed to the location.
  location.add(velocity);
  
  // if outOfBounds, inverse speed direction
  if ((location.x > width) || (location.x < 0)) { 
    velocity.x = velocity.x * -1;
  }
  if ((location.y > height) || (location.y < 0)) {
    velocity.y = velocity.y * -1;
  }
  
  // Display circle at its location
  stroke(0); // contour noir des cercles
  fill(random(255), random(255), random(255)); // remplissage de l'ellipse multi couleur
  ellipse(location.x, location.y, 16, 16);
  
}
