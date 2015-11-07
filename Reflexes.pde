// global variables – can be used anywhere below
Circle c1;          // the circle to be drawn on screen
int score;          // current score earned
int timeLeft;       // time left in the game

// this runs once
void setup() {

  // create canvas, 9:16 aspect ratio (9*50, 16*50), iPhone 5S size
  size(450, 800);

  // set time left in the game
  timeLeft = 10;

  // set frame rate
  frameRate(60);

  // all circles have black fill
  fill(0);

  // show a cursor that is a crosshairs
  cursor(CROSS);

  // create the circle
  c1 = new Circle();
}

// this runs repeatedly
void draw() {

  // erase the background to create animation
  background(255);

  // update the current circle
  score = score + c1.update();

  // update on screen displays
  infoUpdate();

  // check whether game over
  isGameOver();
}

// responds when mouse is pressed
void mousePressed() {

  // check for a hit
  c1.checkHit(mouseX, mouseY);
}

// infoUpdate
//
// PURPOSE: To update the score and time left in the game
void infoUpdate() {

  // display time left in game at left side of screen
  stroke(127);
  textAlign(LEFT);
  text("Time remaining: " + timeLeft, 50, 50);

  // display current score at right side of screen
  stroke(127);
  textAlign(RIGHT);
  text("Score: " + score, width - 50, 50);
}

// isGameOver
//
// PURPOSE: Checks to see whether the game is over
void isGameOver() {

  // end game if time runs out
  if (timeLeft == 0) {
    stroke(127);
    textAlign(CENTER);
    textSize(48);
    text("GAME OVER", width / 2, height / 2);
    noLoop();
  }
}