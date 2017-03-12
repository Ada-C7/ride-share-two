require 'csv'
require 'pry'

module RideShare
  class Driver
    attr_reader :driver_id, :name, :vin

    def initialize(driver_hash)
      raise ArgumentError.new "Driver id must be an integer" if driver_hash[:driver_id].class != Integer
      raise ArgumentError.new "Driver name must be a string" if driver_hash[:name].class != String
      raise ArgumentError.new "Vin must be 17 characters" if driver_hash[:vin].length != 17

      @driver_id = driver_hash[:driver_id]
      @name = driver_hash[:name]
      @vin = driver_hash[:vin]
    end

    def self.all
      drivers_array = []

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
      RideShare::Trip.find_many_drivers(@driver_id)
    end

    def average_rating
      driver_ratings = trips.map { |trips| trips.rating.to_f  }
      avg_rating = driver_ratings.inject(:+) / driver_ratings.length

      avg_rating
    end

  end
end
