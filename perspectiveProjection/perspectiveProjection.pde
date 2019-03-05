/*
void settings() {
  size (400, 400, P2D);
}
void setup() {
}

void draw() {
  My3DPoint eye = new My3DPoint(-100, -100, -5000);
  My3DPoint origin = new My3DPoint(0, 0, 0); //The first vertex of your cuboid
  My3DBox input3DBox = new My3DBox(origin, 100, 150, 300);
  projectBox(eye, input3DBox).render();
}
*/

class My2DPoint {
  float x;
  float y;
  My2DPoint(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class My3DPoint {
  float x;
  float y;
  float z;
  My3DPoint(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

My2DPoint projectPoint(My3DPoint eye, My3DPoint p) {

  My2DPoint pp = new My2DPoint((p.x - eye.x)/(-p.z/eye.z + 1), (p.y - eye.y)/(-p.z/eye.z + 1));
  return pp;
}

class My2DBox {
  My2DPoint[] s; // array of 8 2dpoints
  My2DBox(My2DPoint[] s) {
    this.s = s;
  }
  void render() {
    // Complete the code! use only line(x1, y1, x2, y2) built-in function.
    line(s[0].x, s[0].y, s[1].x, s[1].y);
    line(s[1].x, s[1].y, s[2].x, s[2].y);
    line(s[2].x, s[2].y, s[3].x, s[3].y);
    line(s[0].x, s[0].y, s[3].x, s[3].y);
    line(s[4].x, s[4].y, s[5].x, s[5].y);
    line(s[5].x, s[5].y, s[6].x, s[6].y);
    line(s[6].x, s[6].y, s[7].x, s[7].y);
    line(s[7].x, s[7].y, s[4].x, s[4].y);
    line(s[0].x, s[0].y, s[4].x, s[4].y);
    line(s[3].x, s[3].y, s[7].x, s[7].y);
    line(s[5].x, s[5].y, s[1].x, s[1].y);
    line(s[2].x, s[2].y, s[6].x, s[6].y);
  }
}

class My3DBox {
  My3DPoint[] p;
  My3DBox(My3DPoint origin, float dimX, float dimY, float dimZ) {
    float x = origin.x;
    float y = origin.y;
    float z = origin.z;
    this.p = new My3DPoint[]{new My3DPoint(x, y+dimY, z+dimZ), 
      new My3DPoint(x, y, z+dimZ), 
      new My3DPoint(x+dimX, y, z+dimZ), 
      new My3DPoint(x+dimX, y+dimY, z+dimZ), 
      new My3DPoint(x, y+dimY, z), 
      origin, 
      new My3DPoint(x+dimX, y, z), 
      new My3DPoint(x+dimX, y+dimY, z)
    };
  }
  My3DBox(My3DPoint[] p) {
    this.p = p;
  }
}

My2DBox projectBox (My3DPoint eye, My3DBox box) {
  // Complete the code!
  //MyD2Box box = new My2DBox([7]); 

  My2DPoint p0 = projectPoint(eye, box.p[0]);
  My2DPoint p1 = projectPoint(eye, box.p[1]);
  My2DPoint p2 = projectPoint(eye, box.p[2]);
  My2DPoint p3 = projectPoint(eye, box.p[3]);
  My2DPoint p4 = projectPoint(eye, box.p[4]);
  My2DPoint p5 = projectPoint(eye, box.p[5]);
  My2DPoint p6 = projectPoint(eye, box.p[6]);
  My2DPoint p7 = projectPoint(eye, box.p[7]);

  My2DPoint[] pp = new My2DPoint[]{p0, p1, p2, p3, p4, p5, p6, p7};

  return new My2DBox(pp);
}

float[] homogeneous3DPoint (My3DPoint p) {
  float[] result = {p.x, p.y, p.z, 1};
  return result;
}


float[][] rotateYMatrix(float angle) {
  return(new float[][]  
    {{cos(angle), 0, -sin(angle), 0}, 
    {0, 1, 0, 0}, 
    {-sin(angle), 0, cos(angle), 0}, 
    {0, 0, 0, 1}});
}
float[][] rotateXMatrix(float angle) {
  return(new float[][] 
    {{1, 0, 0, 0},
    {0, cos(angle), -sin(angle), 0},  
    {0, sin(angle), cos(angle), 0}, 
    {0, 0, 0, 1}});
}
float[][] rotateZMatrix(float angle) {
  return(new float[][] 
    {{cos(angle), -sin(angle), 0, 0}, 
    {sin(angle), cos(angle), 0, 0}, 
    {0, 0, 1, 0}, 
    {0, 0, 0, 1}});
}
float[][] scaleMatrix(float x, float y, float z) {
  return(new float[][]
    {{x, 0, 0, 0}, 
    {0, y, 0, 0}, 
    {0, 0, z, 0}, 
    {0, 0, 0, 1}});
}
float[][] translationMatrix(float x, float y, float z) {
  return(new float[][]
    {{1, 0, 0, x}, 
    {0, 1, 0, y}, 
    {0, 0, 1, z}, 
    {0, 0, 0, 1}});
}

float[] matrixProduct(float[][] a, float[] b) {

  //Complete the code!
  float[] mult = new float[4];

  for (int i=0; i<=3; i++) {

    mult[i] = 0;

    for (int j=0; j<=3; j++) {

      mult[i] += a[i][j]*b[j];
    }
  }
  return mult;
}

My3DBox transformBox(My3DBox box, float[][] transformMatrix) {
  //Complete the code! You need to use the euclidian3DPoint() function given below.

  My3DBox newBox = new My3DBox(new My3DPoint[8]);

  for (int i=0; i<=7; i++) {

    // creation of 4D homogenous vector
    float[] b = homogeneous3DPoint(box.p[i]);

    // apply transformation
    float[] res = matrixProduct(transformMatrix, b);

    // get 3D vector again
    My3DPoint eucl = euclidian3DPoint(res);
    newBox.p[i] = eucl;
  }
  return newBox;
}

My3DPoint euclidian3DPoint (float[] a) {
  My3DPoint result = new My3DPoint(a[0]/a[3], a[1]/a[3], a[2]/a[3]);
  return result;
}
