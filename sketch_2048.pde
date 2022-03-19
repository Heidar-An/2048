import java.util.Map;
class square
{
  int value, xPos, yPos;
  square(int val, int xpos, int ypos){
    value = val;
    xPos = xpos;
    yPos = ypos;
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


// vertical lines = (187, 173, 160, 255)
// 2 square = rgba(238,228,218,255)
// 4 square = (238, 225, 201)
square[] squares = new square[16];
HashMap<Integer, colour> valToCol = new HashMap<Integer, colour>();

void setup(){
  size(750, 750);
  squares[3] = new square(2, 0, 0);
  squares[4] = new square(2, 0, 0);
  valToCol.put(2, new colour(238, 228, 218));
}

void draw(){
  background(205, 193, 180, 255);
  
  float gap = 750/4;
  // change thickness of line
  
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
    line(0, j * gap + 5, 750, j * gap + 5);
  }
  fill(205, 193, 180);
  
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
      float xPos = i * gap + 20;
      float yPos = j * gap + 20;
      if(i == 0){
        // left edge
        xPos = i * gap + 25;
      }
      if(j == 0){
        yPos = j * gap + 25;
      }
      if(i == 3){
        xPos = i * gap;
      }
      square(i * gap + 15, j * gap + 20, 166);
    }
  }
  
}
