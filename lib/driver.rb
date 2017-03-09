
require "csv"
require_relative "vin_error"
require_relative "invalid_data"


module Ride_Share
class Driver

  attr_reader :id, :name, :vin

  def initialize(args_hash)
    #csv header: driver_id, name, vin
    @id = args_hash[:driver_id]
    @name = args_hash[:name]
    @vin = args_hash[:vin]
    raise InvalidVehicleNumber.new "invalid Vehilcle Number" if @vin.length !=17

  end

  def self.all
    all_drivers_array = []
    CSV.read("support/drivers.csv", {:headers => true, :header_converters => :symbol}).each do |line|
      all_drivers_array << Ride_Share::Driver.new(line)
    end
    return all_drivers_array
  end

  def self.find(driver_id)
    driver = all.detect {|driver| (driver.id == driver_id) }
    (driver != nil) ? (return driver) : (raise InvalidData.new "invalid driver id")
  end

  def self.print_all
    all.each do |driver|
      puts "id: #{driver.id}, name: #{driver.name}, vin: #{driver.vin}"
    end
  end

  def retrieve_trips
    Ride_Share::Trip.find_driver_trips(@id)


  end

  def calculate_avg_rating
    #access rating from trips instances
    #calculate sum
    #returns avaerage rating
    trips_rating = Ride_Share::Trip.find_driver_trips(@id).map {|trip| trip.rating.to_f}
    rating_sum = trips_rating.inject {|sum, num| sum + num }
    trips_rating.length == 0 ? 0 : ((rating_sum / trips_rating.length)).round(2)
  end


end # class
end # module

# Driver.print_all
