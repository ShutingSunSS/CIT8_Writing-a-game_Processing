float R, G, B;
float SpeedX, SpeedY;
float x, y;
float diameter = 20;
boolean gameOver = false;
float gameScore = 0;
float boardH = 20;
// Using an ArrayList of PVector objects
// Declare an ArrayList of PVector objects
ArrayList history = new ArrayList();

void setup() {
  size(500, 500);
  changeColor();
  SpeedX = 3.2;
  SpeedY = 3.2;
  x = random(0, width - diameter);
  y = random(0, height - diameter);
}

void draw() {
  background(255);
  drawBall();
  move();
  detectCollision();
  historyBall();
}

void drawBall() {
  fill(R, G, B);
  ellipse(x, y, diameter, diameter);
}
void move() {
  x = x + SpeedX;
  y = y + SpeedY;
}

void changeColor() {
  R = random(0, 255);
  G = random(0, 255);
  B = random(0, 255);
}

void historyBall()
{
 PVector ball = new PVector(x, y);
  history.add(ball);
  // Remove old ones
  if (history.size() > 25) {
    history.remove(0);
  }
  // Draw everything
  for (int i = 0; i < history.size (); i++ ) {
    // Draw an ellipse for each element in the ArrayList. 
    // Color and size are tied to the loop's counter: i.
    noStroke();
    // Grab the current PVector
    PVector position = (PVector)history.get(i);
    // Look at the x and y of each PVector
    ellipse(position.x, position.y, i, i);
  }
}
void detectCollision() 
{
  if(gameOver == false)
  {
    textSize(15);
    text ("SCORE:" + gameScore * 100, width/2 - 50, height/2 - 10);
    rect(mouseX, height - boardH, 100, boardH);
     if(x + diameter/2 >= width) 
     {
        SpeedX *= -1;
        changeColor();
     }
     if(x - diameter/2 <= 0) 
     {
       SpeedX *= -1;
       changeColor();
     }
     if(y - diameter/2 <= 0) 
     {
       SpeedY*=-1;
       changeColor();
     }
      if(y + diameter/2 >= height - boardH)
      {
         if(x > mouseX && x < mouseX + 100)
           {
           SpeedY *= -1;
           gameScore++;
           changeColor();
           }
         else
           {
           gameOver();
           }
      }
  }
  else
  {
    background(0);
    textSize(15);
    text("Game Over!", width/2 - 50, height/2 - 10);
    text("CLICK TO RESTART", width/2 - 50, height/2 + 10);
  }     
}
void gameOver()
{
  gameOver = true;
}
void mouseClicked()
{
  SpeedY *= -1;
  x = random(0, width - diameter);
  y = random(0, height - diameter);
  gameScore = 0;
  gameOver = false;
}