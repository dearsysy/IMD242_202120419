int tileNum;
int randomSeed = 0;
float noiseMult = 0.001;


void setup() {
  size(800, 800);
}


void draw() {
  noiseSeed(randomSeed);
  randomSeed(1);
  background(0);
  tileNum  = int(map (mouseX, 0, width, 3, 15+1));
  noiseMult = pow(200, map(mouseY, 0, height, -1, -5));
  float tileSize = width / float(tileNum);
  
  for (int row = 0; row < tileNum; row++) {
    for (int col = 0; col < tileNum; col++) {
      float rectY = tileSize * row;
      float rectX = tileSize * col;
      float centerX = rectX + tileSize * 0.5;
      float centerY = rectY + tileSize * 0.5;
      float noiseVal = noise(centerX * noiseMult, centerY * noiseMult);

      fill(0);
      stroke(255);
      strokeWeight(1);
      circle(centerX, centerY, tileSize);

      pushMatrix();
      translate(centerX, centerY);
      rotate(radians(-180 + 360 * noiseVal));
      line(0, 0, tileSize * 0.5, 0);
      noStroke();
      fill(255);
      circle(tileSize * 0.001 + tileSize * 0.4, tileSize * 0.001 - tileSize * 0.005, tileSize * 0.2);
      popMatrix();
      
    }
  }
}
