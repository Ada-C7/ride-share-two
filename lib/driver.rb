require 'csv'
require 'pry'

module RideShare
  class Driver
    attr_reader :driver_id, :name, :vin

    def initialize(drivers)

      @driver_id = drivers[:driver_id]
      @name = drivers[:name]
      @vin = drivers[:vin]

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

    # def get_trips
    #   return @trips
    # end
    #
    # def add_trip(trip)
    #   @trips << trip
    # end
    #


  end # end of Driver
end # end of module
