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



// vertical lines = (187, 173, 160, 255)
// 2 square = rgba(238,228,218,255)
square[] squares = new square[16];

HashMap<Integer, 

void setup(){
  size(750, 750);
  squares[0] = new square(2, 0, 0);
}

void draw(){
  background(205, 193, 180, 255);
  
  float gap = 750/4;
  // change thickness of line
  strokeWeight(20);
  stroke(187, 173, 160, 255);
  
  // make lines at the left and right side
  // because these lines go off the screen
  line(10, 0, 10, 750);
  line(740, 0, 740, 750);
  // columns
  for(int i = 1; i < 4; i++){
    line(i * gap, 0, i * gap, 750);
  }
  
  
  line(0, 10, 750, 10);
  line(0, 740, 750, 740);
  // rows
  for(int j = 0; j < 5; j++){
    line(0, j * gap, 750, j * gap);
  }
  
  fill(205, 193, 180);
  // draw squares
  for(int i = 0; i < 4; i++){
    for(int j = 0; j < 4; j++){
      square(i * gap, j * gap, gap);
    }
  }
  
}
