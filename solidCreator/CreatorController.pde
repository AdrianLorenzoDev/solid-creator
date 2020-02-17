public class CreatorController {
  private RevolutionSolid revolutionSolid = new RevolutionSolid();
  private ArrayList<Point> points = new ArrayList();
  private float zPosition = 0;
  private boolean isShapeBeingCreated = true;
  
  private final float rotationDelta = PI/32;
  private final float zTranslationDelta = 3;
  private final Point origin = new Point(getRelativeToCanvasWidth(0.5), getRelativeToCanvasHeight(0.5));
  
  private final float keyXPosition = getRelativeToCanvasWidth(0.05);
  private final float keySize = getRelativeToCanvasWidth(0.04);
  private final float textXPosition = keyXPosition + keySize + getRelativeToCanvasWidth(0.01);
  
  private final float fourthMenuItemY = getRelativeToCanvasHeight(0.74);
  private final float thirdMenuItemY = getRelativeToCanvasHeight(0.78);
  private final float secondMenuItemY = getRelativeToCanvasHeight(0.84);
  private final float firstMenuItemY = getRelativeToCanvasHeight(0.90);
  
  private final Key backspace = new Key("\u232b", keySize);
  private final Key enter = new Key(new Point(keyXPosition, secondMenuItemY), "\u2386", keySize);
  private final Key[] wasdKeys = new Key[] {
    new Key("W", keySize),
    new Key("S", keySize),
    new Key("A", keySize),
    new Key("D", keySize)
  };
  
  private final color backgroundColor = color(0, 0, 0);
  private final color pointsColor = color(174, 213, 129);
  private final color axisColor = color(255, 255, 255);
  
  public void drawPoints() {
    stroke(axisColor);
    line(getRelativeToCanvasWidth(0.5), 0, getRelativeToCanvasWidth(0.5), pixelHeight);

    fill(pointsColor);
    stroke(pointsColor);
    
    if (points.size() != 0) {
      Point lastPoint = points.get(0);
      for(int i = 0; i < points.size(); i++) {
        Point newPoint = points.get(i);
        line(lastPoint.getX(), lastPoint.getY(), newPoint.getX(), newPoint.getY()); 
        circle(newPoint.getX(), newPoint.getY(), 2);
        lastPoint = newPoint;
      }
    }
  }
  
  public void rotateShape(){
    if (isWPressed) {
      revolutionSolid.rotateXAxis(rotationDelta); 
    }
    
    if (isSPressed) {
      revolutionSolid.rotateXAxis(-rotationDelta);  
    }
    
    if (isAPressed) {
      revolutionSolid.rotateYAxis(-rotationDelta); 
    }
    
    if (isDPressed) {
      revolutionSolid.rotateYAxis(rotationDelta); 
    }
  }
  
  public void translateZ(){
    if (scrollEvent.hasScrolledUp()){
      zPosition += zTranslationDelta; 
    } else if (scrollEvent.hasScrolledDown()){
      zPosition -= zTranslationDelta; 
    }
  }
  
  public void showCreationControls() {
    hint(DISABLE_DEPTH_TEST);
    image(mouseIcon, keyXPosition, thirdMenuItemY);
    
    fill(255);
    textFont(defaultFont);
    text("LEFT CLICK - Add vertex", keyXPosition + mouseIcon.width + getRelativeToCanvasWidth(0.01), thirdMenuItemY + mouseIcon.height/1.2);
    
    backspace.setPosition(new Point(keyXPosition, firstMenuItemY));
    backspace.draw();
    
    fill(255);
    textFont(defaultFont);
    text(" - Remove vertex", textXPosition, firstMenuItemY + keySize/2);
    
    enter.draw();
    
    fill(255);
    textFont(defaultFont);
    text(" - Create solid", textXPosition, secondMenuItemY + keySize/2);
    hint(ENABLE_DEPTH_TEST);
  }
  
  public void showPreviewControls() {
    hint(DISABLE_DEPTH_TEST);
    image(mouseIcon, keyXPosition, fourthMenuItemY);
    
    fill(255);
    textFont(defaultFont);
    text("SCROLL - Move solid across Z axis", keyXPosition + mouseIcon.width + getRelativeToCanvasWidth(0.01), fourthMenuItemY + mouseIcon.height/1.2);
    
    image(mouseIcon, keyXPosition, thirdMenuItemY);
    
    fill(255);
    textFont(defaultFont);
    text("MOVE - Move solid across X/Y axes", keyXPosition + mouseIcon.width + getRelativeToCanvasWidth(0.01), thirdMenuItemY + mouseIcon.height/1.2);
    
    backspace.setPosition(new Point(keyXPosition, secondMenuItemY));
    backspace.draw();
    
    fill(255);
    textFont(defaultFont);
    text(" - Create new solid", textXPosition, secondMenuItemY + keySize/2);
  
    for(int i = 0; i < wasdKeys.length; i++) {
      wasdKeys[i].setPosition(new Point(keyXPosition + i * (keySize + getRelativeToCanvasWidth(0.01)), firstMenuItemY));
      wasdKeys[i].draw();
    }
    
    fill(255);
    text(" - Rotate solid", keyXPosition + wasdKeys.length * (keySize + getRelativeToCanvasWidth(0.01)), firstMenuItemY + keySize/2);
     hint(ENABLE_DEPTH_TEST);
  }
  
  public void setVisualizer() {
    isShapeBeingCreated = false;
    revolutionSolid.createFromPoints(points, origin);
    points.clear(); 
  }
  
  public void removeLastPoint() {
    points.remove(points.size() - 1);
  }
  
  public void drawSketchLine() {
    Point lastPoint = points.get(points.size()-1); 
    stroke(pointsColor);
    line(lastPoint.getX(), lastPoint.getY(), mouseX, mouseY); 
  }
  
  public void setNewCanvas() {
    zPosition = 0;  
    isShapeBeingCreated = true; 
  }
  
  public void showSolid() {
    pushMatrix();
    rotateShape();
    translateZ();
    translate(mouseX, mouseY, zPosition);
    revolutionSolid.draw();
    popMatrix();
    showPreviewControls(); 
  }
  
  public void run() {
    background(backgroundColor);

    if (isShapeBeingCreated) {
      if (isEnterPressed) {
        setVisualizer();
      }
      
      if (points.size() > 0) {
        if (isBackspacePressed) {
          removeLastPoint();
        }
        
        drawSketchLine();
      }

      if (mousePressed) {
        points.add(getPositionFromMouse());
      }
      
      drawPoints();
      showCreationControls();
      
    } else {
      if (isBackspacePressed) {
        setNewCanvas();
      }
      
      showSolid();
    }
  }
}
