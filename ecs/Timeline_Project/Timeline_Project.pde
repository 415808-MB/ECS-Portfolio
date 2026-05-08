// Max Baker | 23 Feb 2026 | Timeline Project

String[] titles = {
  "Egyptian Boat Races",
  "Oxford–Cambridge Race",
  "Detroit Boat Club",
  "Women’s Rowing Clubs",
  "Rowing in Olympics",
  "Women in Olympics",
  "Lightweight Rowing",
  "Carbon-Fiber Shells"
};

String[] dates = {
  "May 1430 BCE",
  "June 1829",
  "July 1839",
  "April 1892",
  "May 1900",
  "July 1976",
  "July 1996",
  "March 1995"
};

String[] details = {
  "Early Egyptian boat races on the Nile show the first known rowing competitions.",
  "The first Oxford–Cambridge Boat Race is held in England.",
  "The Detroit Boat Club is founded, starting organized rowing in the U.S.",
  "Early women’s rowing clubs begin forming, giving women sport access.",
  "Rowing is included in the Paris Olympic Games as an official sport.",
  "Women’s rowing events are held for the first time at the Montreal Olympics.",
  "Lightweight rowing events are added to the Olympic program in Atlanta.",
  "Composite materials replace wood, making boats lighter and faster."
};

int[] positions = {1,2,3,4,5,6,7,8};

void setup() {
  size(950, 400);
  textSize(14);
  rectMode(CENTER);
}

void draw() {
  drawBackground();
  drawRef();
  histEvent();
}

void drawBackground() {
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    int c = lerpColor(color(255,32, 1), color(255, 32, 1), inter);
    stroke(c);
    line(0, y, width, y);
  }
}

void drawRef() {
  stroke(0);
  strokeWeight(2);
  line(75, 200, 875, 200);

  textAlign(CENTER);
  textSize(13);

  for (int i = 0; i < positions.length; i++) {
    float x = map(positions[i], 1, 8, 75, 875);

    strokeWeight(2);
    line(x, 195, x, 205);

    fill(255);
    text(dates[i], x, 225);
  }
}

void histEvent() {
  textAlign(CENTER);
  textSize(16);

  for (int i = 0; i < titles.length; i++) {
    float x = map(positions[i], 1, 8, 75, 875);
    float y = (i % 2 == 0) ? 150 : 260;

    float w = textWidth(titles[i]) + 30;

    stroke(0);
    strokeWeight(2);
    line(x, 200, x, y - 15);

    noStroke();
    fill(0, 150);
    rect(x + 3, y - 10, w, 28);

    fill(0);
    rect(x, y - 12, w, 25);

    fill(255);
    text(titles[i], x, y);

    if (mouseX > x - w/2 && mouseX < x + w/2 &&
        mouseY > y - 25 && mouseY < y + 5) {

      float boxW = 320;
      float boxH = 120;


      float boxX = mouseX;
      float boxY;
      if (i % 2 == 0) {
        boxY = y - 90;  
      } else {
        boxY = y + 90;  
      }

      boxX = constrain(boxX, boxW/2 + 10, width - boxW/2 - 10);

      fill(0);
      rect(boxX + 4, boxY + 4, boxW, boxH);

   
      fill(250, 250, 250);
      rect(boxX, boxY, boxW, boxH);


      fill(0);
      textSize(16);
      text(details[i], boxX, boxY, boxW - 20, boxH - 20);
      textSize(14);
    }
  }
}
