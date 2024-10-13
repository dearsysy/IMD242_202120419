void setup() {
  rectMode(CENTER);
  background(0);
  size(800, 800);
}


void draw() {

  noStroke();
  //큰
  fill(255);
  circle(400, 400, 700);
  float radius = 700;

  int s = second();
  int m = minute();
  int h = hour();

  //second line
  pushMatrix();
  rectMode(CENTER);
  translate(400, 400);
  rotate(radians(6*s));
  stroke(255, 0, 0);
  strokeWeight(6);
  line(0, -40, 0, 280);
  popMatrix();

  //minute line
  pushMatrix();
  rectMode(CENTER);
  translate(400, 400);
  rotate(radians(6*m));
  stroke(0);
  strokeWeight(6);
  line(0, 0, 0, 300);
  popMatrix();

  //hour line
  pushMatrix();
  rectMode(CENTER);
  translate(400, 400);
  rotate(radians(15*h));
  stroke(0);
  strokeWeight(6);
  line(0, 0, 0, 240);
  popMatrix();

  //중심
  noStroke();
  fill(255, 0, 0);
  circle(400, 400, 30);

  //정각표시
  for (int i=0; i<360; i+=30) {
    float angle = radians(i);

    pushMatrix();
    translate(400, 400);
    rotate(angle);
    stroke(0);
    strokeWeight(4);
    line (-330, 0, -350, 0);
    popMatrix();
  }

  //분 표시
  for (int k=0; k<360; k+=6) {
    float angle = radians(k);

    pushMatrix();
    translate(400, 400);
    rotate(angle);
    stroke(0);
    strokeWeight(2);
    line (-340, 0, -350, 0);
    popMatrix();
  }
}
