// Max Baker | 18 Mar 2026 | Slot Machine

String[] symbols = {"7️⃣", "🍒", "🟥BAR"};

int[] reel = {0, 0, 0};
int[] target = {0, 0, 0};
boolean spinning = false;

float[] reelSpeed = {25, 25, 25};
float slowDownRate = 0.25;

int money = 100;
int bet = 10;

boolean lost = false;
boolean showLoseScreen = false;
boolean showBankruptScreen = false;

int stop1, stop2, stop3;
int startTime;

PFont emojiFont;

int btnX = 520;
int btnY = 200;
int btnW = 60;
int btnH = 120;

void setup() {
  size(600, 400);
  textAlign(CENTER, CENTER);

  try {
    emojiFont = createFont("Segoe UI Emoji", 40);
  } catch (Exception e) {
    emojiFont = createFont("Arial", 40);
  }

  textFont(emojiFont);
}

void draw() {

  if (showBankruptScreen) {
    drawBankruptScreen();
    return;
  }

  if (showLoseScreen) {
    drawLoseScreen();
    return;
  }

  background(10, 80, 20);

  drawMachineFrame();
  drawReels();
  drawMoney();
  drawBetAllButton();

  if (!spinning && reel[0] == reel[1] && reel[1] == reel[2]) {
    fill(255, 215, 0);
    textSize(50);
    text("YOU WIN!", width/2, 60);
  }

  if (!spinning && lost) {
    fill(255, 50, 50);
    textSize(40);
    text("YOU LOSE", width/2, 60);
  }
}

void drawLoseScreen() {
  background(0);
  fill(255, 0, 0);
  textSize(60);
  text("GAME OVER", width/2, height/2 - 40);

  fill(255);
  textSize(30);
  text("Press R to Restart", width/2, height/2 + 40);
}

void drawBankruptScreen() {
  background(20, 0, 0);
  fill(255, 0, 0);
  textSize(60);
  text("BANKRUPT!", width/2, height/2 - 40);

  fill(255);
  textSize(30);
  text("Press R to Restart", width/2, height/2 + 40);
}

void drawMachineFrame() {
  fill(180, 0, 0);
  rect(50, 50, 500, 300, 20);

  fill(40);
  rect(100, 120, 400, 160, 10);
}

void drawReels() {
  textSize(40);

  for (int i = 0; i < 3; i++) {
    float x = 175 + i * 125;
    float y = 200;

    fill(255);
    rect(x - 50, y - 50, 100, 100, 10);

    fill(0);
    text(symbols[reel[i]], x, y);
  }

  if (spinning) updateSpin();
}

void drawMoney() {
  fill(255);
  textSize(24);
  text("Money: $" + money, width/2, 350);
  text("Bet: $" + bet, width/2, 320);
}

void drawBetAllButton() {
  fill(255, 200, 0);
  rect(btnX, btnY, btnW, btnH, 10);

  fill(0);
  textSize(18);
  text("BET\nALL", btnX + btnW/2, btnY + btnH/2);
}

void mousePressed() {
  if (!spinning && money > 0) {
    if (mouseX > btnX && mouseX < btnX + btnW &&
        mouseY > btnY && mouseY < btnY + btnH) {
      startBetAllSpin();
    }
  }
}

void keyPressed() {
  if (showLoseScreen || showBankruptScreen) {
    if (key == 'r' || key == 'R') resetGame();
    return;
  }

  if (key == ' ' && !spinning && money >= bet) {
    startSpin();
  }

  if (keyCode == ENTER && !spinning && money > 0) {
    startBetAllSpin();
  }
}

void startSpin() {
  spinning = true;
  lost = false;

  money -= bet;

  for (int i = 0; i < 3; i++) {
    target[i] = int(random(symbols.length));
    reelSpeed[i] = 25;
  }

  startTime = millis();
  stop1 = startTime + 1200;
  stop2 = startTime + 1800;
  stop3 = startTime + 2400;
}

void startBetAllSpin() {
  spinning = true;
  lost = false;

  bet = money; 
  money -= bet;

  for (int i = 0; i < 3; i++) {
    target[i] = int(random(symbols.length));
    reelSpeed[i] = 25;
  }

  startTime = millis();
  stop1 = startTime + 1200;
  stop2 = startTime + 1800;
  stop3 = startTime + 2400;
}

void updateSpin() {
  int now = millis();

  if (now < stop1) {
    reel[0] = (reel[0] + 1) % symbols.length;
    reelSpeed[0] -= slowDownRate;
    delay((int)reelSpeed[0]);
  } else {
    reel[0] = target[0];
  }

  if (now < stop2) {
    reel[1] = (reel[1] + 1) % symbols.length;
    reelSpeed[1] -= slowDownRate;
    delay((int)reelSpeed[1]);
  } else {
    reel[1] = target[1];
  }

  if (now < stop3) {
    reel[2] = (reel[2] + 1) % symbols.length;
    reelSpeed[2] -= slowDownRate;
    delay((int)reelSpeed[2]);
  } else {
    reel[2] = target[2];
  }

  if (now > stop3) {
    spinning = false;

    boolean win = (reel[0] == reel[1] && reel[1] == reel[2]);

    if (win) {
      if (bet == money + bet) {
        money += 100;
        increaseBet();
      } else {
        money += bet * 3;
      }
      lost = false;
    } else {
      lost = true;
    }

    if (money <= 0) {
      showBankruptScreen = true;
    }
  }
}

void increaseBet() {
  if (bet == 10) {
    bet = 10 + (int)(10 * 0.25);
  } else {
    bet *= 2;
  }
}

void resetGame() {
  money = 100;
  bet = 10;
  lost = false;
  spinning = false;
  showLoseScreen = false;
  showBankruptScreen = false;
}
