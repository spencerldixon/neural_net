class Bias < Neuron
  # Bias is the same as neuron except it doesn't calculate, it just returns its own value (which is usually always one)
  # Its connections still have weights.
  attr_accessor :value, :incoming_connections, :outgoing_connections, :inputs_received
  @@count = 0

  def initialize(value)
    @@count += 1
    @value = value
    @incoming_connections = []
    @outgoing_connections = []
    @inputs_received
  end

  def self.count
    @@count
  end

  def fire
    # Bias don't give no fucks about incoming connections, just itself
    # Thug bias.
    broadcast(self.value)
    self.inputs_received = 0
  end
end
