require "neural_net/version"

module NeuralNet
  # Your code goes here...
  require 'neural_net/neuron'
  require 'neural_net/layer'
  require 'neural_net/connection'
  require 'neural_net/network'
  require 'neural_net/bias'
  require 'ruby-graphviz'

  # Create a few layers
  #input_layer = NeuralNet::Layer.new
  #hidden_layer = NeuralNet::Layer.new
  #output_layer = NeuralNet::Layer.new

  # Create our input neurons
  #input_layer.create_neurons(2)
  #hidden_layer.create_neurons(3)
  #output_layer.create_neurons(1)

  #puts input_layer.inspect
  #puts hidden_layer.inspect
  #puts output_layer.inspect

  # Remember our inputs have to be scaled between 0 and 1 or our activation function fucks everything up

  # We can create single neurons
  #n1 = Neuron.new
  #n2 = Neuron.new
  #n3 = Neuron.new

  # Shitty neural network

  g = GraphViz.new(:G, type: :digraph, splines: 'line')
  # Or create a layer and specify how many neurons each layer needs
  first_layer = Layer.new
  first_layer.create_neurons(2, 1, g, "I")

  second_layer = Layer.new
  second_layer.create_neurons(2, 1, g, "H")

  third_layer = Layer.new
  third_layer.create_neurons(1, nil, g, "O")

  # Then we connect the layers
  first_layer.connect_to(second_layer, g)
  second_layer.connect_to(third_layer, g)

  network = Network.new(first_layer, third_layer)
  network.stats
  network.predict(1, 0)

  g.output( :png => "network.png" )



  # How i'd like it to be...
  network = NeuralNetwork.new(
    layers: [
      {name: "Input", neurons: 2, bias: true},
      {name: "Hidden", neurons: 3, bias: true},
      {name: "Output", neurons: 1}
    ]
    graph: Graphviz.new(:G, type: :digraph, splines: 'line') # Optional but needed if you want to generate a diagram
  )

  # Get a summary of the networks layers, connections, neurons, how many times it's been trained, iterations of the same dataset etc. Call this at any time to get a snapshot of the network
  network.stats

  # Generate a diagram for the network
  network.diagram

  # Input a single dataset and expected output to train the network, array size must match input neurons
  network.train(dataset: [0.1, 0.2], output: 0.3)

  # Take a csv where each column is an input and the final column is the expected output, train for X iterations of the dataset
  network.train_from_csv(path: "/", iterations: 200)

  # Get the current accuracy for the network
  network.accuracy

  # Predict the output for a single dataset
  network.predict(dataset: [0.2, 0.4])

  # Neuron will know about the network it's part of and be able to report back to it, so will connections and layers.
  # Weights and values get passed and stored in the connections, like the previous model
  # Only difference is everything is done from the network object and everything knows about the network
  # Integrate with Redis for storage?
end

