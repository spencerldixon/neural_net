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
    # TODO - Don't send to bias neurons!
    self.neurons.each {|n| n.feed(array.shift) }
  end

  def connect_to(second_layer, graph=nil)
    self.neurons.each do |first_layer_neuron|
      second_layer.neurons.each do |second_layer_neuron|
        conn = Connection.new(first_layer_neuron, second_layer_neuron)
        # Graph the connection
        unless graph.nil?
          if first_layer_neuron.class.name == "Bias"
            graph.add_edges(first_layer_neuron.graphviz, second_layer_neuron.graphviz, penwidth: conn.weight.round(2), fontsize: 8, labeldistance: 0.05, color: '#db4437')
          else
            graph.add_edges(first_layer_neuron.graphviz, second_layer_neuron.graphviz, penwidth: conn.weight.round(2), fontsize: 8, labeldistance: 0.10)
          end
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
          neuron.graphviz = network.graph.add_nodes(SecureRandom.uuid,
                                                    label: "#{self.name[0].upcase}#{n}",
                                                    fontname: 'Helvetica',
                                                    fontsize: 8,
                                                    color: 'none',
                                                    style: 'filled',
                                                    fillcolor: '#4285f4',
                                                    shape: 'circle')
        end
      end
    end

    def create_bias(network)
      bias = Bias.new
      self.neurons << bias
      # Graph the node
      unless network.graph.nil?
        bias.graphviz = network.graph.add_nodes(SecureRandom.uuid,
                                                label: "B#{self.name[0].upcase}",
                                                fontname: 'Helvetica',
                                                fontsize: 8,
                                                color: 'none',
                                                style: 'filled',
                                                fillcolor: '#db4437',
                                                shape: 'circle')
      end
    end
end
