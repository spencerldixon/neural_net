require 'ruby-graphviz'
require 'securerandom'

class Layer
  attr_accessor :neurons, :name
  @@count = 0

  def initialize(name:      'Hidden',
                 neurons:   0,
                 bias:      false,
                 network:   nil
                 )
    @name = name
    @neurons = []
    @@count += 1

    create_neurons(neurons, network)
    create_bias(network) if bias
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

  def cccreate_neurons(number, bias, graph, layer_name)
    number.times do |n|
      neuron = Neuron.new
      self.neurons << neuron
      neuron.graphviz = graph.add_nodes("#{layer_name}#{n}")
    end

    if bias
      bias = Bias.new(bias)
      self.neurons << bias
      bias.graphviz = graph.add_nodes("Bias #{self.object_id}", color: 'red')
    end
  end

  def connect_to(second_layer, graph)
    self.neurons.each do |first_layer_neuron|
      second_layer.neurons.each do |second_layer_neuron|
        conn = Connection.new(first_layer_neuron, second_layer_neuron)
        if first_layer_neuron.class.name == "Bias"
          graph.add_edges(first_layer_neuron.graphviz, second_layer_neuron.graphviz, label: conn.weight, fontsize: 8, color: 'red')
        else
          graph.add_edges(first_layer_neuron.graphviz, second_layer_neuron.graphviz, label: conn.weight, fontsize: 8)
        end
      end
    end
  end

  private
    def create_neurons(number, network)
      number.times do |n|
        neuron = Neuron.new(network)
        self.neurons << neuron
        # Graph the layer
        unless network.graph.nil?
          neuron.graphviz = network.graph.add_nodes(SecureRandom.uuid, label: "#{self.name[0].upcase}#{n}")
        end
      end
    end

    def create_bias(network)
      bias = Bias.new
      self.neurons << bias
      # Graph the node
      unless network.graph.nil?
        bias.graphviz = network.graph.add_nodes(SecureRandom.uuid, color: 'red', label: "B#{self.name[0].upcase}")
      end
    end
end
