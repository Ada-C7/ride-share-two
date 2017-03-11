require 'csv'
module RideShare
  class Trip
    attr_accessor :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(trip_id, driver_id, rider_id, date, rating)
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
    end

    def self.all
      trips = []
      CSV.open("./support/trips.csv", "r").each do |line|
        trips << self.new(line[0], line[1], line[2], line[3], line[4])
      end
      return trips
    end

    def self.find_many(id)
      driver_trips = []
      trips = self.all

      trips.each do |trip|
        if trip.driver_id == id
          driver_trips << trip
        end
      end
      return driver_trips
      puts "yo ho yo ho a pirate's life for me"
    end

  end
end
