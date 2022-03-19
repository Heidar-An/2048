import java.util.Map;
class square
{
  int value, row, column;
  square(int val, int r, int c){
    value = val;
    row = r;
    column = c;
  }   
  
  void doubleVal(){
    value *= 2;
  }
}

class colour{
  int red, green, blue;
  colour(int r, int g, int b){
    red = r;
    green = g;
    blue = b;
  }
}


// black text = (119, 110, 101)
// white text = (249, 246, 242)
square[] squares = new square[16];
HashMap<Integer, colour> valToCol = new HashMap<Integer, colour>();
HashMap<Integer, Boolean> valToText = new HashMap<Integer, Boolean>();

void setup(){
  size(750, 750);
  
  generateRandomSquare();
  generateRandomSquare();
  
  // put colours for each different value
  valToCol.put(2, new colour(238, 228, 218));
  valToCol.put(4, new colour(238, 225, 201));
  valToCol.put(8, new colour(243, 178, 122));
  valToCol.put(16, new colour(246, 150, 100));
  valToCol.put(32, new colour(247, 124, 95));
  valToCol.put(64, new colour(246, 94, 57));
  valToCol.put(128, new colour(237, 206, 115));
  valToCol.put(256, new colour(237, 202, 100));
  valToCol.put(512, new colour(237, 198, 81));
  valToCol.put(1024, new colour(238, 199, 68));
  valToCol.put(2048, new colour(236, 194, 48));
  
  // if true, then dark font is being used, if false then light font is being used
  valToText.put(2, true);
  valToText.put(4, true);
  valToText.put(8, false);
  valToText.put(16, false);
  valToText.put(32, false);
  valToText.put(64, false);
  valToText.put(128, false);
  valToText.put(256, false);
  valToText.put(512, false);
  valToText.put(1024, false);
  valToText.put(2048, false);
}

void draw(){
  background(205, 193, 180, 255);
  
  float gap = 750/4;
  // change thickness of line
  
  strokeWeight(1);
  // draw squares
  // if the square is on the left edge of the grid, add 25 to x, if on the top edge, add 25 to y
  // if on the bottom edge - 25 to y, if on the right edge, -25 to x
  // else add or m
  for(int i = 0; i < 4; i++){
    for(int j = 0; j < 4; j++){
      square cSquare = squares[j * 4 + i];
      
      if(cSquare == null){
        continue;
      }
      
      int value = cSquare.value;
      colour cColour = valToCol.get(value);
      fill(cColour.red, cColour.green, cColour.blue);
      
      float xPos = i * gap + 15;
      float yPos = j * gap + 7;
      if(i == 0){
        // left edge
        xPos = i * gap + 13;
      }
      if(j == 0){
        yPos = j * gap + 22;
      }
      
      square(xPos, yPos, 175);
      
      if(i == 3){
        xPos += 50;
      }else{
        xPos += 60;
      }
      if(j == 0){
        yPos += 110;
      }else{
        yPos += 120;
      }  
      

      textSize(110);
      boolean colourText = valToText.get(value);
      if(colourText){
        fill(119, 110, 101);
      }
      else{
        fill(249, 246, 242);
      }
      text(str(value), xPos, yPos);
    }
  }
  
  stroke(187, 173, 160, 255);
  
  // make lines at the left and right side
  // because these lines go off the screen
  strokeWeight(45);
  line(0, 0, 0, 750);
  line(750, 0, 750, 750);
  
  strokeWeight(20);
  // columns
  for(int i = 1; i < 4; i++){
    line(i * gap + 5, 0, i * gap + 5, 750);
  }
  
  strokeWeight(25);
  line(0, 10, 750, 10);
  line(0, 740, 750, 740);
  
  strokeWeight(20);
  // rows
  for(int j = 0; j < 5; j++){
    line(0, j * gap, 750, j * gap);
  }
  fill(205, 193, 180);
}

Boolean generateRandomSquare(){
  boolean full = true;
  for(int i = 0; i < 16; i++){
    if(squares[i] == null){
      full = false;
    }
  }
  
  if(full){
    return full;
  }
  while(true){
    int rand = int(random(0, 16));
    if(squares[rand] != null){
      continue;
    }
    int ranVal = int(random(0, 2));
    if(ranVal == 0){
      ranVal = 2;
    }else{
      ranVal = 4;
    }
    
    squares[rand] = new square(ranVal, int(rand / 4), rand % 4);
    break;
  }
  return false;
}

void moveRight(){
  // check row by row
  // start from right side and move left
  // squares have to have the same value to coalesce
  
  for(int z = 0; z < 4; z++){
    for(int i = 2; i > -1; i--){
      int currPos = z * 4 + i;
      if(squares[currPos] == null){
        continue;
      }
      for(int j = i + 1; j < 4; j++){
        if(squares[z * 4 + j] != null){
          if(squares[z * 4 + j].value == squares[currPos].value){
            squares[z * 4 + j].doubleVal();
            squares[currPos] = null;
          }
          break;
        }else{
          squares[z * 4 + j] = squares[currPos];
          squares[currPos] = null;
          currPos = z * 4 + j;
        }
      }
    }
  }
}

void moveLeft(){
  // check row by row
  // start from left side and move right
  // squares have to have the same value to coalesce
  
  for(int z = 0; z < 4; z++){
    for(int i = 1; i < 4; i++){
      int currPos = z * 4 + i;
      if(squares[currPos] == null){
        continue;
      }
      for(int j = i - 1; j > -1; j--){
        if(squares[z * 4 + j] != null){
          if(squares[z * 4 + j].value == squares[currPos].value){
            squares[z * 4 + j].doubleVal();
            squares[currPos] = null;
          }
          break;
        }else{
          squares[z * 4 + j] = squares[currPos];
          squares[currPos] = null;
          currPos = z * 4 + j;
        }
      }
    }
  }
}

void moveUp(){
  // check column by column
  // start at the top and move down
  // no need to check the topmost row
  for(int z = 0; z < 4; z++){
    for(int i = 1; i < 4; i++){
      int currPos = i * 4 + z; // get current square
      if(squares[currPos] == null){
        continue;
      }
      for(int j = currPos - 4; j > -1; j-=4){ // check squares in the same column above
        if(squares[j] != null){
          if(squares[j].value == squares[currPos].value){
            squares[j].doubleVal();
            squares[currPos] = null;
          }
          break;
        }else{
          squares[j] = squares[currPos];
          squares[currPos] = null;
          currPos = j;
        }
      }
    }
  }
}

void moveDown(){
  // check column by column
  // start at the bottom and move up
  // no need to look at the bottom row
  for(int z = 0; z < 4; z++){
    for(int i = 2; i > -1; i--){
      int currPos = i * 4 + z; // get current square
      if(squares[currPos] == null){
        continue;
      }
      for(int j = currPos + 4; j < 16; j+=4){ // check squares in the same column below
        if(squares[j] != null){
          if(squares[j].value == squares[currPos].value){
            squares[j].doubleVal();
            squares[currPos] = null;
          }
          break;
        }else{
          squares[j] = squares[currPos];
          squares[currPos] = null;
          currPos = j;
        }
      }
    }
  }
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == RIGHT){
      moveRight();
      generateRandomSquare();
    }
    else if(keyCode == LEFT){
      moveLeft();
      generateRandomSquare();
    }
    else if(keyCode == UP){
      moveUp();
      generateRandomSquare();
    }
    else if(keyCode == DOWN){
      moveDown();
      generateRandomSquare();
    }
  }
}  
