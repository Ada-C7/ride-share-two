require 'csv'
require 'pry'
require_relative 'trips'


module Rideshare

  class Driver
    attr_reader :id, :name, :vin, :drivers

    def initialize id, name, vin
      @id = id
      @name = name
      @vin = vin
    end

    def trips driver_id
      driver_trips = []
      Rideshare::Trips.trips.each do |trip|
        if driver_id == trip[1]
          driver_trips << trip
        end
      end
      return driver_trips

    end

    def self.all
      @drivers = []

      CSV.open("/Users/adai/Documents/ada/projects/ride-share-two/support/drivers.csv", {:headers => true}).each do |line|
        driver = Rideshare::Driver.new(line[0].to_i, line[1], line[2])
        @drivers << driver

      end
      return @drivers

    end


    def find driver_id
    end

    def rating driver_id
    end


  end
end
