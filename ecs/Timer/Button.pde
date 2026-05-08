class Button {
  int x, y, w, h;
  String label;

  Button(int x, int y, int w, int h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }

  void display() {
    rectMode(CENTER);

    if (isMouseOver()) {
      fill(70, 120, 200);
    } else {
      fill(40, 80, 160);
    }

    noStroke();
    rect(x, y, w, h, 8);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(18);
    text(label, x, y);
  }

  boolean isMouseOver() {
    return mouseX > x - w/2 &&
           mouseX < x + w/2 &&
           mouseY > y - h/2 &&
           mouseY < y + h/2;
  }
}
