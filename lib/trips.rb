require 'csv'


module Rideshare

  class Trips
    attr_accessor :trip_id, :driver_id, :rider_id, :rating, :date

    def initialize trip_id, driver_id, rider_id, date, rating
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = (1..5).include?(rating.to_i) ? rating : nil
    end

    def valid_rating?
      @rating == nil ? false : true
    end

    def self.all
      @all_trips = []

      CSV.open("/Users/adai/Documents/ada/projects/ride-share-two/support/trips.csv", {:headers => true}).each do |line|
        trip = Rideshare::Trips.new(line[0].to_i, line[1].to_i, line[2].to_i, line[3], line[4].to_i)
        @all_trips << trip
      end
    end

    def self.all_trips
      return @all_trips #this is an array that contains trips objects
    end

    def trip_driver #instance variable, should return Driver instance
      Rideshare::Driver.find(@driver_id)
    end

    def trip_rider
      Rideshare::Rider.find(@rider_id)
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
