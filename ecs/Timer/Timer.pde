// Max Baker | 25 Mar 2026 | Timer

import processing.sound.*;

SoundFile alarm;

Button btnStart, btnStop, btnReset;

boolean running = false;
int startTime = 0;
int elapsed = 0;

void setup() {
  size(500, 500);

  alarm = new SoundFile(this, "TripleT.mp3");

  btnStart = new Button(width/2, 380, 120, 40, "Start");
  btnStop  = new Button(width/2, 430, 120, 40, "Stop");
  btnReset = new Button(width/2, 480, 120, 40, "Reset");
}

void draw() {
  background(20, 30, 60);

  if (running) {
    elapsed = millis() - startTime;
  }

  if (elapsed >= 10000 && elapsed < 11000) {
    if (!alarm.isPlaying()) {
      alarm.play();
    }
  }

  drawClock();
  drawTimeDisplay();

  btnStart.display();
  btnStop.display();
  btnReset.display();
}

void mousePressed() {
  if (btnStart.isMouseOver()) {
    running = true;
    startTime = millis() - elapsed;
  }

  if (btnStop.isMouseOver()) {
    running = false;
  }

  if (btnReset.isMouseOver()) {
    running = false;
    elapsed = 0;
  }
}

void drawClock() {
  pushMatrix();
  translate(width/2, height/2 - 50);

  fill(240);
  stroke(0);
  strokeWeight(3);
  ellipse(0, 0, 200, 200);

  float angle = radians((elapsed / 10) % 360);
  stroke(255, 0, 0);
  strokeWeight(4);
  line(0, 0, 80*cos(angle), 80*sin(angle));

  popMatrix();
}

void drawTimeDisplay() {
  fill(255);
  textAlign(CENTER);
  textSize(32);

  int ms = elapsed % 1000;
  int seconds = (elapsed / 1000) % 60;
  int minutes = elapsed / 60000;

  String timeStr = nf(minutes, 2) + ":" + nf(seconds, 2) + ":" + nf(ms, 3);
  text(timeStr, width/2, 300);
}
