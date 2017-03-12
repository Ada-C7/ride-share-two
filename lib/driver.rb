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

    def rating
      ratings = []
      # this gives the array of trips for the driver
      # undefined method 'find' when called 'self.find'
      # -- changing to 'Driver.find' seemed to fix
      rate_trips = Driver.find(@driver_id).trips
      # trying to get just the rating from the trip into an array
      rate_trips.each do |trip|
        ratings << trip.rating
      end
      rated = (ratings.inject(0) {|sum, num| sum + num } / ratings.length).round(1)
      return rated


      # # this won't work because |driver| doesn't mean anything and "trip.driver_id" isn't calling on any instance of trip because block hasn't been set up that way
      #
      # ratings_array = []
      # rate_trips_array = Trip.all
      #
      # rate_trips_array.each do |driver|
      #   if trip.driver_id == driver
      #     ratings_array << trip.rating
      #   end
      # end
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
