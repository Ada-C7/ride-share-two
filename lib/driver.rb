require 'csv'
require 'pry'
require_relative '../lib/trips'

module RideShare
  class Driver
    attr_reader :driver_id, :name, :vin

    def initialize(driver)
      @driver_id = driver[:driver_id]
      @name = driver[:name]
      @vin = driver[:vin]
      @trips = []

      raise ArgumentError.new("Invalid VIN") if vin.length != 17
    end

    def self.all
      @all_drivers = []

      CSV.foreach("./support/drivers.csv", {:headers => true}) do |line|
        @all_drivers << self.new({driver_id:line[0].to_i, name:line[1].to_s, vin:line[2].to_s})
      end
      return @all_drivers
    end

    def self.find(driver_id)
      drivers = RideShare::Driver.all

      drivers.each do |driver|
        if driver.driver_id == driver_id
          return driver
        end
      end
    end

    def get_trips
      return RideShare::Trips.get_trips_driver_id(@driver_id)
    end
  end # end of Driver
end # end of module
