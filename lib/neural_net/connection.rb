class Connection
  @@count = 0
  attr_accessor :value, :weight

  def initialize(from, to)
    @from = from
    @to = to
    @weight = rand
    @value

    from.outgoing_connections << self
    to.incoming_connections << self
    @@count += 1
  end

  def self.count
    @@count
  end
end
