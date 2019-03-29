float speed = 2;
float d_y;
float d_x;
float d_angle;
float inclinaison = 0.15;
float angle = 0.0;
float y = 3*height/2;
float x = 0;

float previous_t1_1 = 0.0;
float previous_t1_2 = 0.0;
float previous_t2_1 = 0.0;
float previous_t2_2 = 0.0;
float current_t1;
float current_t2;

PShape t1;
PShape t2;

void setup() {
  background(0);
  size(1100, 500);
  smooth();
  noStroke();
}

void draw() {

  // draw mountains
  if (y < height) {
    draw_mountains();
  }
}

void draw_mountains() {

  fill(0, 30);
  stroke (255, 40);
  angle = angle - 0.02;

  translate(x, y); //set the y coordinate of the circle
  rotate(angle); 

  t1 = createShape(TRIANGLE, -50, -50, -30, 30, -90, -60);
  t2 = createShape(TRIANGLE, -50, 0, -20, 20, 110, 2);
  shape(t1);
  shape(t2);

  fire_on();

  // update x and y for next rendering
  x = x + speed;
  y = y + inclinaison;

  if (x > width) {
    inclinaison = -inclinaison;
    d_y = random(20, 40);
    d_x = random(-50, -500);
    x = d_x;
    y = y + d_y;
  }
}

void fire_on() {

  // detect local extrema of triangles
  //fill(240, 127, 19, 140);
  current_t1 = screenX(-90, -60);
  current_t2 = screenY(110, 2);

  if (previous_t1_1 < previous_t1_2 && previous_t1_1 < current_t1) {
    fill(128, 9, 9);
    circle(-94, -68, 7);
    fill(240, 127, 19, 200);
    circle(-94, -68, 10);
    fill(253, 207, 88, 120);
    circle(-94, -68, 17);
  }
  previous_t1_2 = previous_t1_1;
  previous_t1_1 = current_t1;

  if (previous_t2_1 < previous_t2_2 && previous_t2_1 < current_t2) {
    fill(128, 9, 9);
    circle(110, 2, 7);
    fill(240, 127, 19, 200);
    circle(110, 2, 10);
    fill(253, 207, 88, 120);
    circle(110, 2, 17);
  }
  previous_t2_2 = previous_t2_1;
  previous_t2_1 = current_t2;
}
