# require_relative 'driver'
require 'csv'

module RideShare
  class Driver

    attr_reader :id, :name, :vin

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @vin = args[:vin]
    end

    def trips
      return RideShare::Trip.all_drivers(id)
    end

    def rating
      ratings = trips.map{ |t| t.rating.to_f }
      return (ratings.reduce(:+) / ratings.length).round(1)
    end

    def self.all
      driver_array = []
      CSV.open("support/drivers.csv", 'r').each do |driver|
        new_driver = RideShare::Driver.new({
          :id => driver[0],
          :name => driver[1],
          :vin => driver[2]
          })
          driver_array << new_driver
        end
        driver_array.shift
        return driver_array
    end

      def self.find(id)
        raise InvalidIdError.new "This is not a valid ID given: #{id}" if !(id.match(/^\d+$/))
        drivers = RideShare::Driver.all
        drivers.each do |driver|
          return driver if driver.id == id
        end
      end

  end
end
