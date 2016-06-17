class Network
  attr_accessor :input_layer, :output_layer

  def initialize(input_layer, output_layer)
    @input_layer = input_layer
    @output_layer = output_layer
  end

  def stats
    puts "----- About this Neural Network -----"
    puts "Layers: #{Layer.count}"
    puts "Neurons: #{Neuron.count} (#{Bias.count} of which are Bias neurons) "
    puts "Connections: #{Connection.count}"
    puts "-------------------------------------"
  end

  def predict(*inputs)
    @input_layer.neurons.each do |n|
      n.broadcast(inputs.shift)
    end
  end

  def train(inputs)
  end
end
