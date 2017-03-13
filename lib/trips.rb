require 'csv'


module Rideshare

  class Trips
    attr_accessor :trip_id, :driver_id, :rider_id, :rating, :date, :cost, :duration

    def initialize trip_id, driver_id, rider_id, date, rating, cost, duration
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = (1..5).include?(rating.to_i) ? rating : nil
      @cost = cost
      @duration = duration
    end

    def valid_rating?
      @rating == nil ? false : true
    end

    def self.all
      @all_trips = []

      CSV.open("support/trips2.csv", {:headers => true}).each do |line|
        trip = Rideshare::Trips.new(line[0].to_i, line[1].to_i, line[2].to_i, line[3], line[4].to_i, line[5].to_i, line[6].to_i)
        @all_trips << trip
      end
    end

    def self.all_trips
      return @all_trips #this is an array that contains trips objects
    end

    def trip_driver #returns the driver of the trip
      Rideshare::Driver.find(@driver_id)
    end

    def trip_rider #returns the rider of the trip
      Rideshare::Rider.find(@rider_id)
    end

    def cost #returns cost of trip in dollars
      return @cost
    end

    def duration #returns duration of trip
      return @duration
    end

    def self.all_by_driver id

      Rideshare::Driver.find(id).trips
      # driver.trips
      # call find method from this class...some type of dependency injection

      # trips = Rideshare::Trips.all_trips
      # trips.delete_if { |trip| trip.driver_id != id}
      # return trips

    end

    def self.all_by_rider id
      Rideshare::Rider.find(id).trips

    end

  end
end
