
// Constants
int WIDTH = 720;
int HEIGHT = 720;
int NUM_PARTICLES = 2000;
int SPEED = 6;
int MAX_AGE = 100;

ArrayList<Particle> particles = new ArrayList<Particle>();

void setup() {
  size(WIDTH, HEIGHT);
  smooth();
  background(255);
  frameRate(120);

  int seed = int(random(100000));
  print("Seed is", seed, "\n");
  randomSeed(seed);

  for (int i = 0; i < NUM_PARTICLES; i++) {
    particles.add(new Particle(random(0, WIDTH), random(0, HEIGHT)));
  }
}

void draw() {
  for (Particle p: particles) {
    p.update();
    p.display();
  }
}

class Particle {
  float x;
  float y;
  float prevx;
  float prevy;
  boolean alive;
  float age;

  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    this.prevx = x;
    this.prevy = y;
    this.alive = true;
    this.age = 0;
  }

  void update() {
    if (!alive) {
      return;
    }
    prevx = x;
    prevy = y;
    x += random(-SPEED, SPEED);
    y += random(-SPEED, SPEED);
    this.age += .1;
    if (age > MAX_AGE) {
      alive = false;
    }
  }

  void display() {
    stroke(map(age, 0, MAX_AGE, 255, 0));
    line(prevx, prevy, x, y);
  }

}


