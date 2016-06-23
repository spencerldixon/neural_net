class NeuralNetwork
  attr_accessor :graph, :input_layer, :output_layer, :inputs, :result

  def initialize(layers: [], graph: nil)
    @graph = graph
    create_network(layers)
  end

  def diagram
    # Outputs a diagram of the Neural Network
    self.graph.output(:png => "network.png") unless self.graph.nil?
  end

  def stats
  end

  def accuracy
  end

  def output
    OpenStruct.new({inputs: self.inputs, prediction: self.result, mse: 0.0, rmse: 0.0})
  end

  def train(dataset, output)
  end

  def predict(dataset: [1,2,3])
    # Take an array of data and map each element to an input neuron
    self.inputs = dataset.dup
    self.input_layer.neurons.each do |n|
      n.broadcast(dataset.shift)
    end
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
end
