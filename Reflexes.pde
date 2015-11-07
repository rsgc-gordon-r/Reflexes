// global variables – can be used anywhere below
Circle[] target;      // array of targets for game play
int targetCount = 3;  // how many targets to create
int current;          // what target is "active"

int score;          // current score earned
int highScore;      // highest score earned in this session
int timeLeft;       // time left in the game
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
  target = new Circle[targetCount];  // create placeholders for Circle objects in the array 
  int i = 0;
  while (i < targetCount) {
    target[i] = new Circle(false);   // actually create an instance of the Circle class and place in array
    i++;
  }
  current = 1;
  target[current].reset(true);  // make first target active

  // use hue-satuation-brightness color model
  colorMode(HSB, 360, 100, 100);

  // no border
  noStroke();
}

// this runs repeatedly
void draw() {

  // erase the background to create animation
  background(0, 0, 100);

  // update all the circles
  int scoreChange;
  int i = 0;
  while (i < targetCount) {                    // iterate over all the circles
    scoreChange = 0;
    scoreChange = target[i].update();          // update animation of this circle 
    if (scoreChange > 0) {
      score += scoreChange;
      // change the currently active target
      current++;
      if (current > targetCount - 1) {         // go back to first target if we go above total targets being used (have to subtract 1 as arrays are zero based)
        current = 0;
      }
      // reset current target for active play
      target[current].reset(true);
    }
    i++;
  }

  // update on screen displays
  gameStateUpdate();

  // check whether game over
  isGameOver();
}

// responds when mouse is pressed
void mousePressed() {

  // check for a hit
  target[current].checkHit(mouseX, mouseY);
}

// responds when a key is pressed
void keyPressed() {

  // Reset game if game is over and the space bar is pressed
  if (key == ' ' && timeLeft == 0) {
    
    // reset gameplay variables
    timeLeft = 10;
    score = 0;
    
    // reset targets
    int i = 0;
    while (i < targetCount) {
      if (i == current) {
        target[i].reset(true);  // currently active target is reset and made active
      } else {
        target[i].reset(false); // all other targets reset but made inactive
      }
      i++;
    }
    
    // start animation again, new game!
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