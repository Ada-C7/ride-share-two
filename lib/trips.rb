require 'csv'
require 'pry'
require_relative 'driver'

module Rideshare

  class Trips

    attr_reader :trips, :trip_id, :driver_id, :rider_id, :rating, :date

    def initialize trip_id, driver_id, rider_id, date, rating
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating

    end

    def self.all
      @trips = []

      CSV.open("/Users/adai/Documents/ada/projects/ride-share-two/support/trips.csv", {:headers => true}).each do |line|
        trip = Rideshare::Trips.new(line[0].to_i, line[1].to_i, line[2].to_i, line[3], line[4].to_i)
        @trips << trip
      end
      return @trips

    end
  end
end
