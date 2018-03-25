class Population
{
  Agent[] agents;
  float mutationRate = 0.05;
  int generation = 0;
  int current_best = 0;
  ArrayList avgs;
  
  Population(int size)
  {
    agents = new Agent[size];
    avgs = new ArrayList();
    for (int i=0; i<size; i++)
    {
      agents[i] = new Agent();
    }
  }
  
  void update()
  {
    for (Agent agent : agents)
    {
      if(!agent.done)
        agent.step();
    }
    
    textSize(32);
    fill(255, 255, 255);
    text(("Agent "+shown_agent), width/2-60, 50);
    agents[shown_agent].show();
    
    textSize(32);
    fill(255, 255, 255);
    text(("Best score: "+current_best), width-240, 50);
    agents[shown_agent].show();
    
    textSize(12);
    fill(255, 255, 255);
    text(("Generation: " + generation), 20, 120);
    
    for(int i=0; i<avgs.size(); i++)
    {
      fill(255, 255, 255);
      text((avgs.get(i)).toString(), 120 + 50 * (i%13), 120 + 30 * floor(i/13));
    }
  }
  
  void naturalSelection()
  {
    Agent[] new_agents = new Agent[agents.length];
    for(int i=0; i<agents.length; i++)
    {
      if(i<ceil(agents.length/20))
        new_agents[i] = findBest(agents);
      else
        new_agents[i] = crossover(new_agents[floor(random(new_agents.length/20))], new_agents[floor(random(new_agents.length/20))]);
      mutate(new_agents[i]);
    }
    agents = new_agents;
  }
  
  Agent findBest(Agent[] agents)
  {
    Agent best_agent = agents[0];
    for (Agent agent : agents)
    {
      if (agent.score > best_agent.score)
        best_agent = agent;
    }
    if(best_agent.score > current_best)
      current_best = best_agent.score;
    best_agent.score = -1;
    return best_agent;
  }
  
  Agent crossover(Agent agent1, Agent agent2)
  {
    Agent new_agent = new Agent();
    
    ArrayList<Matrix> weights1 = agent1.brain.weights;
    ArrayList<Matrix> weights2 = agent2.brain.weights;
    ArrayList<Matrix> new_weights = new ArrayList<Matrix>();
    
    for(int i=0; i<weights1.size(); i++)
    {
      new_weights.add(weights1.get(i).randomJoin(weights2.get(i)));
    }
    new_agent.brain.weights = new_weights;
    return new_agent;
  }
  
  void mutate(Agent agent)
  {
    for (int i=0; i<agent.brain.weights.size(); i++)
      agent.brain.weights.get(i).randomDistort(mutationRate);
  }
  
  boolean done()
  {
    for (Agent agent : agents)
    {
      if(!agent.done)
        return false;
    }
    return true;
  }
  
  void reset()
  {
    generation += 1;
    for(int i=0; i<agents.length; i++)
    {
      agents[i].reset();
      agents[i].score = 0;
      agents[i].opponent_score = 0;
      agents[i].time = 90;
    }
  }
  
  float getAVG()
  {
    float result = 0;
    for(int i=0; i<agents.length; i++)
    {
      result += agents[i].score;
    }
    result /= agents.length;
    return result;
  }
}