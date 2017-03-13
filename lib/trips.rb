require 'csv'

module RideShare
  class Trips
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(trips)

      @trip_id = trips[:trip_id]
      @driver_id = trips[:driver_id]
      @rider_id = trips[:rider_id]
      @date = trips[:date]
      @rating = trips[:rating]

    raise ArgumentError.new("Invalid Rating") if trips[:rating] > 5 || trips[:rating] < 1
    end

    def self.all
      @all_trips = []

      CSV.foreach("./support/trips.csv", {:headers => true}) do |line|
        @all_trips << self.new({trip_id:line[0].to_i, driver_id:line[1].to_i, rider_id:line[2].to_i, date:line[3].to_s, rating:line[4].to_i})
      end
      return @all_trips
    end

    def self.get_trips_driver_id(id)
      RideShare::Trips.all.select{ |trip| trip.driver_id == id }
    end

    def self.get_trips_rider_id(id)
      RideShare::Trips.all.select{ |trip| trip.rider_id == id }
    end
  end # end of Trip
end # end of module
