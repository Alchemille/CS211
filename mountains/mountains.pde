float speed = 2;
float d_y;
float d_x;
float d_angle;
float inclinaison = 0.15;
float angle = 0.0;
float y = height;
float x = 0;


void setup() {
  size(800, 500);
  smooth();
  noStroke();
}

void draw() {

  if (y > 0) {
    draw_mountains();
  }
}

void draw_mountains() {
  d_angle = random(0.005, 0.03);

  fill(0, 30);
  stroke (255, 40);
  angle = angle - 0.02;

  translate(x, y); //set the y coordinate of the circle
  rotate(angle); 

  //triangle(-50, -50, -50, -50, 30, 30); //outer white
  triangle(-50, -50, -10, 30, -90, -60); //inner white
  triangle(-50, 0, -20, 10, 110, 2);  //black

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
