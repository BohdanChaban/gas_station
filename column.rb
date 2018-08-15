require 'ruby-progressbar'

class Column
  attr_accessor :number, :color

  def initialize(number)
    @number = number
    @color = 33 + number
  end

  def refuel(car)
    progress = create_progress(car)
    (car.gas_limit - car.gas_level).times do
      car.gas_level += 1
      progress.increment
      sleep 0.1
    end
    print("\n")
  end

  def create_progress(car)
    ProgressBar.create(
      title: "Car##{car.number}(#{car.gas_level}/#{car.gas_limit}L) at Column##{@number}",
      format: "%t: |\e[0;#{color}m%B\e[0m|",
      starting_at: car.gas_level,
      total: car.gas_limit
    )
  end
end
