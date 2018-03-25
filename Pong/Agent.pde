class Agent
{
  PVector pos;
  float speed = 2;
  
  boolean up, down;
  Ball ball;
  ClassicAI opponent;
  boolean random_start = true;
  
  NeuralNetwork brain;
  int input_size = 6;
  int output_size = 2;
  boolean done = false;
  int score, opponent_score;
  int time = 90;
  int time_check = 0;
  
  Agent()
  {
    opponent = new ClassicAI(this, 6);
    ball = new Ball(this, opponent);
    opponent.setBall(ball);
    if(AI_ON)
      brain = new NeuralNetwork(6, 2);
    reset();
  }
  
  void step()
  {
    time_check++;
    if(time_check >= 60)
    {
      time--;
      time_check = 0;
    }
    
    if(up)
      pos.y -= speed;
    else if(down)
      pos.y += speed;
    if(pos.y<70)
      pos.y=70;
    if(pos.y>530)
      pos.y=530;
      
    ball.step();
    opponent.checkBall();
      
    if(ball.pos.x <20)
    {
      opponent_score += 1;
      ball.vel = new PVector(sqrt(speed),-sqrt(speed));
      reset();
    }
      
    if(ball.pos.x >790)
    {
      score += 1;
      ball.vel = new PVector(-sqrt(speed),-sqrt(speed));
      reset();
    }
    
    if(time == 0)
      done = true;
    
    if(score+opponent_score == 9)
    {
      if(score == 9)
        score += time/10;
      done = true;
    }
      
    if(AI_ON)
    {
      float[] observation = observe();
      int output = brain.calculate_output(observation);
      move(output);
    }
  }
  
  float[] observe()
  {
    float[] observation = new float[input_size];
    observation[0] = pos.y;
    observation[1] = ball.pos.x;
    observation[2] = ball.pos.y;
    observation[3] = ball.vel.x;
    observation[4] = ball.vel.y;
    observation[5] = opponent.pos.y;
    return observation;
  }
  
  void move(int action)
  {
    if (action == 1)
      pos.y -= speed;
    else
      pos.y += speed;
    if(pos.y<70)
      pos.y=70;
    if(pos.y>530)
      pos.y=530;
  }
  
  void show()
  {
    int a = 20;
    int b = 100;
    fill(0xFFFFFFFF);
    stroke(-1);
    rect(pos.x-a/2,pos.y-b/2, a, b);
    
    textSize(32);
    fill(0xFFFFFFFF);
    text(("Time left: " + time), 20, 50);
    
    textSize(128);
    fill(0xFFFFFFFF);
    text(score, width/2-150, 150);
    
    textSize(128);
    fill(0xFFFFFFFF);
    text(opponent_score, width/2+64, 150);
    
    opponent.show();
    ball.show();
  }
  
  void reset()
  {
    if(random_start)
    {
      if(random(1) > 0.5)
        ball.vel.x *= -1;
      if(random(1) > 0.5)
        ball.vel.y *= -1;
    }
    opponent.pos = new PVector(800-20, 300);
    ball.pos = new PVector(400,300);
    pos = new PVector(20, 300);
    done = false;
  }
}