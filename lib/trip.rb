require 'csv'

module RideShare
  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_hash)
      raise ArgumentError.new("Invalid argument type: must be a hash object") if trip_hash.class != Hash

      [:id, :rider_id, :driver_id, :date, :rating].each { |sym_key|
        raise ArgumentError.new("Invalid argument type: must have #{sym_key} value") if !trip_hash.keys.include?(sym_key)
      }
      # Each rating should be within an acceptable range (1-5)
      raise ArgumentError.new("Invalid argument type: rating(Integer) value must be in the range (1-5)") if trip_hash[:rating] < 1 || trip_hash[:rating] > 5

      @id = trip_hash[:id]
      @rider_id = trip_hash[:rider_id]
      @driver_id = trip_hash[:driver_id]
      @date = trip_hash[:date]
      @rating = trip_hash[:rating]
    end

    # Retrieve the associated driver instance through the driver ID
    def find_driver
      return Driver.find(driver_id)
    end

    # Retrieve the associated rider instance through the rider ID
    def find_rider
      return Rider.find(rider_id)
    end

    # Find all trip instances for a given driver ID
    def self.all
      all_trips_array= []
      CSV.foreach("support/trips.csv", {:headers => true}) do |line|
          all_trips_array << Trip.new( id: line[0].to_i, driver_id: line[1].to_i, rider_id: line[2].to_i, date: line[3], rating: line[4].to_f )
      end
      return all_trips_array
    end

    # Find all trip instances for a given rider ID
    def self.trips_by_driver(driver_id)
      all_trips_array = Trip.all
      return all_trips_array.reject { |trip| trip.driver_id != driver_id }
    end

    # Retrieve all trips from the CSV file
    def self.trips_by_rider(rider_id)
      all_trips_array = Trip.all
      return all_trips_array.reject { |trip| trip.rider_id != rider_id }
    end
  end
end
