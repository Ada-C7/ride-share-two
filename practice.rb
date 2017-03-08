require 'csv'
# require_relative './lib/driver.rb'
# def list_of_drivers
#   drivers = []
#   CSV.open("./support/drivers.csv", {:headers => true}).each do |line|
#     drivers << RideShare::Driver.new(id: line[0].to_i, name: line[1].to_s, vehicle_id: line[2].to_s)
#   end
#   return drivers
# end
#
# puts list_of_drivers

def all
  trips = []
  CSV.foreach("support/trips.csv", {:headers => true, header_converters: :symbol, converters: :all}) do |line|
    trips << RideShare::Trip.new(line)
  end
  return trips
end

def self.find_for_driver(id)
  trips = []

  all.each do |trip|
    if trip.driver_id == id
      trips << trip
    end
  end

  raise InvalidDriver.new("that driver does not exist") if trips.empty?
  return trips
end
