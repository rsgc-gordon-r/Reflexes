class Circle {

  // Global variables - can be used anywhere in this class 
  float x;            // horizontal position of circle centre
  float y;            // vertical position of circle centre 
  float r;            // radius of circle
  float distance;     // distance between centre of circle and mouse click
  boolean hit;        // tracks whether this circle has been hit or not
  float brightness;   // saturation for this circle
  boolean active;     // whether this circle should currently be animated
  int currentPoints;  // current points available to earn if this circle is clicked

  // constructor, is run whenever an object is created based on this class
  Circle(boolean active_) {

    // Set whether this circle should be active or not
    active = active_;
    if (active == true) {
      // When active, run the reset method to get this circle ready to use
      reset(true);
    }
  }

  // reset
  //
  // PURPOSE: Get the circle ready for animation and being "in play"
  void reset(boolean active_) {

    // initial radius is 0 pixels
    r = 0;

    // circle starts in random position on screen
    x = random(0, width);
    y = random(0, height);

    // set "initial distance" between mouse click and centre of circle
    // must be a value greater than largest possible distance between a circle's centre
    // and the mouse position (hence height of screen + 1 pixel)
    distance = height + 1;

    // circle has not been hit
    hit = false;

    // current brightness (black)
    brightness = 0;

    // set whether circle is active
    active = active_;
    
    // current points available from this circle
    currentPoints = 10;
  }

  // update
  //
  // PURPOSE: Do everything needed to draw this circle on screen.
  //          Will be called from the draw() function in main program.
  //
  //          If this circle was hit, returns the points the player has earned.
  //
  int update() {

    // Decide whether circle should be animated or not
    if (active == true) {

      // draw the circle
      fill(0, 0, brightness);
      //      x  y   w    h   
      ellipse(x, y, r*2, r*2); 

      // fades away if hit, otherwise grows in size
      if (hit == true) {

        // fade away
        brightness += 4;

        // Make inactive after reaching 100% brightneess
        if (brightness == 100) {
          active = false;
        }
        
      } else {

        // grow circle
        grow();

        // check for a hit
        if (distance < r) {

          // hit
          hit = true;
          return currentPoints;
          
        }
      }
    } 

    // circle was not "hit", so return 0 for points earned
    return 0;
    
  }

  // checkHit
  //
  // PURPOSE: Perform calculations to allow update() method to determine whether circle was hit
  void checkHit(float mX, float mY) {

    // check for a hit
    float leg1 = pow(x - mX, 2);  // horizontal distance between centre of circle and mouse position
    float leg2 = pow(y - mY, 2);  // vertical distance between centre of circle and mouse position
    distance = sqrt(leg1 + leg2);     // distance between centre of circle and mouse click
    
  }

  // grow
  //
  // PURPOSE: Make the circle grow
  void grow() {

    // grow the radius for next time
    r = r + 2;

    // reduce points available for this circle
    if (frameCount % 15 == 0) { 
      currentPoints = currentPoints - 1;
    }
    
    // update status
    gameStateUpdate();

    // if circle gets beyond 150 pixels in size, start a new one
    if (r > 150) {
      // reset the circle
      reset(true);
    }
  }

  // gameStateUpdate
  //
  // PURPOSE: Keep track of points available for current circle.
  void gameStateUpdate() {

    // display the value of the circle that is currently on the screen at bottom of screen
    fill(0, 0, 50);
    textAlign(CENTER);
    text("Points available: " + currentPoints, width/2, height - 50);
  }
  
}