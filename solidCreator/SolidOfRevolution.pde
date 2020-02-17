public class RevolutionSolid implements Drawable {
  private PShape solid;
  private Point rotation;
  private final float zValue = 0;
  private final color strokeColor = color(174, 213, 129);
  private final color fillColor = color(174, 213, 129, 200);

  public void createFromPoints(ArrayList<Point> points, Point origin) {
    solid = createShape();
    rotation = new Point();
    solid.beginShape(TRIANGLE_STRIP); 
    solid.fill(fillColor);
    solid.stroke(strokeColor);
    solid.strokeWeight(1);
    
    for (int i = 0; i < points.size()-1; i++) {
      Point currentPoint = points.get(i+1).getTranslatedPoint(origin);
      Point previusPoint = points.get(i).getTranslatedPoint(origin);

      for (float rad = 0; rad < 2*PI; rad += PI/64) {
        solid.vertex(
          previusPoint.getX() * cos(rad) - zValue * sin(rad), 
          previusPoint.getY(), 
          previusPoint.getX() * sin(rad) + zValue * cos(rad)
        );

        solid.vertex(
          currentPoint.getX() * cos(rad) - zValue * sin(rad), 
          currentPoint.getY(), 
          currentPoint.getX() * sin(rad) + zValue * cos(rad)
        );
      }
    }
    
    solid.endShape();
  }
  
  public void rotateXAxis(Float x) {
    rotation.setX(rotation.getX() + x);
  }
  
  public void rotateYAxis(Float y) {
    rotation.setY(rotation.getY() + y);
  }
  
  public void draw() {
    rotateY(rotation.y);
    rotateX(rotation.x);
    shape(solid);
  }
}
