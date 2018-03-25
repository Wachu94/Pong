class ClassicAI
{
  PVector pos;
  Ball ball;
  float speed;
  int difficulty;
  
  ClassicAI(Agent agent, int difficulty)
  {
    this.difficulty = difficulty;
    pos = new PVector(800-20, 300);
    speed = 5+(2*difficulty+1);
  }
  
  void setBall(Ball ball)
  {
    this.ball = ball;
  }
  
  void checkBall()
  {
    if(ball.pos.x > 600-100*difficulty)
    {
      if(abs(ball.pos.y-pos.y)>30)
      {
        if(ball.pos.y > pos.y)
          pos.y += speed;
        else
          pos.y -= speed;
      }
    }
  }
  
  void show()
  {
    int a = 20;
    int b = 100;
    fill(0xFFFFFFFF);
    stroke(-1);
    rect(pos.x-a/2,pos.y-b/2, a, b);
  }
}