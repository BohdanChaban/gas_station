require './column'
require './car'

class GasStation
  attr_accessor :columns, :cars

  def initialize(columns_count: 3, cars_count: 5)
    @columns = generate_instances('Column', columns_count)
    @cars = generate_instances('Car', cars_count)
  end

  private

  def generate_instances(class_type, count)
    arr = []
    count.times { |i| arr << Kernel.const_get(class_type).new(i + 1) }
    arr
  end
end
