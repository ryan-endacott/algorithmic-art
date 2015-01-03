
// Constants
int WIDTH = 720;
int HEIGHT = WIDTH;
int NUM_PARTICLES = 200;
float SPEED = 10;
int MAX_AGE = 1000;
float AGE_SPEED = .2;

// Modify this to control how quickly particles rotate around the center of the screen.
float ROTATION_VALUE = .015;

// Controls if particles with a low speed are killed so all particles escape the center.
float MIN_SPEED = 0;

// Modify this to control how much particles tend to go in a certain direction.
// Lower numbers make them tend to go more in a certain direction.
float DIRECTION_FACTOR = 2;

// Modify this to change how far the particles spawn from the border of the screen.
int BORDER = WIDTH / 4;

ArrayList<Particle> particles = new ArrayList<Particle>();

void setup() {
  size(WIDTH, HEIGHT);
  smooth();
  background(0);

  int seed = int(random(100000));
  print("Seed is", seed, "\n");
  randomSeed(seed);

  for (int i = 0; i < NUM_PARTICLES; i++) {
    particles.add(new Particle(
          random(0 + BORDER, WIDTH - BORDER),
          random(0 + BORDER, HEIGHT - BORDER),
          random(-SPEED / DIRECTION_FACTOR, SPEED / DIRECTION_FACTOR),
          random(-SPEED / DIRECTION_FACTOR, SPEED / DIRECTION_FACTOR)));
  }
}

void draw() {
  for (Particle p: particles) {
    p.update();
    p.display();
  }
}

void mousePressed() {
  saveFrame();
}

class Particle {
  float x;
  float y;
  PVector vel;
  float prevx;
  float prevy;
  boolean alive;
  float age;

  Particle(float x, float y, float velx, float vely) {
    this.x = x;
    this.y = y;
    this.vel = new PVector(velx, vely);
    this.prevx = x;
    this.prevy = y;
    this.alive = true;
    this.age = 0;
    if (abs(vel.x) < MIN_SPEED && abs(vel.y) < MIN_SPEED) {
      alive = false;
    }
  }

  void update() {
    if (!alive) {
      return;
    }
    prevx = x;
    prevy = y;
    x += random(-SPEED, SPEED);
    y += random(-SPEED, SPEED);
    x += vel.x;
    y += vel.y;
    vel.rotate(ROTATION_VALUE);
    age += AGE_SPEED;
    if (age > MAX_AGE) {
      alive = false;
    }
  }

  void display() {
    stroke(map(age, 0, MAX_AGE, 255, 0));
    line(prevx, prevy, x, y);
  }

}


