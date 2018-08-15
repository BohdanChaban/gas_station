require './gas_station'

station = GasStation.new
threads = []

station.columns.each do |column|
  threads << Thread.new(column) do |thread_column|
    station.cars.each do |car|
      print("\r")
      print("\n")
      next if car.fueling
      car.fueling = true
      print(thread_column.refuel(car))
    end
  end
end

threads.each(&:join)
