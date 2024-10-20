int randomSeedValue;

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100);
  background(228, 72, 33); 
  randomSeedValue = int(random(10000));
  house(); 

  fill(61, 46, 100); //달 
  ellipse(650, 150, 80, 80);
}

void mousePressed() {
  background(228, 72, 33);  
  randomSeedValue = int(random(10000)); 
  house();  

  fill(61, 46, 100);  //달 
  ellipse(650, 150, 80, 80); 
}

void house() {
  float houseW = random(80, 300);
  float houseH = random(200, 400);  
  float roofW = houseW + random(20, 60);  
  float roofHeight = houseH * 0.08; 
  float roofWidth = houseW * 1.1;
  float x = random(0.1 * width, 0.9 * width - roofW);  
  float groundY = height - houseH - roofHeight;  

  noStroke();
  fill(random(360), random(20, 40), random(80, 100));  

  rect(x - (roofWidth - houseW) / 2, groundY + houseH, roofWidth, roofHeight); 
  rect(x - (roofWidth - houseW) / 2, groundY - roofHeight, roofWidth, roofHeight);

  noStroke();
  fill(random(360), random(20, 40), random(80, 100));
  rect(x, groundY, houseW, houseH); 


  int windowsNum = int(random(1, 4));  
  float windowW = houseW * 0.3;  
  float windowH = houseH * 0.15; 

  for (int i = 0; i < windowsNum; i++) {
    float windowX = x + (houseW - windowW) / 2;
    float windowY = groundY + (houseH - windowH) / (windowsNum + 1) * (i + 1);

    noStroke();
    fill(random(360), random(0), random(100, 200));
    rect(windowX, windowY, windowW, windowH);  
  }
}


void draw() {
}
