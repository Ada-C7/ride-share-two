require_relative 'rideshare'

module RideShare
  class Driver
    attr_accessor :driver_id, :name, :vin
    def initialize(driver_id, name, vin) #Instantiated Driver class with ID, name and vehicle identification number
      raise ArgumentError.new("The Driver ID is Invalid") if driver_id.class != Fixnum
      raise ArgumentError.new("The name is Invalid") if name.class != String
      raise InvalidVinError.new("The VIN number is invalid") if vin.class != String || vin.length != 17 || !vin.upcase.match(/^[0-9A-Z]+$/)

      @driver_id = driver_id
      @name = name
      @vin = vin #check vehicle identification number should be a specific length else raise InvalidVinError
    end

    def trips
      #Call trips_driver method on class Trip with argument of driver_id to return an array of trips that this driver has completed
      RideShare::Trip.trips_by_driver(driver_id)

    end

    def average_rating
      #Collect all trip instances and then loop through each to find total rating and divide it by length of trip instances to get average
      all_ratings = trips.map { |trip| trip.rating }
      (all_ratings.reduce(:+).to_f / all_ratings.length).round(2)

    end


    def self.all
      #Use CSV.read method passing file name as argument to retrieve all drivers
      CSV.read("support/drivers.csv", headers:true).map do |line|
        RideShare::Driver.new(line[0].to_i, line[1], line[2])
      end
    end

    def self.find(driver_id)
      #check if driver_id is included in the list of drivers found in all method above
      self.all.find{ |driver|driver.driver_id == driver_id }
    end
  end
end
