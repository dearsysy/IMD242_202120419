int numRects; 
float[][] rectPositions; 
int[] angles; // 직사각형 각도
color rectColor, overlayColor; 
color mouseColor; 
float rectWidth = 150; 
float rectHeight = 40; 
int maxRects = 15; 

void setup() {
  size(800, 800);
  numRects = int(random(10, maxRects)); // 직사각형 개수 랜덤 설정
  rectPositions = new float[numRects][2]; // 위치 배열 초기화
  angles = new int[numRects]; // 각도 배열 초기화

  // 직사각형의 초기 위치와 각도 설정
  for (int i = 0; i < numRects; i++) {
    rectPositions[i][0] = random(0, width / 2); // 왼쪽 절반에 위치
    rectPositions[i][1] = random(0, height); // Y 위치
    angles[i] = int(random(0, 6)) * 60; // 랜덤 60도 단위 각도
  }

  // 색상
  rectColor = color(random(255), random(150, 255), random(150, 255), 150);
  overlayColor = color(random(150, 255), random(255), random(150, 255), 150);
  mouseColor = color(random(100, 255), random(100, 255), random(100, 255), 150);
}

void draw() {
  background(255);
  float transparency = map(mouseY, 0, height, 50, 255);


  drawPattern(transparency); // 패턴
  drawOverlayPattern(transparency); // 중첩패턴

  // 마우스 위치에 커서 그리기
  drawCustomCursor(mouseX, mouseY);
}

void drawPattern(float transparency) {
  for (int i = 0; i < numRects; i++) {
    // 좌측 패턴
    color fillColor = color(red(rectColor), green(rectColor), blue(rectColor), transparency); // 현재 투명도를 가진 색상
    drawGradientRect(rectPositions[i][0], rectPositions[i][1], angles[i], fillColor);

    // 우측 패턴 (좌우 반전)
    drawGradientRect(width - rectPositions[i][0], rectPositions[i][1], -angles[i], fillColor);
  }
}

void drawOverlayPattern(float transparency) {
  for (int i = 0; i < numRects; i++) {
    float overlayY = height - rectPositions[i][1]; // Y 좌표 반전
    // 중첩 패턴 그리기
    color fillColor = color(red(overlayColor), green(overlayColor), blue(overlayColor), transparency); // 현재 투명도를 가진 색상
    drawGradientRect(rectPositions[i][0], overlayY, angles[i], fillColor);

    // 대칭 패턴 그리기
    drawGradientRect(width - rectPositions[i][0], overlayY, -angles[i], fillColor);
  }
}

void drawGradientRect(float x, float y, float angle, color fillColor) {
  pushMatrix(); // 현재 변환 상태 저장
  translate(x, y); // 위치 이동
  rotate(radians(angle)); // 각도 회전

  // 그라데이션 적용
  for (int j = 0; j <= 50; j++) {
    float inter = map(j, 0, 50, 0, 1); // 그라데이션 비율 계산
    color c = lerpColor(fillColor, color(255, 255, 255, 150), inter); // 색상 보간
    stroke(c); // 테두리 색상 설정
    line(-rectWidth / 2, j - rectHeight / 2, rectWidth / 2, j - rectHeight / 2); // 직사각형 그리기
  }

  popMatrix(); // 이전 변환 상태 복원
}

void drawCustomCursor(float x, float y) {
  strokeWeight(2); // 선 두께
  stroke(mouseColor); // 마우스 색상 설정

  // 수평 선
  line(x - 25, y, x + 25, y); // 중심을 기준으로 가로
  // 수직 선
  line(x, y - 25, x, y + 25); // 중심을 기준으로 세로
  // 대각선 선
  line(x - 25, y - 25, x + 25, y + 25); // 대각선 추가
}

void mousePressed() {
  // 클릭 시 색상 변경
  rectColor = color(random(255), random(150, 255), random(150, 255), 150); // 밝은 색으로 변경
  overlayColor = color(random(150, 255), random(255), random(150, 255), 150); // 화사한 색으로 변경

  // 직사각형 개수 랜덤 변경
  numRects = int(random(10, maxRects)); // 새로운 개수 설정
  rectPositions = new float[numRects][2]; // 위치 배열 초기화
  angles = new int[numRects]; // 각도 배열 초기화

  // 직사각형 위치와 각도 변경
  for (int i = 0; i < numRects; i++) {
    rectPositions[i][0] = random(0, width / 2); // 랜덤 위치
    rectPositions[i][1] = random(0, height); // 랜덤 Y 위치
    angles[i] = int(random(0, 6)) * 60; // 랜덤 각도 변경
  }

  // 마우스 색상 랜덤으로 변경
  mouseColor = color(random(100, 255), random(100, 255), random(100, 255), 150); // 마우스 색상도 화사하게 변경
}


//chat gpt의 도움을 받았습니다
