public class Point {
  private float x;
  private float y;
  private float z;
  
  public Point() {
    this.x = 0;
    this.y = 0;
    this.z = 0;
  }
  
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
    this.z = 0;
  }
  
  public Point(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public float getX(){
    return x;
  }

  public float getY() {
    return y;
  }
  
  public float getZ() {
    return z;
  }

  public void setX(float x){
    this.x = x;
  }

  public void setY(float y) {
    this.y = y;
  }
  
  public void setZ(float z) {
    this.z = z;
  }
  
  public Point getTranslatedPoint(Point origin){
    return new Point(getX() - origin.getX(), getY() - origin.getY(), getZ() - origin.getZ());
  }
}
