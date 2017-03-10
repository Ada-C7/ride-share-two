
require "csv"
require_relative "vin_error"
#require_relative "invalid_data"


module RideShare
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
      # retrieve all drivers from CSV files
      # returns list of all drivers instances

      all_drivers_array = []
      CSV.read("support/drivers.csv", {:headers => true, :header_converters => :symbol}).each do |line|
        all_drivers_array << RideShare::Driver.new(line)
      end
      return all_drivers_array
    end

    def self.find(driver_id)
      # find a specific driver using numeric ID
      # returns a driver instance
      driver = all.detect {|driver| (driver.id == driver_id) }
      # (driver != nil) ? (return driver) : (raise InvalidData.new "invalid driver id")
    end

    def self.print_all
      all.each do |driver|
        puts "id: #{driver.id}, name: #{driver.name}, vin: #{driver.vin}"
      end
    end

    def retrieve_trips
      # retrieve the list of trip instances for a cpecific driver
      RideShare::Trip.find_driver_trips(@id)


    end

    def calculate_avg_rating
      #access rating from trips instances
      #calculate sum
      #returns avaerage rating
      trips_rating = RideShare::Trip.find_driver_trips(@id).map {|trip| trip.rating.to_f}
      rating_sum = trips_rating.inject {|sum, num| sum + num }
      trips_rating.length == 0 ? 0 : ((rating_sum / trips_rating.length)).round(2)
    end


  end
end

# Driver.print_all
