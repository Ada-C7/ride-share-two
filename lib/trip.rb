require 'csv'

module RideShare
  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating, :cost, :duration

    def initialize(trip_hash)
      raise ArgumentError.new("Invalid argument type: must be a hash object") if trip_hash.class != Hash

      [:id, :rider_id, :driver_id, :date, :rating, :cost, :duration].each { |sym_key|
        raise ArgumentError.new("Invalid argument type: must have #{sym_key} value") if !trip_hash.keys.include?(sym_key)
      }

      @id = trip_hash[:id].to_i
      @rider_id = trip_hash[:rider_id].to_i
      @driver_id = trip_hash[:driver_id].to_i
      @date = trip_hash[:date].to_s

      @rating = trip_hash[:rating].to_i
      # Each rating should be within an acceptable range (1-5)
      raise ArgumentError.new("Invalid argument type: rating(Integer) value must be in the range (1-5)") if trip_hash[:rating] < 1 || trip_hash[:rating] > 5

      @cost = trip_hash[:cost].to_i
      # Each cost should be a positive amount in cents
      raise ArgumentError.new("Invalid argument type: cost(Integer) value must be at list $1.65 in cents") if trip_hash[:cost] < 165

      @duration = trip_hash[:duration].to_i
      # Each duration should be a positive amount in minutes
      raise ArgumentError.new("Invalid argument type: duration(Integer) value must be a positive amount in minutes") if trip_hash[:duration] < 0
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
        all_trips_array << RideShare::Trip.new( id: line[0].to_i, driver_id: line[1].to_i, rider_id: line[2].to_i, date: line[3], rating: line[4].to_i, cost: line[5].to_i, duration: line[6].to_i)
      end
      return all_trips_array
    end

    # Find all trip instances for a given rider ID
    def self.trips_by_driver(driver_id)
      raise ArgumentError.new ("Driver id must be a positive integer value") if ( driver_id.class != Integer || driver_id < 0 )
      all_trips_array = Trip.all
      if all_trips_array.any? { |trip| trip.driver_id == driver_id }
        return all_trips_array.select { |trip| trip.driver_id == driver_id }
      else
        return nil
      end
    end

    # Retrieve all trips from the CSV file
    def self.trips_by_rider(rider_id)
      raise ArgumentError.new ("Rider id must be a positive integer value") if ( rider_id.class != Integer || rider_id < 0 )
      all_trips_array = Trip.all
      if all_trips_array.any? { |trip| trip.rider_id == rider_id }
        return all_trips_array.select { |trip| trip.rider_id == rider_id }
      else
        return nil
      end
    end
  end
end
