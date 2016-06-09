class Layer
  attr_accessor :neurons
  @@count = 0

  def initialize
    @neurons = []
    @@count += 1
  end

  def self.count
    @@count
  end

  def input(array)
    # input is broadcast as an output to all the connections, the connection then holds a value and a weight
    self.neurons.each {|n| n.feed(array.shift) }
  end

  def predict(array)
    # assumes that this is the input layer, and passes the inputs to each neuron in the input layer
    # skips the fire method and just broadcasts it to all other neurons
  end

  def train(array, expected_result)
  end

  def create_neurons(number)
    number.times do
      self.neurons << Neuron.new
    end
  end

  def connect_to(second_layer, bias: 0)
    self.neurons.each do |first_layer_neuron|
      first_layer_neuron.bias = bias
      second_layer.neurons.each do |second_layer_neuron|
        Connection.new(first_layer_neuron, second_layer_neuron)
      end
    end
  end
end
