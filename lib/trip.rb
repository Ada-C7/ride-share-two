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

    def self.all_trips
      CSV.read("./support/trips.csv").drop(1).map { |line| self.new(line[0].to_s,line[1].to_s,line[2].to_s,line[3].to_s,line[4].to_i) }
    end

    def self.find_trip(trip_id)
      self.all_trips.find { |trip| trip.trip_id == trip_id.to_s } #only expecting one so should be returned
    end

    # retrieve the associated driver instance through the driver ID
    def find_driver
      Ride_share_two::Driver.all_drivers.find { |driver| driver.driver_id == driver_id }
    end
    #retrieve the associated rider instance through the rider ID
    def find_rider
      Ride_share_two::Rider.all_riders.find { |rider| rider.rider_id == rider_id }
    end
    #find all trip instances for a given driver ID
    def self.find_trips_for_drivers(driver_id)
      self.all_trips.find_all { |trip| trip.driver_id == driver_id }
    end
    #find all trip instances for a given rider ID
    def self.find_trips_for_rider(rider_id)
      self.all_trips.find_all { |trip| trip.rider_id == rider_id }
    end

  end
end
