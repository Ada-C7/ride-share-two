require 'csv'

module Ride_share_two
  class Driver
    attr_reader :driver_id, :driver_name, :vin, :drivers
    def initialize(driver_id, driver_name, vin)
      raise ArgumentError.new("vin.length must be == 17") if vin.length != 17
      raise ArgumentError.new("driver_id must be Integer") if driver_id.is_a?(Integer) #edge cases
      @driver_id = driver_id
      @driver_name = driver_name
      @vin = vin
      @drivers = []
    end
    #retrieve all drivers from the CSV file
    def self.all_drivers
      CSV.read("./support/drivers.csv").drop(1).map { |line| self.new(line[0].to_s,line[1].to_s,line[2].to_s) }
    end

    #find a specific driver using their numeric ID
    def self.find_driver(id)
      raise ArgumentError.new("id must be Integer") if !id.is_a?(Integer)
      self.all_drivers.find { |driver| driver.driver_id == id.to_s }.driver_name
    end

    def find_trips_for_driver
      Ride_share_two::Trip.all_trips.find_all { |trip| trip.driver_id == driver_id }
    end

    def average_driver_rating
      rating_array = find_trips_for_driver.map { |trip| trip.rating }
      rating_array.sum / rating_array.length
    end

  end
end
