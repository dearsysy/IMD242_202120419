let gradiantText = ' .:-=+*#%@'; //문자열에서 하나씩 꺼내쓰기

let canvasSize = [640, 480];
let scale = 0.1;
let captureSize = [canvasSize[0] * scale, canvasSize[1] * scale];
let tileWidth = canvasSize[0] / captureSize[0];

let capture;

function setup() {
  createCanvas(canvasSize[0], canvasSize[1]);
  capture = createCapture(VIDEO, { flipped: true });
  capture.size(captureSize[0], captureSize[1]);
  capture.hide();
}

function draw() {
  background(0);
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  // text(gradiantText.charAt(3), 20, 20); //하나씩 꺼내쓰기--charAt 사용 //charAt안에는 (크기-1)이 들어가야 딱 맞다.
  capture.loadPixels(); //매 프레임마다 새로운 pixel정보를 받아오게 한다.
  for (let idx = 0; idx < capture.pixels.length / 4; idx++) {
    let r = capture.pixels[4 * idx + 0];
    let g = capture.pixels[4 * idx + 1];
    let b = capture.pixels[4 * idx + 2];
    let a = capture.pixels[4 * idx + 3];
    let bright = brightness([r, g, b]); //밝기로 환산
    let gradiantIdx = map(bright, 0, 255, 0, gradiantText.length - 1); //환산한 값을 문자열 중에 적절한 값을 구한다.
    gradiantIdx = floor(gradiantIdx); //정수화해주기
    let asciiText = gradiantText.charAt(gradiantIdx); //밝기에 맞는 글자 꺼내기
    let column = idx % captureSize[0]; //위치 구하기
    let row = floor(idx / captureSize[0]); //항상 가로 너비로 해야한다.
    let x = column * tileWidth + tileWidth * 0.5;
    let y = row * tileWidth + tileWidth * 0.5;
    text(asciiText, x, y);
  }
}
