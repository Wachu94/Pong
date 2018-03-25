class Ball
{
  PVector vel;
  PVector pos;
  int speed = 16;
  int side = 20;
  Agent agent;
  ClassicAI opponent;
  
  Ball(Agent agent, ClassicAI opponent)
  {
    this.agent = agent;
    this.opponent = opponent;
    pos = new PVector(400,300);
    vel = new PVector(-sqrt(speed),-sqrt(speed));
  }
  
  void step()
  {
    pos.x+=vel.x;
    pos.y+=vel.y;
    if(pos.y<=30 || pos.y>=570)
      vel.y *= -1;
    if((pos.x<=30 && abs(agent.pos.y-pos.y)<60) || (pos.x>=770 && abs(opponent.pos.y-pos.y)<50))
    {
      if(pos.x>=20 && pos.x<=790)
      {
        vel.x *= -1;
      }
      else
        vel.y *= -1;
        
      if(vel.y > 0)
      {
        if(pos.x<=30)
          vel.y = (pos.y-(agent.pos.y-60))/30;
        if(pos.x>=770)
          vel.y = (pos.y-(opponent.pos.y-60))/30;
      }
      else
      {
        if(pos.x<=30)
          vel.y = (pos.y-(agent.pos.y+60))/30;
        if(pos.x>=770)
          vel.y = (pos.y-(opponent.pos.y+60))/30;
      }
      vel.x /= abs(vel.y)/3;
      if(abs(vel.x)<1)
        vel.x*=100;
    }
  }
  
  void show()
  {
    rect(pos.x-side/2, pos.y-side/2, side, side);
  }
  
}