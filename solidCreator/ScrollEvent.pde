public class ScrollEvent {
  boolean hasScrolledUp = false;
  boolean hasScrolledDown = false;
  
  public void setHasScrolledUp(Boolean hasScrolledUp) {
    this.hasScrolledUp = hasScrolledUp; 
  }
  
  public void setHasScrolledDown(Boolean hasScrolledDown) {
    this.hasScrolledDown = hasScrolledDown; 
  }
  
  public boolean hasScrolledUp() {
    Boolean event = hasScrolledUp;
    hasScrolledUp = false;
    return event;
  }
  
  public boolean hasScrolledDown() {
    Boolean event = hasScrolledDown; 
    hasScrolledDown = false;
    return event;
  }
}
