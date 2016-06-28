class NeuralNetwork
  attr_accessor :graph, :input_layer, :output_layer, :inputs, :result, :mse

  def initialize(layers: [], graph: nil)
    @graph = graph
    create_network(layers)
  end

  def stats
    puts "----- About this Neural Network -----"
    puts "Layers: #{Layer.count}"
    puts "Neurons: #{Neuron.count} (#{Bias.count} of which are Bias neurons) "
    puts "Connections: #{Connection.count}"
    puts "-------------------------------------"
  end

  def diagram
    # Outputs a diagram of the Neural Network
    self.graph.output(:png => "network.png") unless self.graph.nil?
  end

  def train(dataset: [], ideal: 0.0)
  end

  def predict(dataset: [])
    # Take an array of data and map each element to an input neuron, but not a bias neuron
    self.inputs = dataset.dup
    self.input_layer.neurons.each do |n|
      if n.class == "Bias"
        next
      else
        n.broadcast(dataset.shift)
      end
    end
  end

  def output
    OpenStruct.new({ inputs: self.inputs, prediction: [], mse: 0.0, rmse: 0.2 })
  end

  private
    def create_network(layers)
      initialized_layers = []
      layers.each do |layer|
        l = Layer.new(
          name: layer[:name],
          neurons: layer[:neurons],
          bias: layer[:bias],
          network: self
        )
        initialized_layers << l
      end

      @input_layer = initialized_layers.first
      @output_layer = initialized_layers.last

      connect_layers(initialized_layers)
    end

    def connect_layers(layers)
      #Connect all the layers
      s, e = 0, 1 # Set the start and and of array range
      (layers.length - 1).times do
        layer_pair = layers[s..e]
        layer_pair[0].connect_to(layer_pair[1], self.graph)
        s += 1
        e += 1
      end
    end

    def calculate_mse
      #(ideal minus actual)squared for each one, then divide the whole thing by the number of numbers
      #((ideal1 - actual1)^2 + (ideal2 - actual2)^2) / n
      # loop through output neurons, neuron will need to store its own ideal and actual output
      neurons = self.output_layer.neurons
      sum = neurons.inject(0){ |sum, neuron| sum += ((neuron.ideal.to_f - neuron.actual.to_f)**2) }
      sum = sum / neurons.size
      self.mse = sum
    end
end
