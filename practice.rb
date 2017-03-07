require 'csv'
require_relative './lib/driver.rb'
def list_of_drivers
  drivers = []
  CSV.open("./support/drivers.csv", {:headers => true}).each do |line|
    drivers << RideShare::Driver.new(id: line[0].to_i, name: line[1].to_s, vehicle_id: line[2].to_s)
  end
  return drivers
end

puts list_of_drivers
