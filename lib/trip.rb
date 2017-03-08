require 'csv'
#require_relative 'rider'
#require_relative 'driver'

module RideShare
  class Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    #maybe make rider_id...etc into a hash
    def initialize(trip_hash)
      @trip_id = trip_hash[:trip_id]
      @driver_id = trip_hash[:driver_id]
      @rider_id = trip_hash[:rider_id]
      @date = trip_hash[:date]
      #must be within an acceptable range
      @rating = trip_hash[:rating]
    end

    def self.all
      trips = []

      CSV.read("support/trips.csv").each do |trip_row|
        all_trips = RideShare::Trip.new(
        trip_id: trip_row[0].to_i,
        driver_id: trip_row[1].to_i,
        rider_id: trip_row[2].to_i,
        date: trip_row[3],
        rating: trip_row[4].to_i
        )
        trips << all_trips
      end
      trips
    end

    def self.find(trip_id)
      save_trip = nil

      find_trip = RideShare::Trip.all
      find_trip.each do |trip|
        if trip.trip_id == trip_id
          save_trip = trip
        end
      end

      raise ArgumentError.new "Warning: Trip #{trip_id} does not exist." if save_trip == nil

      return save_trip
    end

    def self.find_many_driver(driver_id)
    end

    def self.find_many_rider(rider_id)
    end

    def driver
    end

    def rider
    end
  end
end
