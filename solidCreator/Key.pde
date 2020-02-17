public class Key implements Drawable {
 private Point position;
 private String character;
 private float width;
 
 private final color keyColor = color(255, 255, 255);
 private final color textColor = color(0, 0, 0);
 private final float cornerRadius = 7;
 
 public Key(Point position, String character, float width) {
   this.position = position;
   this.character = character;
   this.width = width;
 }
 
  public Key(String character, float width) {
   this.position = new Point();
   this.character = character;
   this.width = width;
 }
 
 public Point getPosition() {
   return position;
 }
 
 public String getCharacter() {
   return character; 
 }
 
 public float getWidth() {
  return width; 
 }
 
 public void setPosition(Point position) {
   this.position = position;
 }
 
 public void setCharacter(String character) {
   this.character = character; 
 }
 
 public void setWidth(float width) {
   this.width = width; 
 }
 
 public void draw() {
   noFill();
   stroke(keyColor);
   fill(keyColor);
   rect(position.x, position.y, width, width, cornerRadius);
   textSize(20);
   fill(textColor);
   textFont(defaultFont);
   text(character, position.x + width / 2 - width*0.1, position.y + width / 2);
 }
}
