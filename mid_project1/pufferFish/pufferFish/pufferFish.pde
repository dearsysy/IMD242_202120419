//참고 코드 open processing - dancing trees by Sophia Wood
//부분적으로 chatGPT 사용, 해당 코드 위 표시


Ball ball;
SpikeManager spikeManager;

ArrayList<Ball> balls = new ArrayList<>();
ArrayList<Line> lines = new ArrayList<>();
ArrayList<Spike> spikes = new ArrayList<>();

float t, angle; //t를 활용해 시간의 변화값 받음
float n; //중심 패턴의 반복 횟수
float v2, v3;
int ballCount = 0;
int lineCount = 0;

void setup() {
  fullScreen();
  background(0);
  n = 20;

  //AI생성, 중앙 패턴에 시간에 따라 반복되는 애니메이션을 주고자 함
  float sineValue = sin(PI * (millis() / 5000.0));
  t = (0.06 * sineValue + 0.4) / 1.8;
  spikeManager = new SpikeManager();
}

void draw() {
  fullScreen();
  background(0);
  drawPattern();

  //AI생성, 중앙 패턴에 시간에 따라 반복되는 애니메이션을 주고자 함
  float sineValue = sin(PI * (millis() / 5000.0));
  t = (0.06 * sineValue + 0.4) / 1.8;

  for (int i = 0; i < balls.size(); i++) {
    Ball b = balls.get(i);
    b.update();
    b.bound();
    b.display();
  }
  for (int i = 0; i < lines.size(); i++) {
    Line l = lines.get(i);
    l.update();
    l.bound();
    l.display();
  }

  pushMatrix();
  translate(width / 2, height / 2);
  displayUI();
  popMatrix();

  spikeManager.displaySpikes();

  if (ballCount >= 30) {
    resetSketch();
  }
}

//AI 생성, ballCount 30 도달 시 리셋되도록
void resetSketch() {
  balls.clear();
  lines.clear();
  ballCount = 0;
  lineCount = 0;
  spikeManager = new SpikeManager();
}

//dancing trees by Sophia Wood 코드 참고
void drawTree() {
  v2 = 4 * sin(t / n);
  v3 = 9;
  strokeWeight(2);
  fractal(width / 6, -1 + -1 * sin(t));
}

void fractal(float len, float refl) {
  float tmp = len * refl;
  strokeWeight(0.15);
  stroke(255, 255, 255, 80);
  line(0, 0, 0, min(-10, tmp));
  translate(0, tmp);
  if (len > v3) {
    pushMatrix();
    rotate(angle - angle * v2);
    fractal(len * 0.6, refl);
    noStroke();
    fill(255);
    ellipse(0, 0, 2, 2);
    popMatrix();

    pushMatrix();
    rotate(-angle + angle * v2);
    fractal(len * 0.6, refl);
    noStroke();
    fill(255);
    ellipse(0, 0, 2, 2);
    popMatrix();
  }
}

//클릭 시 절반 확률로 원형 또는 직선이 상단 중앙 또는 하단 중앙에서 생성됨
void mousePressed() {
  if (random(1) > 0.5) {
    float speed = random(5, 10);
    float rad = 3;
    if (random(1) > 0.5) {
      Ball newBall = new Ball(width / 2, 0, speed, rad);
      balls.add(newBall);
      ballCount++;
    } else {
      Ball newBall = new Ball(width / 2, height - rad, speed, rad);
      balls.add(newBall);
      ballCount++;
    }
  } else {
    float lineLength = 16;
    float lineSpeed = random(5, 10);
    if (random(1) > 0.5) {
      Line newLine = new Line(width / 2, 0, lineLength, lineSpeed);
      lines.add(newLine);
      lineCount++;
    } else {
      Line newLine = new Line(width / 2, height - lineLength, lineLength, lineSpeed);
      lines.add(newLine);
      lineCount++;
    }
  }
}

//화면 좌측 상단에 array에 있는 요소를 띄움
void displayUI() {
  pushMatrix();
  translate(- width / 2 + 50, - height / 2 + 50);
  int uiX = 0;
  int uiY = 0;
  int uiSpacing = 40;

  fill(255);
  textSize(16);
  noStroke();
  textAlign(LEFT);
  ellipse(uiX, uiY, 6, 6);

  text(ballCount, uiX + 30, uiY + 5);

  stroke(255);
  strokeWeight(2);
  line(uiX - 5, uiY + uiSpacing, uiX + 5, uiY + uiSpacing);
  noStroke();
  fill(255);
  text(lineCount, uiX + 30, uiY + uiSpacing + 5);
  popMatrix();
}

//AI생성, 중심으로부터 뻗어나가는 형상을 만들기 위해 도움을 받음
void drawSpikes(float scaleValue) {
  float spikeCount = int(random(4, 6));
  float maxSpikeLength = 60;
  //지름의 범위
  float minRadius = 10;
  float maxRadius = 600;

  //최대 지름에 도달할 때까지 90씩 지름 늘려서 추가함
  for (float radius = minRadius; radius <= maxRadius; radius += 90) {
    float spikeLength = random(10, maxSpikeLength);
    for (int i = 0; i < spikeCount; i++) {
      pushMatrix();

      //가시의 회전각 설정
      float angle = 180;
      //가시 그릴 위치
      float x = cos(angle) * radius;
      float y = sin(angle) * radius;

      translate(x, y);
      stroke(255, 255, 255, 20);
      strokeWeight(2);
      line(0, 0, 0, -spikeLength);
      popMatrix();
    }
  }
}


void drawPattern() {
  pushMatrix();
  translate(width / 2, height / 2);
  angle = radians(23) + radians(180) * sin(t / 50);

  background(0, 0, 0, 10);
  //AI생성, 시간에 따라 중심 원형 패턴의 scale값을 변화시킴
  float scaleValue = map(sin(t * 0.5), -1, 1, 0.3, 0.6);

  for (int i = 0; i < n; i++) {
    pushMatrix();
    scale(scaleValue);
    rotate(radians(360 / n * i));

    float radius = sin(PI * (millis() / 5000.0));
    translate(0, 200);
    rotate(t);

    drawTree();

    pushMatrix();
    drawSpikes(scaleValue);
    popMatrix();

    popMatrix();
  }
  popMatrix();
}

//마우스 인터랙션에 의해 생성된 도형이 충돌 했을 때 생성되는 가시
void addSpikeOnCollision() {
  spikeManager.generateSpikes();
}
