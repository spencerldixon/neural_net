class Neuroon
  attr_reader :inputs

  def initialize
    @inputs = []
  end

  def inputs=(*inputs)
    inputs.each {|n| @inputs << n }

    puts "Added! #{@inputs.size}"
    if self.inputs.size >= 3
      self.fire
    end
  end

  def fire
    puts "Too full! Time to fire! - #{self.inputs}"
  end
end
