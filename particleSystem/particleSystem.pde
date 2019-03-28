PVector origin = new PVector(mouseX, mouseY);
ParticlesSet system = new ParticlesSet(origin);

void settings() {
  size(1200, 700, P3D);
}
void setup() {
    
}
void draw() {
  system.run();
}
