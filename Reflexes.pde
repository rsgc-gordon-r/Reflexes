// global variables – can be used anywhere below
Circle c1;          // one of the two circles to be drawn on screen
Circle c2;          // the second of the two circles to be drawn on screen

int score;          // current score earned
int highScore;      // highest score earned in this session
int timeLeft;       // time left in the game
int currentCircle;  // what circle is "active"
int scoreChange;    // score change in current frame of animation

// this runs once
void setup() {

  // create canvas, 9:16 aspect ratio (9*50, 16*50), iPhone 5S size
  size(450, 800);

  // set time left in the game
  timeLeft = 10;

  // set frame rate
  frameRate(60);

  // show a cursor that is a crosshairs
  cursor(CROSS);

  // create the circles
  c1 = new Circle(true);
  c2 = new Circle(false);
  currentCircle = 1;

  // use hue-satuation-brightness color model
  colorMode(HSB, 360, 100, 100);

  // no border
  noStroke();
}

// this runs repeatedly
void draw() {

  // erase the background to create animation
  background(0, 0, 100);

  // update the circles
  scoreChange = c1.update(); 
  if (scoreChange > 0) {
    score = score + scoreChange;
    currentCircle = 2;
    c2.reset();
  }
  scoreChange = 0;
  scoreChange = c2.update(); 
  if (scoreChange > 0) {
    score = score + scoreChange;
    currentCircle = 1;
    c1.reset();
  }

  // update on screen displays
  gameStateUpdate();

  // check whether game over
  isGameOver();
}

// responds when mouse is pressed
void mousePressed() {

  // check for a hit
  if (currentCircle == 1) {
    c1.checkHit(mouseX, mouseY);
  } else {
    c2.checkHit(mouseX, mouseY);
  }
  
}

// responds when a key is pressed
void keyPressed() {

  // Reset game if game is over and the space bar is pressed
  if (key == ' ' && timeLeft == 0) {
    timeLeft = 10;
    score = 0;
    if (currentCircle == 1) {
      c1.reset();
    } else {
      c2.reset();
    }
    loop();
  }
}

// gameStateUpdate
//
// PURPOSE: Keep track of points, time left, and draw updates for this information on screen.
void gameStateUpdate() {

  // reduce the time left every sixty frames
  if (frameCount % 60 == 0) {
    timeLeft = timeLeft - 1;
  }

  // change color of text
  fill(0, 0, 50);

  // display time left in game at left side of screen
  textAlign(LEFT);
  text("Time remaining: " + timeLeft, 50, 50);

  // display current score at right side of screen
  textAlign(RIGHT);
  text("Score: " + score, width - 50, 50);
}

// isGameOver
//
// PURPOSE: Checks to see whether the game is over.
void isGameOver() {

  // end game if time runs out
  if (timeLeft == 0) {
    
    // show game over text
    fill(0, 0, 50);
    textAlign(CENTER);
    textSize(48);
    text("GAME OVER", width / 2, height / 2);
    
    // check for new high score
    textSize(12);
    if (score > highScore) {
      highScore = score;
      text("New high score! You earned " + highScore + " points.", width / 2, height / 2 + 25);
    } else {
      text("Highest score so far: " + highScore, width / 2, height / 2 + 25);
    }
    
    // New game prompt
    text("Press space bar to play again", width / 2, height / 2 + 50);
    noLoop();
    
  }
  
}