void setup() {
  size(640, 360);
  rectMode(CENTER);
}

void draw() {
  background(0);
  fill(150);
  stroke(225);

  if (mouseY > height / 4 * 3) {
    circle(width /2, height / 4 * 3.5, height / 5);
  } else if (mouseY > height / 4 * 2) {
    rect(width / 4 * 2, height / 4 * 2.5, width / 4, height / 9, 6);
  } else if (mouseY > height / 4 * 1) {
    square(width / 4 * 2, height / 4 * 1.5, width / 8.5);
  } else if (mouseY > height / 4 * .5) {
    line(width / 10 * 4.5, height / 28, width / 8 * 4.5, height / 4.5);
  }



  stroke(127);
  strokeWeight(4);
  line(0, height /4, width, height / 4);
  line(0, height /4 * 2, width, height / 4 * 2);
  line(0, height /4 * 3, width, height / 4 * 3);
}
