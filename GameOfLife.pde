import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private Life[][] buttons; 
private boolean[][] buffer; 
private boolean running = true; 
private boolean on = true;
public int speed = 20;

public void setup () {
  size(400, 400);
  frameRate(speed);
  Interactive.make(this);
  
  
  buttons = new Life[NUM_ROWS][NUM_COLS];
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      buttons[r][c] = new Life(r,c);
    }
  }
  buffer = new boolean[NUM_ROWS][NUM_COLS];
}

public void draw () {
  if(on == false){
    return;
  }
  background(0);
  if (running == false) 
    return;
  copyFromButtonsToBuffer();

  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      if(countNeighbors(r,c) == 3){
        buffer[r][c] = true;
      }else if(countNeighbors(r,c) == 2 &&  buttons[r][c].getLife()){
        buffer[r][c] = true;
      }else{
        buffer[r][c] = false;
      }
       buttons[r][c].draw();
    }
  }
    
    copyFromBufferToButtons();
}

public void keyPressed() {
  if(key == 's'){
    on = !on;
  }

}

public void copyFromBufferToButtons() {
   for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c].setLife(buffer[r][c]);
    }
  }
}

public void copyFromButtonsToBuffer() {
   for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buffer[r][c] = buttons[r][c].getLife();
    }
  }
}

public boolean isValid(int r, int c) {
  if((r >= 0 && r < 20) && (c >= 0 && c < 20)){
    return true;
  }
  return false;  
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  
  for(int r = row-1;r<=row+1;r++){
      for(int c = col-1; c<=col+1;c++){
        if(isValid(r,c) && buttons[r][c].getLife()==true){
          neighbors++;
        }
      }
  }
    if(buttons[row][col].getLife()==true){
      neighbors--;
    }
  return neighbors;  
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < 0.5; 
    Interactive.add(this); 
  }

  public void mousePressed () {
    alive = !alive; 
  }
  public void draw () {  
    strokeWeight(3);
    if (alive != true)
      fill(0);
    else 
      fill(245, 215, 232);
    rect(x, y, width, height);
  }
  public boolean getLife() {
      return alive;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
