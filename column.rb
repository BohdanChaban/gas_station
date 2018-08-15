require 'ruby-progressbar'

class Column
  attr_accessor :number

  def initialize(number)
    @number = number
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
      title: "Car##{car.number}(#{car.gas_level}/#{car.gas_limit}L) at Column##{@number}",
      starting_at: car.gas_level,
      total: car.gas_limit
    )
  end
end
