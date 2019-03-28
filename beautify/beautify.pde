PImage img;
PShape globe;
void settings() {
size(400, 400, P3D);
}
void setup() {
img = loadImage("earth.jpg");
globe = createShape(SPHERE, 50);
globe.setStroke(false);
globe.setTexture(img);
}
void draw() {
translate(width/2, height/2, 0);
shape(globe);
}
