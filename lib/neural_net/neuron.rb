class Neuron
  attr_accessor :incoming_connections, :outgoing_connections, :inputs_received
  @@count = 0

  def initialize
    @@count += 1
    # connections array stores information about what this particular neuron is connected to and the weight of that connection
    # when the fire method is called, the neuron then calculates the output, and broadcasts it to all the connections
    # the connections perhaps use a curry function to wait until it has all the necessary connections and then fire the neuron and repeat
    #
    # a neuron needs to know how many connections to expect, then when it meets this number it fires its input to the next neuron, which adds it to it's inputs bucket, when that input bucket is full, it fires it's output to the next neuron and so on
    @incoming_connections = []
    @outgoing_connections = []
    @inputs_received = 0

    # neuron keeps track of how many connection updates its recieved, when this is the same amount as the incoming connections, it fires the neuron and resets to 0 waiting for the next group of inputs
  end

  def count
    @@count
  end

  def feed(input)
    # Takes an input and adds it to the bucket, when the number of inputs matches the number of incoming connections, the neuron fires
    @inputs << input
    if @inputs.size >= @incoming_connections.size
      self.fire
    end
  end

  def fire

    sum = inputs_and_weights.inject(0){ |sum, i| sum += (i[0] * i[1]) }
    sum += (bias[0] * bias[1])
    puts sum
    activate(sum)
    # broadcast(result)
    self.inputs_received = 0
  end

  def activate(sum)
    1.0 / (1.0 + Math.exp(-sum))
  end

  def broadcast(result)
    # Broadcasts a result to all the outgoing connections of this neuron, the connections then hold a weight and a value that the next neuron can use
    #
    #connections.each do |neuron|
      # something like this?
      #neuron.fire([result, weight], bias)
    #end
  end
end
