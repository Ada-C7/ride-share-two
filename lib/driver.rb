require 'csv'
require_relative 'invalid_vin_error'

module RideShare
  class Driver
    def initialize #Instantiated Driver class with ID, name and vehicle identification number
      @id = driver_id
      @name = name
      @vin = vin #check vehicle identification number should be a specific length else raise InvalidVinError
    end

    def trips
      #Call trips_driver method on class Trip with argument of driver_id to return an array of trips that this driver has completed
    end

    def average_rating
      #Collect all trip instances and then loop through each to find total rating and divide it by length of trip instances to get average
    end


    def self.all
      #Use CSV.read method passing file name as argument to retrieve all drivers
    end

    def self.find
      #check if driver_id is included in the list of drivers found in all method above
    end



  end




end
