int population_size = 5000;
Population population;
boolean AI_ON = true;
Agent player;
int shown_agent = 0;
int f_rate = 60;

void setup()
{
  size(800,600);
  frameRate(f_rate);
  population = new Population(population_size);
  player = new Agent();
}

void draw()
{
  bg();
  if (AI_ON)
  {
    if(!population.done())
      population.update();
    else
    {
      population.avgs.add(population.getAVG());
      population.naturalSelection();
      population.reset();
    }
  }
  else
  {
    player.step();
    player.show();
  }
}

void keyPressed()
{
  switch(key)
  {
    case ',':
    shown_agent -=1;
    if(shown_agent == -1)
      shown_agent = population_size -1;
    break;
   case '.':
    shown_agent +=1;
    if(shown_agent == population_size)
      shown_agent = 0;
    break;
    case 'w':
      player.up = true;
    break;
    case 's':
      player.down = true;
    break;
  }
}

void keyReleased()
{
  switch(key)
  {
    case 'w':
      player.up = false;
    break;
    case 's':
      player.down = false;
    break;
  }
}

void bg()
{
  background(0xFF000000);
  for(int i = 0; i<height;i+=50)
  {
    int side = 20;
    fill(0xFFFFFFFF);
    stroke(0);
    rect((width-side/4)/2,i+side/2, side/4, side);
  }
  fill(0xFFFFFFFF);
  stroke(-1);
  rect(0,0, width, 20);
  rect(0,height-20, width, 20);
}