class Connection
  @@count = 0
  attr_accessor :weight
  attr_reader :value

  def initialize(from, to)
    @from = from
    @to = to
    @weight = rand.round(4)
    @value

    from.outgoing_connections << self
    to.incoming_connections << self
    @@count += 1
  end

  def self.count
    @@count
  end

  def value=(value)
    # Whenever a connection value is updated we notify the neuron it's connected to.
    @value = value
    @to.connection_updated
  end
end
