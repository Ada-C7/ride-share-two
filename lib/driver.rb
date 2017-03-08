require 'csv'
module RideShare
  class Driver
    attr_accessor :driver_id, :name, :vin
    def initialize(driver_id, name, vin)
      @driver_id = driver_id
      @name = name
      @vin = vin
    end

    def trips
      Trip.find_many(@driver_id)
    end

    def self.all
      drivers = []
      CSV.open("./support/drivers.csv", "r").each do |line|
        drivers << self.new(line[0].to_s, line[1].to_s, line[2].to_s)
      end
      return drivers
    end

    def self.find(id)
      drivers = self.all
      drivers.each do |driver|
        if driver.driver_id == id
          return driver
        end
      end
      raise ArgumentError.new("Driver not found")
    end
  end
end
