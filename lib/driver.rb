require 'csv'
#csv: CSV.foreach("../support/trips.csv", {:headers => true}) do |row|
module RideShare
  class Driver
    attr_accessor :driver_id, :name, :vin

    def initialize(driver_id, name, vin)
      raise ArgumentError.new ("Vin must be 17 characters") if vin.length != 17
      @driver_id = driver_id
      @name = name
      @vin = vin
    end

    # retrieve the list of trip instances that only this driver has taken
    def driver_trip_instances
      driver_trips = RideShare::Trip.driver_trip_instances(@driver_id)
      return driver_trips
    end

    # retrieve an average rating for that driver based on all trips taken
    def average_rating
      # avg_rating = 0
      rating_array = []
      driver_avg_rating = RideShare::Trip.driver_trip_instances(@driver_id)
      driver_avg_rating.each do |object|
        rating_array << object.rating
      end
      rating_array_lenth = rating_array.length
      rating_array_sum = rating_array.inject(:+)
      avg_rating = rating_array_sum / rating_array_lenth
      return avg_rating
    end
    #TODO can come back to this and make so that it's a float instead of an integer
    #now that I have the driver trip instances, I need to sum the ratings
    # driver_avg_rating.

    # retrieve all drivers from the CSV file
    def self.all_driver_info
      all_drivers_array = []
      CSV.read('support/drivers.csv').each do |object|
        driver_id = object[0].to_i
        name = object[1].to_s
        vin = object[2].to_s
        a_driver = RideShare::Driver.new(driver_id, name, vin)
        all_drivers_array << a_driver
      end
      return all_drivers_array
    end

    # find a specific driver using their numeric ID
    def self.find_driver(driver_id)
      drivers = RideShare::Driver.all_driver_info
      drivers.each do |object|
        if object.driver_id == driver_id
          return object
        end
      end
      raise ArgumentError.new("Driver #{driver_id} does not exist")
    end

  end
end
