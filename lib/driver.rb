require_relative 'trip'
require 'csv'

module RideShare

  class Driver
    attr_reader :id, :name, :vin

    def self.all
      driver_array = []
      CSV.open("support/drivers.csv", 'r').each do |driver|
        new_driver = Driver.new({
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
      drivers = Driver.all
      drivers.each do |driver|
        return driver if driver.id == id
      end
    end

    def initialize(driver)
      @id = driver[:id]
      @name = driver[:name]
      @vin = driver[:vin]
    end

    def trips
    end

    def rating
    end

  end

end
