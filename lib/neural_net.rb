require "neural_net/version"

module NeuralNet
  # Your code goes here...
  require 'neural_net/neuron'
  require 'neural_net/layer'
  require 'neural_net/connection'
  require 'neural_net/network'
  require 'neural_net/bias'



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

  #node = Neuron.new
  #bias = [1,6]
  #connections = [[0.1,5], [0.2,6], [0.3,7], [0.4,8]]
  ## connections are the input number at 0, and the weight of the connection at 1
  ## Remember out inputs have to be scaled between 0 and 1 or our activation function fucks everything up
  #puts node.fire(connections, bias)

  #puts "----------------"
  #n = Neuroon.new
  #n.inputs = 1
  #n.inputs = 2
  #n.inputs = 3


  # We can create single neurons
  #n1 = Neuron.new
  #n2 = Neuron.new
  #n3 = Neuron.new
  require 'ruby-graphviz'
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






  # Loop and stuff
  #NeuralNet.train([1,0])
  #=> 1
  #NeuralNet.predict([1,0])
  #input_layer.input([1,2,3,4,5])
end
