// aim of program: draw a tornado that passes through a transparent 3D sphere
// problem: tornado not visible inside the sphere

float y;
float x;

float r_sphere = 300;
float r_triangle;
float rB = 80.;
float rM = 50.;
float rS = 30.;

float angle = 0.01;
float up_down = 5;
float left_right = 0;
int s = 1;
PShape torn, tornM, tornS;
float cx, cy;

boolean init=true;
boolean init_long = false;

void setup() {

  size(1100, 800, P3D);
  background(0);
  //noFill();
  fill(0);

  torn = createShape();
  torn.beginShape(TRIANGLES);
  torn.stroke (255, 140, 0);
  torn.strokeWeight(3);
  torn.vertex(0, 0, 0);
  torn.vertex(rB, 0, 0);
  torn.vertex(rB, 0, rB/2);
  torn.endShape(CLOSE); 

  tornM = createShape();
  tornM.beginShape(TRIANGLES);
  tornM.stroke (255, 140, 0);
  tornM.strokeWeight(3);
  tornM.vertex(0, 0, 0);
  tornM.vertex(rM, 0, 0);
  tornM.vertex(rM, 0, rM/2);
  tornM.endShape(CLOSE); 

  tornS = createShape();
  tornS.beginShape(TRIANGLES);
  tornS.stroke (255, 140, 0);
  tornS.strokeWeight(3);
  tornS.vertex(0, 0, 0);
  tornS.vertex(rS, 0, 0);
  tornS.vertex(rS, 0, rS/2);
  tornS.endShape(CLOSE); 


  x = 0;
  y = 0-r_sphere;

  cx = modelX(width/2, height/2, 0);
  cy = modelY(width/2, height/2, 0);
}

void draw() {

  // 2. draw the transparent sphere in the initial referential

  print(init);

  translate(width/2, height/2);

  if (init == true) {
    strokeWeight(0.5);
    stroke(255, 140, 0);
    sphere(r_sphere);
    init_long = true;
  } else if (init_long == true) {

    delay(100);
    strokeWeight(0.1);
    stroke(155, 220, 220);
    sphere(r_sphere);
    init_long = false;
  }

  // 1. draw tornado in new referential

  pushMatrix();

  // define new referential for the tornado triangle at each rendering
  manageOrientation();
  translate(x, y);
  y += s*up_down;
  rotateY(angle);
  angle += 10;
  x += checkTornado();

  r_triangle = tornadoSize();
  if (r_triangle == rB) shape(torn);
  else if (r_triangle == rS) shape (tornS);
  else shape(tornM);

  popMatrix();
}

void reinitUp() {
  s*=-1;
  init = true;
  fill(0);
  y = 0-r_sphere;
  x = 0;
}

void reinitDown() {
  s*=-1;
  init = true;
  fill(0);
  y = 0+r_sphere;
  x = 0;
}

void manageOrientation() {
  if (y>0+r_sphere) {
    reinitDown();
  } else if (y<0-r_sphere) {
    reinitUp();
  } else {
    //noFill();
    init = false;
  }
}

float checkTornado() {

  float step = random(-5, 5);

  float t1x = modelX(r_triangle, 0, 0);
  float t2x = modelX(r_triangle, 0, r_triangle/2);
  float t3x = modelX(0, 0, 0);
  float t1y = modelY(r_triangle, 0, 0);
  float t2y = modelY(r_triangle, 0, r_triangle/2);
  float t3y = modelY(0, 0, 0);

  float d1 = sqrt(sq(t1x-cx)+sq(t1y-cy));
  float d2 = sqrt(sq(t2x-cx)+sq(t2y-cy));
  float d3 = sqrt(sq(t3x-cx)+sq(t3y-cy));

  if (d1>r_sphere + 10 || d2>r_sphere + 10 || d3>r_sphere + 10) {
    reinitUp();
  }

  return step;
}

float tornadoSize() {

  if (y <= 0 + r_sphere/4 && y >= 0 - r_sphere/4) return rB;
  else if (y >= 0+ 2*r_sphere/3 || y<= 0 - 2*r_sphere/3) return rS;
  else return rM;
}
