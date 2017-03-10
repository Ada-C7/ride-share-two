require 'csv'

module Ride_share_two
  class Driver
    attr_reader :driver_id, :driver_name, :vin, :drivers
    def initialize(driver_id, driver_name, vin)
      raise ArgumentError.new("vin.length must be == 17") if vin.length != 17
      raise ArgumentError.new("driver_id must be Integer") if driver_id.is_a?(Integer) #&& driver_id > 0
      @driver_id = driver_id
      @driver_name = driver_name
      @vin = vin
      @drivers = []
    end
    #retrieve all drivers from the CSV file
    def self.all_drivers
      @drivers = []
      CSV.read("./support/drivers.csv").drop(1).each do |line|
        @drivers << self.new(line[0].to_s,line[1].to_s,line[2].to_s)
      end
      return @drivers
    end
    #find a specific driver using their numeric ID
    def self.find_driver(id)
      raise ArgumentError.new("id must be Integer") if !id.is_a?(Integer)
      self.all_drivers.each do |driver|
        if driver.driver_id == id.to_s
          return driver.driver_name
        end
      end
    end

    def find_trips_for_driver
      trips_for_driver =[]
      Ride_share_two::Trip.all_trips.each do |trip|
        if trip.driver_id == driver_id
          trips_for_driver <<  trip
        end
      end
      return trips_for_driver
    end

    def average_driver_rating
      total = 0
      find_trips_for_driver.each do |trip|
        total += trip.rating
      end
      return total / find_trips_for_driver.length
    end
  end
end
