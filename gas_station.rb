class GasStation
  attr_accessor :columns, :cars

  def initialize(columns_count: 3, cars_count: 5)
    @columns = generate_instances('Column', columns_count)
    @cars = generate_instances('Car', cars_count)
  end

  private

  def generate_instances(class_type, count)
    arr = []
    count.times { |i| arr << Kernel.const_get(class_type).new(number: i + 1) }
    arr
  end
end

require 'pry'
require 'ruby-progressbar'

class Column
  attr_accessor :number

  def initialize(number:)
    @number = number
    p "Column #{@number}"
  end

  def refuel(car)
    progress = create_progress(car)
    (car.gas_limit - car.gas_level).times do
      car.gas_level += 1
      progress.increment
      sleep 0.01
    end
    print("\n")
  end

  def create_progress(car)
    ProgressBar.create(
      title: "Car##{number} at Column##{@number}: #{car.gas_level} / #{car.gas_limit}",
      starting_at: car.gas_level,
      total: car.gas_limit
    )
  end
end

class Car
  attr_accessor :number, :gas_level, :gas_limit, :fueling

  def initialize(number:)
    @number = number
    @gas_level = rand(1..10)
    @gas_limit = rand(4..6) * 10
    @fueling = false
    p "Car #{@number}, level: #{gas_level}, limit: #{gas_limit}"
  end
end

station = GasStation.new
threads = []

station.columns.each do |column|
  threads << Thread.new(column) do |column|
    station.cars.each do |car|
      print("\r")
      print("\n")
      next if car.fueling
      car.fueling = true
      print(column.refuel(car))
    end
  end
end

threads.each(&:join)
