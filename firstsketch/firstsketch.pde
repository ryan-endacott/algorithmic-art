
// Constants
int WIDTH = 720;
int HEIGHT = 540;
int NUM_CIRCLES = 40;
int MAX_RADIUS = 80;

int iteration = 0;
ArrayList<Circle> circles = new ArrayList<Circle>();

void setup() {
  size(WIDTH, HEIGHT);
  noStroke();
  smooth();
  background(255);
  frameRate(240); // for smoother lines when drawing multiple moving circles with velocity

  int seed = int(random(100000));
  print("Seed is ", seed, "\n");
  randomSeed(seed);

  for (int i = 0; i < NUM_CIRCLES; i++) {
    circles.add(new Circle(
          random(0, WIDTH),
          random(0, HEIGHT),
          random (30, MAX_RADIUS),
          pos_or_neg_random(.3, 2), // velx
          pos_or_neg_random(.3, 2), // vely
          random(-.001, .001), // accelx
          random(-.001, .001), // accely
          random(-.1, 0)));
  }
}

void draw() {
  for (Circle c: circles) {
    c.update(iteration);
    c.display();
  }
  iteration++;
}

void mousePressed() {
  saveFrame();
}

class Circle {
  float x;
  float y;
  float radius;
  float velx;
  float vely;
  float accelx;
  float accely;
  int greyscale;
  float greyscale_vel;

  Circle(float ix, float iy, float iradius, float ivelx, float ively,
      float iaccelx, float iaccely, float igreyscale_vel) {
    x = ix;
    y = iy;
    radius = iradius;
    velx = ivelx;
    vely = ively;
    accelx = iaccelx;
    accely = iaccely;
    greyscale = 255;
    greyscale_vel = igreyscale_vel;
  }

  void adjust_velocity() {
    velx += accelx;
    vely += accely;
  }

  void update(int iteration) {
    velx += accelx;
    vely += accely;
    x += velx;
    y += vely;
    greyscale += greyscale_vel;
    if (greyscale < 50) {
      greyscale = 50;
    }
  }

  void display() {
    fill(greyscale);
    float halfrad = radius / 2;
    ellipse(x, y, radius, radius);
  }

}

float pos_or_neg_random(float min, float max) {
  float result = random(min, max);
  return result * random_sign();
}

int random_sign() {
  return int(random(2)) * 2 - 1;
}

