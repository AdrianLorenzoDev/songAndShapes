import arb.soundcipher.*;

SoundCipher sc = new SoundCipher(this);
SCScore score = new SCScore();
Song song = new Song();

PVector backgroundColor = new PVector(255, 255, 255);
ArrayList<SongShape> shapes = new ArrayList();
int maxNumCircles = 400;
int lastBigCirclePosition = 0;

ShapeType shape = ShapeType.circle;

void setup() {
  size(700, 700);
  score.tempo(95);
  score.instrument(SCScore.PIANO);
  score.addCallbackListener(this);
  song.playTrack();
}

synchronized void draw() {
  background(backgroundColor.x, backgroundColor.y, backgroundColor.z);
  for (SongShape circle: shapes) {
    circle.draw(shape);
  }
}

void handleCallbacks(int id) {
  switch (id) {
    case SongState.finished:
      score.stop();
      song.playTrack();
      break;
    case SongState.bass:
      addBigCircle();
      break;
    case SongState.rhythm:
      addSmallCircle();
      break;
    case SongState.lead:
      addMiniCircles();
      break;
    case SongState.leadSustain:
      changeBackground(random(-1, 1) >= 0);
      break;
    case SongState.snare:
      changeShape();
      break;
  }
}

synchronized void addBigCircle() {
  float size = random(90, 180);
  shapes.add(
    new SongShape(
      new PVector(random(0, width - size / 2), random(0, height - size / 2)),
      size,
      new PVector(
        random(-1, 1) >= 0 ? random(2, 6) : random(-6, -2), 
        random(-1, 1) >= 0 ? random(2, 6) : random(-6, -2)),
      new PVector(random(0.05, 0.15), random(0.05, 0.15))
    )
  );
  removeExceededCircles();
  lastBigCirclePosition = shapes.size()-1;
}

synchronized void addSmallCircle() {
  for (int i = 0; i < 2; i++) {
    shapes.add(
      new SongShape(
        shapes.get(lastBigCirclePosition).position.copy(),
        random(40, 70),
        new PVector(
          random(-1, 1) >= 0 ? random(4, 7) : random(-7, -4), 
          random(-1, 1) >= 0 ? random(4, 7) : random(-7, -4)),
        new PVector(random(0.01, 0.1), random(0.01, 0.1))
      )
    );
  }
  removeExceededCircles();
  lastBigCirclePosition = shapes.size()-3;
}

synchronized void addMiniCircles() {
  float size = random(4, 8);
  PVector position = new PVector(random(0, width - size/2), random(0, height - size/2));
  for (int i = 0; i < 10; i++) {
    shapes.add(
      new SongShape(
        position.copy(),
        size,
        new PVector(
          random(-1, 1) >= 0 ? random(4, 7) : random(-7, -4),
          random(-1, 1) >= 0 ? random(4, 7) : random(-7, -4)),
        new PVector(random(0.01, 0.1), random(0.01, 0.1))
      )
    );
  }
}

synchronized void removeExceededCircles() {
  if (shapes.size() >= maxNumCircles) {
    for(int i = 0; i < (shapes.size() - (maxNumCircles - 1)); i++) {
      shapes.remove(i);
    }
  }
}

synchronized void changeShape() {
  shape = (shape != ShapeType.circle) ? ShapeType.circle : ShapeType.rectangle;
}

synchronized void changeBackground(boolean direction) {
  backgroundColor.x = max(0, min(255, backgroundColor.x + 2 * (direction ? 1 : -1)));
  backgroundColor.y += max(0, min(255, backgroundColor.y + 2 * (direction ? 1 : -1)));
  backgroundColor.z += max(0, min(255, backgroundColor.z + 2 * (direction ? 1 : -1)));
}

void stop() {
  score.stop();
}
