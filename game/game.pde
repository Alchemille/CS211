
float valueX=0;
float valueZ=0;

float speed =1;

float rx;
float rz;

void settings() {
  size(1000, 600, P3D);
}
void setup() {
  noStroke();
}
void draw() {

  directionalLight(100, 100, 125, 0, 1, 0);
  ambientLight(102, 102, 102);
  background(200);

  translate(width/2, height/2, 0); // figure stays in center
  rotateX(rx); // applies rotation changes requested through mouseDragged
  rotateZ(rz);
  fill(100, 100, 0);
  box(300, 30, 300);
}


void mouseDragged() { // controls rotation around X and Z (the 2 axes of the screen)

  valueZ+=(mouseX-pmouseX)*speed; // difference between actual and previous position, weighted by speed
  valueX-=(mouseY-pmouseY)*speed;

  rx = map(valueX, 0, height, -PI/3, PI/3); // map change of position to change of angles
  rz = map(valueZ, 0, width, -PI/3, PI/3);
}

void mouseWheel() { // controls speed for the rotation
  mouseScale=-event.getCount();
  if (mouseScale>0) {
    speed = speed * 1.1;
  } else if (mouseScale<0) {
    speed = speed / 1.1;
  }
  println(speed);
}
