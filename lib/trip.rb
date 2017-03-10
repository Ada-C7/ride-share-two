require 'csv'

module Ride_share_two
  class Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating, :trips
    def initialize(trip_id, driver_id,rider_id, date, rating)
      raise ArgumentError.new("rating must include? [1,2,3,4,5]") if ![1,2,3,4,5].include?(rating)
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
    end
    # retrieve all riders from the CSV file
    def self.all_trips
      @trips = []
      CSV.read("./support/trips.csv").drop(1).each do |line|
        @trips << self.new(line[0].to_s,line[1].to_s,line[2].to_s,line[3].to_s,line[4].to_i)
        #creating new instance
      end
      return @trips
    end

    def self.find_trip(trip_id)
      self.all_trips.each do |trip|
        if trip.trip_id == trip_id.to_s
          return trip #only expecting one so should be returned
        end
      end
    end
    # retrieve the associated driver instance through the driver ID
    def find_driver
      Ride_share_two::Driver.all_drivers.each do |driver|
        if driver.driver_id == driver_id
          return driver
        end
      end
    end
    #retrieve the associated rider instance through the rider ID
    def find_rider
      Ride_share_two::Rider.all_riders.each do |rider|
        if rider.rider_id == rider_id
          return rider
        end
      end
    end
    #find all trip instances for a given driver ID
    def self.find_trips_for_drivers(driver_id)
      trips_for_driver =[]
      self.all_trips.each do |trip|
        if trip.driver_id == driver_id
          trips_for_driver <<  trip
        end
      end
      return trips_for_driver
    end
    #find all trip instances for a given rider ID
    def self.find_trips_for_rider(rider_id)
      trips_for_rider = []
      self.all_trips.each do |trip|
        if trip.rider_id == rider_id
          trips_for_rider << trip
        end
      end
      return trips_for_rider
    end

  end
end
