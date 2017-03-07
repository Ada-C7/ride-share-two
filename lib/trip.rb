require_relative 'driver'
require_relative 'rider'
require 'csv'
module RideShare
  class Trip
    attr_reader :trip_id, :rider_id, :driver_id, :date, :rating
    def initialize(hash)
      raise ArgumentError.new("Parameter must be hash only") if hash.class != Hash
      @trip_id = hash[:trip_id]
      @rider_id = hash[:rider_id]
      @driver_id = hash[:driver_id]
      @date = hash[:date]
      raise ArgumentError.new("Raiting should be 1 - 5 only") if !((1..5).include? hash[:rating])
      @rating = hash[:rating]
    end

    def driver
      #retrieve the associated driver instance through the driver ID
      return RideShare::Driver.find(@driver_id)
    end

    def rider
      #retrieve the associated driver instance through the driver ID
      return RideShare::Rider.find(@rider_id)
    end

    # find all trip instances for a given driver ID
    def self.all_trips_by_driver(driver_id)
      all_driver_trips = []
      csv = CSV.read("support/trips.csv", 'r')
      csv.each do |line|
        #to avoid putting first line from CSV file that contains column name:
        next if line[0] == "trip_id"
        if driver_id == line[1].to_i
          hash = {trip_id: line[0].to_i, driver_id: line[1].to_i, rider_id: line[2].to_i, date: line[3], rating: line[4].to_i}
          all_driver_trips << Trip.new(hash)
        end
      end
      all_driver_trips
    end

    # find all trip instances for a given rider ID
    def self.all_trips_by_rider(rider_id)
      all_rider_trips = []
      csv = CSV.read("support/trips.csv", 'r')
      csv.each do |line|
        #to avoid putting first line from CSV file that contains column name:
        next if line[0] == "trip_id"
        if rider_id == line[2].to_i
          hash = {trip_id: line[0].to_i, driver_id: line[1].to_i, rider_id: line[2].to_i, date: line[3], rating: line[4].to_i}
          all_rider_trips << Trip.new(hash)
        end
      end
      if all_rider_trips.empty?
        puts "Could not find  rider id (#{rider_id}) "
      end
      return all_rider_trips
    end

    # retrieve all trips from the CSV file
    def self.all_trips
    end

  end
end

# trip_hash = {trip_id: 123, rider_id: 2, driver_id: 34, date: "03/06/2017", rating: 4}
#
# trip = RideShare::Trip.new(trip_hash)
# # puts trip.driver.driver_id

all_trips =  RideShare::Trip.all_trips_by_rider(1)
puts all_trips
