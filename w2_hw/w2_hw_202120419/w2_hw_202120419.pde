void setup() {
  size(640, 480);
  background(255, 88, 122);
}


void draw() {
  size(640, 480);
  background(255, 88, 122);
  
  // ear_L
  fill(233, 223, 190);
  triangle(250, 170, 280, 110, 310, 170);

  // ear_R
  fill(233, 223, 190);
  triangle(330, 170, 360, 110, 390, 170);
  
  // face
  fill(233, 223, 190);
  circle(320, 240, 200);
  
  //eye_L
  fill(255);
  circle(280, 210, 60);
  
  // eye_pupil_L
  float leftPupilX = constrain(mouseX, 280 - 14, 280 + 14);
  float leftPupilY = constrain(mouseY, 210 - 14, 210 + 14);
  fill(0);
  circle(leftPupilX, leftPupilY, 20);
  
  //eye_R
  fill(255);
  circle(360, 210, 60);
  
  // eye_pupil_R
  float rightPupilX = constrain(mouseX, 360 - 14, 360 + 14); 
  float rightPupilY = constrain(mouseY, 210 - 14, 210 + 14);
  fill(0);
  circle(rightPupilX, rightPupilY, 20);
  
  //nose
  fill(189, 181, 157);
  ellipse(320, 250, 50, 30);
  
  //mouse
  noFill();
  arc(320, 250, 150, 100, 0, PI);
  drawFlower(mouseX, mouseY);
}

//flower
void drawFlower(float x, float y) {
  fill(133, 131, 255);
  
  //flower_leaves
  
  circle(x, y - 20, 40);  // 위쪽 꽃잎
  circle(x + 20, y, 40);  // 오른쪽 꽃잎
  circle(x, y + 20, 40);  // 아래쪽 꽃잎
  circle(x - 20, y, 40);  // 왼쪽 꽃잎
  
  //flower_center
  fill(255, 226, 131);
  circle(x, y, 30);  
}
