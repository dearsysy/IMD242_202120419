int[] drinkAmt = new int[5];
String[] drinkNames = {"Juice", "Latte", "Water", "Americano", "Tea"};

void setup() {
  size(1280, 720);
  menuBoard();

  for (int idx = 0; idx < drinkAmt.length; idx++) {
    drinkAmt[idx] = int(random(5, 100));
  }
}

float barWidth = 24;
float graphBegin = 200 + 880 / 4;
float graphGap = 120;

void draw () {

  menuBoard();
  strokeWeight(barWidth);
  stroke(0);
  strokeCap(SQUARE);
  textAlign(CENTER);
  textSize(24);
  fill(0);

  for (int idx = 0; idx < drinkAmt.length; idx++) {
    float x = graphBegin + idx * graphGap;
    line(x, height * 0.5, x, height * 0.5 - drinkAmt[idx]);
    text(drinkNames[idx], x, height * 0.5 + 50);
    text(drinkAmt[idx], x, height * 0.5 - drinkAmt[idx] - 16);
  }

  float sum = drinkAmt[0] + drinkAmt[1] +
    drinkAmt[2] + drinkAmt[3] + drinkAmt[4];

  float average = sum / 5;

  text("Total of drinks : " + int(sum),
    width * 0.5, height * 0.5 + 130);
  text("Average Number of drinks : " + int(average),
    width * 0.5, height * 0.5 + 160);
}


void menuBoard() {

  background(255); 


  stroke(100);
  strokeWeight(4);
  fill(220, 180, 140); 
  rect(20, 20, width - 40, height - 40, 20); 

  fill(255); 
  rect(30, 30, width - 60, height - 60);  

  fill(255, 204, 0);
  rect(30, 30, width - 60, 80); 

  fill(0);
  textAlign(CENTER);
  textSize(30);
  text("Today's popular menu", width * 0.5, 80);
}
