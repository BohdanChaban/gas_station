class Car
  attr_accessor :number, :gas_level, :gas_limit, :fueling

  def initialize(number)
    @number = number
    @gas_level = rand(1..10)
    @gas_limit = rand(3..7) * 10
    @fueling = false
  end
end
