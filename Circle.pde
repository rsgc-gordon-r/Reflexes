class Circle {

  // Global variables - can be used anywhere in this class 
  float x;  // horizontal position of circle centre
  float y;  // vertical position of circle centre 
  float r;  // radius of circle
  int currentPoints;  // current points available to earn if this circle is clicked
  float distance;      // distance between centre of circle and mouse click

  // constructor, is run whenever an object is created based on this class
  Circle() {

    // Run the reset method (get this circle ready to use)
    this.reset();
  }

  // reset
  //
  // PURPOSE: When a circle is clicked, it needs to reset.
  void reset() {

    // pick location for this circle
    x = width/2;    // using built-in variable from Processing, it is screen width (450)
    y = height/2;   // using built-in variable from Processing, it is screen height (800)

    // initial radius is 0 pixels
    r = 0;

    // circle starts in random position on screen
    x = random(0, width);
    y = random(0, height);

    // set "initial distance" between mouse click and centre of circle
    distance = height + 1;

    // set current value of this circle
    currentPoints = 10;
  }

  // update
  //
  // PURPOSE: Do everything needed to draw this circle on screen.
  //          Will be called from the draw() function in main program.
  int update() {

    // draw the circle
    //      x  y   w    h   
    fill(0);
    ellipse(x, y, r*2, r*2); 

    // grow the radius for next time
    r = r + 2;

    // reduce points available for this circle
    if (frameCount % 15 == 0) { 
      currentPoints = currentPoints - 1;
    }

    // reduce the time left every sixty frames
    if (frameCount % 60 == 0) {
      timeLeft = timeLeft - 1;
    }

    // update points available to be earned
    infoUpdate();

    // check for a hit
    if (distance < r) {
      
      // hit
      int pointsEarned = currentPoints;
      this.reset();
      return pointsEarned;
    }
    
    // if circle gets beyond 150 pixels in size, start a new one
    if (r > 150) {
      
      // reset the circle
      this.reset();

    }

    // default, return 0 since the cirlce has not been clicked
    return 0;
  }

  // checkHit
  void checkHit(float mX, float mY) {

    // check for a hit
    float leg1 = pow(x - mX, 2);  // horizontal distance between centre of circle and mouse position
    float leg2 = pow(y - mY, 2);  // vertical distance between centre of circle and mouse position
    distance = sqrt(leg1 + leg2);     // distance between centre of circle and mouse click
    
  }
  
  // infoUpdate
  // 
  // PURPOSE: Update the points available for this circle, if it is active
  void infoUpdate() {
    // display the value of the circle that is currently on the screen at bottom of screen
    fill(127);
    textAlign(CENTER);
    text("Points available: " + currentPoints, width/2, height - 50);
  }
  
}