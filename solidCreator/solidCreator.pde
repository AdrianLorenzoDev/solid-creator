import gifAnimation.*;

// Game title
String title = "Solid of Revolution Creator";
PFont defaultFont;
PImage mouseIcon;

// Gif recording only
// GifMaker animation;
// int i = 0; 

// Input status registers
boolean mousePressed = false;
boolean isEnterPressed = false;
boolean isBackspacePressed = false;
boolean isWPressed = false;
boolean isSPressed = false;
boolean isAPressed = false;
boolean isDPressed = false;
ScrollEvent scrollEvent = new ScrollEvent();

CreatorController controller;

public void settings(){
  size(1100, 1000, P3D);
  controller = new CreatorController();
}

public void setup() {
  surface.setTitle(title);
  defaultFont = createFont("Arial", 15);
  mouseIcon = loadImage("mouse-icon.png");
  
  /**
  Gif recording only
  animation = new GifMaker(this, "../images/demo.gif");
  animation.setQuality(10);
  animation.setRepeat(0);
  */
}

public void draw() {
  controller.run();
  
  /**
  Gif recording only
  if (i % 3 == 0) {
    animation.addFrame();
  }
  i++;
  */
}

public Point getPositionFromMouse() {
  return new Point(mouseX, mouseY); 
}

public float getRelativeToCanvasWidth(float rel) {
    return width * rel; 
}

public float getRelativeToCanvasHeight(float rel) {
    return height * rel; 
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    isWPressed = true;    
  }
  
  if (key == 'a' || key == 'A') {
    isAPressed = true;    
  }
  
  if (key == 's' || key == 'S') {
    isSPressed = true;    
  }
  
  if (key == 'd' || key == 'D') {
    isDPressed = true;    
  }
  
  if (key == ENTER) {
    isEnterPressed = true;
  }
  
  if (key == BACKSPACE) {
    isBackspacePressed = true;
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    isWPressed = false;    
  }
  
  if (key == 'a' || key == 'A') {
    isAPressed = false;    
  }
  
  if (key == 's' || key == 'S') {
    isSPressed = false;    
  }
  
  if (key == 'd' || key == 'D') {
    isDPressed = false;    
  }
  
  if (key == ENTER || key == RETURN) {
    isEnterPressed = false;
  }
  
  if (key == BACKSPACE) {
    isBackspacePressed = false;
  }
}

void mousePressed() {
  mousePressed = true;
}

void mouseReleased() {
  mousePressed = false;
}

void mouseWheel(MouseEvent event){
  if (event.getCount() > 0) {
     scrollEvent.setHasScrolledUp(true);
  } else {
     scrollEvent.setHasScrolledDown(true); 
  }
}
