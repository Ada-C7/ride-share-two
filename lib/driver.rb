require 'csv'

module RideShare
  class Driver
    attr_reader :driver_id, :name, :vin
    def initialize(driver_id, name, vin)
      raise ArgumentError.new("Invalid VIN length") if vin.length != 17

      @driver_id = driver_id
      @name = name
      @vin = vin
      @trips = []
    end


    def self.all
      all_drivers = []

      csv_contents = CSV.read("./support/drivers.csv")
      csv_contents.shift
      csv_contents.each do |each_driver|
          driver_id = each_driver[0].to_i
          name = each_driver[1].to_s
          vin = each_driver[2].to_s

          driver = RideShare::Driver.new(driver_id, name, vin)
          all_drivers << driver
      end
        return all_drivers
    end

    def get_trips
      return @trips
    end

    def add_trip(trip)
      @trips << trip
    end

    def self.find(driver_id)
      drivers = RideShare::Driver.all

      drivers.each do |driver|
        if driver.driver_id == driver_id
          return driver
        end
      end
    end

  end # end of Driver
end # end of module
