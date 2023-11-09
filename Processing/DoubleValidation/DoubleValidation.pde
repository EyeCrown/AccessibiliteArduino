/**
 * --- Accessibility & Arduino ---
 *         Cnam-Enjmin P20        
 * 
 * File: DoubleValidation
 * Description: Set x coord then
 * y coord then draw a circle at 
 * x,y coords
 * 
 * Author: Théophile Carrasco
 */
 
 /**
 * Algorithm:
 * 1st : move x-axis with potard
 * 2nd : valid with button
 * 3rd : move y-axis with potard
 * 4th : valid with button
 * 5th : spawn square to x, y coords
 */
 
 /**
 * Imports
 *
 */
import processing.serial.*; 
 
 /**
 * Variables
 *
 */
 
int xCursorPos, yCursorPos;       // cursor coordonates

int xMin = 26, xMax = 1054;
int yMin = 26, yMax = 514;

boolean moveHorizontal;

Serial myPort;  // Create object from Serial class
String valCurrent, valPrevious;     // Data received from the serial port
int ecart = 20;

 /**
 * Methods
 *
 */

/** 
 * Initialization
 */
void setup() {
  size(1080, 540); 
  noStroke(); // disables rectangle outline
  background(#2d3e41); 
  textSize(35);  
  
  xCursorPos = width / 2;
  yCursorPos = height / 2;
  
  moveHorizontal = true;
  
  
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  
  valCurrent = "";
  valPrevious = valCurrent;
}

/** 
 * Draw each frame
 */
void draw() {
  background(#2d3e41); 
  
  if ( myPort.available() > 0) {  // If data is available,
    valCurrent = myPort.readStringUntil('\n');         // read it and store it in val
  }
  
  testValSerial();
  
  drawCursor();
}

void testValSerial() {
  int val = int(valCurrent); 
  int lastVal = int(valPrevious);
  
  if (val >=0 && (lastVal - val > ecart || val - lastVal > ecart)) {
    if (moveHorizontal) {
      if (val < lastVal) {
        moveCursorHorizontal(true);
      } else {
        moveCursorHorizontal(false);
      }
    } else {
      if (val < lastVal) {
        moveCursorVertical(true);
      } else {
        moveCursorVertical(false);
      }
    }
  }
}





/** 
 * Every time a key is pressed
 */
void keyPressed() {
  if (moveHorizontal) {
    if (key == 'Q' || key == 'q') {
      moveCursorHorizontal(true);
    } else if (key == 'D' || key == 'd') {
      moveCursorHorizontal(false);
    }
  } else { 
    if (key == 'Z' || key == 'z') {
      moveCursorVertical(true);
    } else if (key == 'S' || key == 's') {
      moveCursorVertical(false);
    }
  }
  if (key == ' ') {
    if (moveHorizontal) {
      moveHorizontal = false;
    } else {
      fill(#ff0000);
      circle(xCursorPos, yCursorPos, 50);
      fill(#ffffff);
      moveHorizontal = true;
    }
  }
  
}


/** 
 * drawCursor()
 * 
 * Draw the current selected letter by inverting color
 * of a key box
 */
void drawCursor() {
  rect(xCursorPos - 2, yCursorPos - 2, 5, 5); 
}

/** 
 * moveCursorHorizontal()
 * 
 * Try to move the cursor horizontally
 */
void moveCursorHorizontal(boolean toTheLeft) {  
  if (xCursorPos > xMin && toTheLeft) {
    setCursor(xCursorPos - 5, yCursorPos);
  } else if (xCursorPos < xMax && !toTheLeft) {
    setCursor(xCursorPos + 5, yCursorPos);
  }
}

/** 
 * moveCursorVertical()
 * 
 * Try to move the cursor vertically
 */
void moveCursorVertical(boolean toTheTop) {  
  if (yCursorPos > yMin && toTheTop) {
    setCursor(xCursorPos, yCursorPos - 5);
  } else if (yCursorPos < yMax && !toTheTop) {
    setCursor(xCursorPos, yCursorPos + 5);
  }
}

/** 
 * setCursor(int xNewPos, int yNewPos)
 * 
 * Setter of cursor coords
 */
void setCursor(int xNewPos, int yNewPos) {
  xCursorPos = xNewPos;
  yCursorPos = yNewPos;
}
