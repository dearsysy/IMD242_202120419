
class Ball {
  float x, y;
  float vx, vy;
  float rad;

  Ball(float x, float y, float speed, float rad) {
    this.x = x;
    this.y = y;
    this.rad = rad;
    //AI생성, 랜덤한 방향으로 공이 튀어나가도록 함
    float deg = random(360);
    vx = speed * cos(radians(deg));
    vy = speed * sin(radians(deg));
  }

  void update() {
    x += vx;
    y += vy;
  }

  void bound() {
    if (x - rad < 0 || x + rad > width) {
      vx *= -1;
      if (x - rad < 0)
        x = rad;
      if (x + rad > width)
        x = width - rad;
    }
    if (y - rad < 0 || y + rad > height) {
      vy *= -1;
      if (y - rad < 0)
        y = rad;
      if (y + rad > height)
        y = height - rad;
    }
    //AI생성, 중심 패턴에서의 공 충돌을 해결하기 위함
    else if (dist(x, y, width / 2, height / 2) < 350) {
      vx *= -1;
      vy *= -1;

      //충돌 시 새로운 가시 생성
      addSpikeOnCollision();
    }
  }

  void display() {
    noStroke();
    fill(255, 90);
    circle(x, y, rad * 2);
  }
}

class Line {
  float x, y;
  float vx, vy;
  float length;

  Line(float x, float y, float length, float speed) {
    this.x = x;
    this.y = y;
    float deg = random(360);
    //AI생성, 랜덤한 방향으로 라인이 튀어나가도록 함
    vx = speed * cos(radians(deg));
    vy = speed * sin(radians(deg));
    this.length = length;
  }

  void update() {
    x += vx;
    y += vy;
  }

  void bound() {
    if (x < 0 || x > width) {
      vx *= -1;
      if (x < 0) x = 0;
      if (x > width) x = width;
    }
    if (y < 0 || y > height) {
      vy *= -1;
      if (y < 0) y = 0;
      if (y > height) y = height;
    }
    //AI생성, 중심 패턴에서의 공 충돌을 해결하기 위함
    else if (dist(x, y, width / 2, height / 2) < 350) {
      vx *= -1;
      vy *= -1;
    }
  }

  void display() {
    stroke(255);
    strokeWeight(1);
    line(x, y, x + length * cos(radians(45)), y + length * sin(radians(45)));
  }
}

//공이 중앙 패턴에 충돌했을 때 생기는 가시
class Spike {
  float x, y;
  float angle;
  float length;
  float radius;

  Spike(float radius, float angle, float length) {
    this.radius = radius;
    this.angle = angle;
    this.length = length / 2;

    //AI 생성, 클릭 인터랙션 원이 중앙에 충돌할 때 생성되는 가시의 위치
    if (random(1) > 0.5) {
      this.x = cos(angle) * radius / 2;
    } else {
      this.x = cos(angle) * radius / 3;
    }
    if (random(1) > 0.5) {
      this.y = sin(angle) * radius / 2;
    } else {
      this.y = sin(angle) * radius / 3;
    }
  }

  void display() {
    float scaleValue = map(sin(t * 0.5), -1, 1, 0.3, 0.6);

    pushMatrix();
    translate(width / 2, height / 2);
    scale(scaleValue * 2);
    stroke(255, 255, 255, 40);
    strokeWeight(1);
    line(x, y, x + cos(angle) * length, y + sin(angle) * length);
    popMatrix();
  }
}


//AI생성, 기존 가시 위치와 유사한 위치에 새 가시를 만들기 위함
class SpikeManager {
  ArrayList<Spike> spikes;
  int spikeCount;

  SpikeManager() {
    spikes = new ArrayList<Spike>();
    spikeCount = 0;
  }

  void generateSpikes() {
    float minRadius = 10;      
    float maxRadius = 600;    
    float radiusStep = 90;      
    int spikeCountPerRing = int(random(2, 4)); 

    for (float radius = minRadius; radius <= maxRadius; radius += radiusStep) {
      for (int i = 0; i < spikeCountPerRing; i++) {
        float angle = random(TWO_PI);         
        float spikeLength = random(10, 60);  

        Spike newSpike = new Spike(radius, angle, spikeLength);
        spikes.add(newSpike);
      }
    }
  }

  void displaySpikes() {
    for (Spike s : spikes) {
      s.display();
    }
  }
}
