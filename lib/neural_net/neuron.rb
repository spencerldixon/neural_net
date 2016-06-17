class Neuron
  attr_accessor :incoming_connections, :outgoing_connections, :inputs_received, :bias, :graphviz
  @@count = 0

  def initialize
    @@count += 1
    @incoming_connections = []
    @outgoing_connections = []
    @inputs_received = 0 # Keep track of how many connection updates the neuron has received, when this is the same as the incoming connections, the neuron is fired and the count resets to 0 ready for the next group of inputs
    @bias = 1
    @graphviz
  end

  def self.count
    @@count
  end

  def connection_updated
    # Takes an input and adds it to the bucket, when the number of inputs matches the number of incoming connections, the neuron fires
    @inputs_received += 1
    if @inputs_received >= @incoming_connections.size
      self.fire
    end
  end

  def fire
    # Takes all the values and weights from incoming connections, sums them, puts them through the activation function and broadcasts them to the other neurons
    # This includes a bias node whos value is always 1
    sum = self.incoming_connections.inject(0){ |sum, conn| sum += (conn.value.to_f * conn.weight.to_f) }
    result = activate(sum)
    broadcast(result)
    self.inputs_received = 0
  end

  def activate(sum)
    1.0 / (1.0 + Math.exp(-sum))
  end

  def broadcast(float)
    # Broadcasts a result to all the outgoing connections of this neuron,
    # The connections hold a weight and a value that the next neuron can use
    if self.outgoing_connections.any?
      self.outgoing_connections.each do |connection|
        connection.value=(float)
      end
    else
      # Assume that this is output layer and return value to the network
      p "Last node, output: #{float}"
    end
  end
end
