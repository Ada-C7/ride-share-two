require 'csv'
require 'pry'

module RideShare
  class Driver
    attr_reader :driver_id, :name, :vin

    # vin cannot be longer or shorter than 17 characters
    def initialize(driver_hash)
      raise ArgumentError.new "Vin must be 17 characters" if driver_hash[:vin].length != 17

      @driver_id = driver_hash[:driver_id]
      @name = driver_hash[:name]
      @vin = driver_hash[:vin]
    end

    def self.all
      drivers_array = []
      # # reads drivers.csv file
      CSV.read("support/drivers.csv", {:headers => true, :header_converters => :symbol, :converters => :all}).each do |line|
        drivers_array << RideShare::Driver.new(line)
      end
      return drivers_array

    end

    def self.find(driver_id)
      save_driver = nil

      find_drivers = RideShare::Driver.all
      find_drivers.each do |driver|
        if driver.driver_id == driver_id
          save_driver = driver
        end
      end

      raise ArgumentError.new "Warning: Driver #{driver_id} does not exist." if save_driver == nil

      return save_driver

    end

    def trips
      # returns list of driver trips that only that driver has been on
      RideShare::Trip.find_many_drivers(@driver_id)

      # returns average rating for the driver based on all the trips they have been on
    end

    def average_rating
      # Get ratings from trip instance
      driver_ratings = trips.map { |trips| trips.rating.to_f  }
      avg_rating = driver_ratings.inject(:+) / driver_ratings.length

      avg_rating
      # add all ratings together
      # divide by number of trip instances
    end

  end
end

#find_id = RideShare::Driver.all
#puts "#{find_id}"
#driver_trip = RideShare::Driver.find(4)
#puts "#{driver_trip}"
