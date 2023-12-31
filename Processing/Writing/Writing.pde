/**
 * --- Accessibility & Arduino ---
 *         Cnam-Enjmin P20        
 * 
 * File: Writing
 * Description: Keyboard where you 
 * can change letter then validate
 * and write a text
 * 
 * Author: Théophile Carrasco
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
 
int xKeyboardPos, yKeyboardPos;   // keyboard coordonates

int xCursorPos, yCursorPos;       // cursor coordonates
int cursorId;                     // cursor current letter

int keyBoxWidth = 35, keyBoxHeight = 35, keyBoxOffset = 5;  // width and height of box that contains key plus spacing between boxes
int keyCharWidthOffset = 7, keyCharHeightOffset = -8;    // offset to center letter inside a box 

int keyBG = #3e6785;      // background color
int keyColor = #ffa825;   // font color

String textToDisplay = ">";   // text to display

Serial myPort;  // Create object from Serial class
String valCurrent, valPrevious;     // Data received from the serial port

 /**
 * Methods
 *
 */

/** 
 * Initialization
 */
void setup() {
  size(1080, 720); 
  noStroke(); // disables rectangle outline
  background(#2d3e41); 
  textSize(35);  
  xKeyboardPos = (width/2) - 13 * (keyBoxWidth + keyBoxOffset);
  yKeyboardPos = 10;  
  
  xCursorPos = xKeyboardPos;
  yCursorPos = yKeyboardPos;
  
  cursorId = 0;
}

/** 
 * Draw each frame
 */
void draw() {
  drawKeyBoard();
  drawCursor();
  drawText(width/2 - 300, height/2);
}

/** 
 * Every time a key is pressed
 */
void keyPressed() {
  if (key == 'Q' || key == 'q') {
    moveCursorLeft();
  } else if (key == 'D' || key == 'd') {
    moveCursorRight();
  } else if (key == ' ') {
    addLetter();
  }
  
}


/** 
 * drawKey(int keyValue, int x, int y, int bg, int col)
 * 
 * Draw a char from keyValue inside a box at x, y coords 
 * with col as font color and bg as background color  
 */
void addLetter() {
  textToDisplay += char('A' + cursorId);
}



/** 
 * drawKey(int keyValue, int x, int y, int bg, int col)
 * 
 * Draw a char from keyValue inside a box at x, y coords 
 * with col as font color and bg as background color  
 */
void drawText(int x, int y) {
  fill(keyColor);
  text(textToDisplay, x, y, 1000, 1000);
}






/** 
 * drawKey(int keyValue, int x, int y, int bg, int col)
 * 
 * Draw a char from keyValue inside a box at x, y coords 
 * with col as font color and bg as background color  
 */
void drawKey(int keyValue, int x, int y, int bg, int col) {
  fill(bg);
  rect(x, y, keyBoxWidth, keyBoxHeight);
  fill(col);
  text(char('A' + keyValue), x + keyCharWidthOffset, y + keyBoxHeight + keyCharHeightOffset);
}

/** 
 * drawKeyBoard()
 * 
 * Draw the keyboard by calling drawKey(...) for each 
 * letter of the alphabet
 */
void drawKeyBoard() {
  int l_x = xKeyboardPos, l_y = yKeyboardPos;
  for (int i=0; i<26; i++) {
    drawKey(i, l_x, l_y, keyBG, keyColor);
    l_x += keyBoxWidth + keyBoxOffset;
  }
}




/** 
 * drawCursor()
 * 
 * Draw the current selected letter by inverting color
 * of a key box
 */
void drawCursor() {
  drawKey(cursorId, xCursorPos, yCursorPos, keyColor, keyBG);
}

/** 
 * moveCursorLeft()
 * 
 * Try to move the cursor to the left
 */
void moveCursorLeft() {  
  if (cursorId > 0) {
    setCursor(xCursorPos - keyBoxWidth - keyCharWidthOffset + 2, yCursorPos);
    cursorId--;
  }
}

/** 
 * moveCursorRight()
 * 
 * Try to move the cursor to the right
 */
void moveCursorRight() {
  if (cursorId < 25) {
    setCursor(xCursorPos + keyBoxWidth + keyCharWidthOffset - 2, yCursorPos);
    cursorId++;
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
