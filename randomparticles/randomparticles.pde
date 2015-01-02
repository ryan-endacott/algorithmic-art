
// Constants
int WIDTH = 720;
int HEIGHT = WIDTH;
int NUM_PARTICLES = 2000;
int SPEED = 1;
int MAX_AGE = 100;
float AGE_SPEED = .2;

// Modify this to control how much particles tend to go in a certain direction.
// Lower numbers make them tend to go more in a certain direction.
float DIRECTION_FACTOR = 1.5;

// Modify this to change how far the particles spawn from the border of the screen.
int BORDER = WIDTH / 2;

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

class Particle {
  float x;
  float y;
  float velx;
  float vely;
  float prevx;
  float prevy;
  boolean alive;
  float age;

  Particle(float x, float y, float velx, float vely) {
    this.x = x;
    this.y = y;
    this.velx = velx;
    this.vely = vely;
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
    x += velx;
    y += vely;
    this.age += AGE_SPEED;
    if (age > MAX_AGE) {
      alive = false;
    }
  }

  void display() {
    stroke(map(age, 0, MAX_AGE, 255, 0));
    line(prevx, prevy, x, y);
  }

}


