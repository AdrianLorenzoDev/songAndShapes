public class SongShape {
  PVector position;
  float extent;
  PVector diffBreak;
  PVector diffSpeed;
  PVector colr;
  
  public SongShape(PVector position, float extent, PVector diffSpeed, PVector diffBreak) {
    this.position = position;
    this.extent = extent;
    this.diffBreak = diffBreak;
    this.diffSpeed = diffSpeed;
    this.colr = new PVector(
      random(0, 240),
      random(0, 240),
      random(0, 240)
    );
  }
  
  public void move() {
    position.add(diffSpeed);
    
    diffSpeed.x = diffSpeed.x >= 0 ? 
      max(0, diffSpeed.x - diffBreak.x) :
      min(0, diffSpeed.x + diffBreak.x);
    
    diffSpeed.y = diffSpeed.y >= 0 ? 
      max(0, diffSpeed.y - diffBreak.y) :
      min(0, diffSpeed.y + diffBreak.y);
    
    if (position.x + extent/2 >= width || position.x - extent/2 <= 0) {
      diffSpeed.x *= -1;
    }
    
    if (position.y + extent/2 >= height || position.y - extent/2 <= 0) {
      diffSpeed.y *= -1;
    }
  }
  
  public void draw(ShapeType shape) {
    fill(colr.x, colr.y, colr.z);
    switch (shape) {
      case circle:
        circle(position.x, position.y, extent);
        break;
      case rectangle:
        rect(position.x - extent / 2, position.y - extent / 2, extent, extent);
    }

    move();
  }
}
