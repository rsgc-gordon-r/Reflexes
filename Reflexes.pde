// global variables – can be used anywhere below
float x;  // horizontal position of circle centre
float y;  // vertical position of circle centre 
float r;  // radius of circle 

// this runs once
void setup() {
  // create canvas, 9:16 aspect ratio (9*50, 16*50), iPhone 5S size
  size(450, 800);

  // pick location for this circle
  x = width/2;    // using built-in variable from Processing, it is screen width (450)
  y = height/2;   // using built-in variable from Processing, it is screen height (800)

  // initial radius is 0 pixels
  r = 0;

  // circle starts in random position on screen
  x = random(0, width);
  y = random(0, height);

  // all circles have black fill
  fill(0);
}

// this runs repeatedly
void draw() {

  // erase the background to create animation
  background(255);

  // draw the circle
  //      x  y   w    h   
  ellipse(x, y, r*2, r*2); 

  // grow the radius for next time
  r = r + 2;

  // if circle gets beyond 150 pixels in size, start a new one
  if (r > 150) {
    // initial radius is 0 pixels
    r = 0;

    // circle starts in random position on screen
    x = random(0, width);
    y = random(0, height);
  }
  
}