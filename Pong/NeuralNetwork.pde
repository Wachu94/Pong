class NeuralNetwork
{
  ArrayList<Matrix> weights = new ArrayList<Matrix>();
  Matrix input_layer;
  
  NeuralNetwork(int input_size, int output_size)
  {
    Matrix network;
    network = add_input_layer(input_size);
    network = add_layer(network, 1);
    network = add_layer(network, 1);
    network = add_layer(network, 1);
    network = add_layer(network, 1);
    network = add_output_layer(network, output_size);
  }
  
  int calculate_output(float[] observation)
  {
    Matrix calculated = input_layer(observation);
    for(int i = 0; i<weights.size(); i++)
    {
      calculated = weights.get(i).dot(calculated);
      if(i<weights.size()-1)
        activate(calculated, "reLU");
      else
        activate(calculated, "softmax");
    }
    
    return calculated.max();
  }
  
  Matrix input_layer(float[] input_values)
  {
    for (int j = 0; j<input_values.length; j++) {
      input_layer.values[j][0] = input_values[j];
    }
    return input_layer;
  }
  
  Matrix add_input_layer(int size)
  {
    Matrix input = new Matrix(size+1);
    input.values[size][0] = 1;
    input_layer = input;
    return input;
  }
  
  Matrix add_layer(Matrix network, int layer_size)
  {
    Matrix new_layer = new Matrix(layer_size+1, network.values.length);
    randomize(new_layer);
    weights.add(new_layer);
    new_layer = new_layer.dot(network);
    new_layer.values[layer_size][0] = 1;
    return new_layer;
  }
  
  Matrix add_output_layer(Matrix network, int output_size)
  {
    Matrix new_layer = new Matrix(output_size, network.values.length);
    randomize(new_layer);
    weights.add(new_layer);
    new_layer = new_layer.dot(network);
    return new_layer;
  }
  
  void randomize(Matrix matrix)
  {
    for (int i =0; i<matrix.values.length; i++) {
      for (int j = 0; j<matrix.values[0].length; j++) {
        matrix.values[i][j] = random(-1, 1);
      }
    }
  }
  void activate(Matrix matrix, String function_name)
  {
    switch(function_name)
    {
      case "reLU":
      for (int i =0; i<matrix.values.length; i++) {
          if (matrix.values[i][0] < 0)
          matrix.values[i][0] = 0;
      }
      break;
      
      case "softmax":
      float sum = 0;
      for (int i =0; i<matrix.values.length; i++) {
          matrix.values[i][0] = pow((float)Math.E, matrix.values[i][0]);
          sum += matrix.values[i][0];
      }
      for (int i =0; i<matrix.values.length; i++) {
          matrix.values[i][0] /= sum;
      }
      break;
    }
  }
}