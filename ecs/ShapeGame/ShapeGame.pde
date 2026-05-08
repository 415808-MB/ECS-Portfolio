// Max Baker | 4 Mar 2026 | ShapeGame

int x, y, tx, ty, score;
float tw;
float vx = 0;
float vy = 0;
float speed = 4;

PImage player;
PImage target;

void setup() {
  size(500, 500);
  x = width/2;
  y = height/2;
  tx = int(random(20, width-20));
  ty = int(random(20, height-20));
  tw = 200;
  score = 0;
  player = loadImage("Character.png");
  target = loadImage("Object.png");
}

void draw() {
  background(0, 0, 130);
  scorePanel();
  checkTarget();
  x += vx;
  y += vy;

  imageMode(CENTER);
  image(player, x, y);
  image(target, tx, ty, tw, tw);
}

void checkTarget() {
  float d = dist(x, y, tx, ty);

  if (d < 35) {
    score += 50;
    tx = int(random(20, width-20));
    ty = int(random(20, height-20));
    tw = 200;
  }

  if (tw < 10) {
    gameOver();
  }

  tw -= 0.75;
}

void gameOver() {
  background(0);
  fill(255, 0, 0);
  textSize(40);
  textAlign(CENTER);
  text("Game Over!", width/2, height/2);
  noLoop();
}

void scorePanel() {
  rectMode(CENTER);
  fill(0, 250, 250);
  rect(width/2, 15, width, 30);

  fill(0);
  textSize(25);
  textAlign(LEFT);
  text("Score: " + score, 20, 25);
}

void keyPressed() {

  if (key == 'w' || key == 'W' || keyCode == UP) {
    vy = -speed;
  }
  if (key == 's' || key == 'S' || keyCode == DOWN) {
    vy = speed;
  }
  if (key == 'a' || key == 'A' || keyCode == LEFT) {
    vx = -speed;
  }
  if (key == 'd' || key == 'D' || keyCode == RIGHT) {
    vx = speed;
  }
}

void keyReleased() {

  if (key == 'w' || key == 'W' || keyCode == UP || 
      key == 's' || key == 'S' || keyCode == DOWN) {
    vy = 0;
  }

  if (key == 'a' || key == 'A' || keyCode == LEFT || 
      key == 'd' || key == 'D' || keyCode == RIGHT) {
    vx = 0;
  }
}
