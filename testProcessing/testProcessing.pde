/**
 * 1st : move x-axis with potard
 * 2nd : valid with button
 * 3rd : move y-axis with potard
 * 4th : valid with button
 * 5th : spawn square to x, y coords
 */
 
int xPos;
int yPos;

int moveSpeed = 5;

boolean canDraw;

void setup() {
  size(640, 360);
  background(0);
  
  xPos = width/2;
  yPos = height/2;  
  
  canDraw = false;
}

void draw() {
  
  if (canDraw) {
    background(0);
    rect(xPos-2, yPos-2, 5, 5);
    
    canDraw = false;
  }
}

void keyPressed() {
  if (key == 'Z' || key == 'z') {
    yPos -= moveSpeed;
  } else if (key == 'S' || key == 's') {
    yPos += moveSpeed;
  } else if (key == 'Q' || key == 'q') {
    xPos -= moveSpeed;
  } else if (key == 'D' || key == 'd') {
    xPos += moveSpeed;
  }
  canDraw = true;
   
}
