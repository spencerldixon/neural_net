class NeuralNetwork
  attr_accessor :graph

  def initialize(layers: [], graph: nil)
    @graph = graph
    create_network(layers)
  end

  def diagram
    # Outputs a diagram of the Neural Network
    self.graph.output(:png => "network.png") if self.graph.present?
  end

  def stats
  end

  def accuracy
  end

  def train(dataset, output)
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
      #connect_layers(initialized_layers)
    end

    def connect_layers
      #Connect all the layers
      s, e = 0, 1 # Set the start and and of array range
      (layers.length - 1).times do
        layer_pair = layers[s..e]
        layer_pair.first.connect_to(layer_pair.second)
        s += 1
        e += 1
      end
    end
end
