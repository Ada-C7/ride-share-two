# HAS
# @id, @rider_id, @driver_id, @date, @rating
# ID, rider ID, a driver ID, date, rating
# Each rating should be within an acceptable range (1-5)
#
# INSTANCE METHODS
# driver: retrieve the associated driver instance through the driver ID
# rider: retrieve the associated rider instance through the rider ID
#
# CLASS METHODS
# all_by_driver: find all trip instances for a given driver ID
# all_by_rider: find all trip instances for a given rider ID
# all: retrieve all trips from the CSV file
require 'csv'
require 'date'

module RideShare
  class Trip
    attr_reader :id, :rider_id, :driver_id, :date, :rating

    def initialize(params)
      @id = params[:id]
      @rider_id = params[:rider_id]
      @driver_id = params[:driver_id]
      @date = params[:date]
      @rating = params[:rating]
    end

    def self.all
      @@all ||= CSV.read("support/trips.csv", headers:true).map do |line|
        RideShare::Trip.new(
          id: line[0].to_i,
          driver_id: line[1].to_i,
          rider_id: line[2].to_i,
          date: Date.parse(line[3]),
          rating: line[4].to_i
        )
      end

    end

    def self.find(target_id)
      all.find { |trip| trip.id == target_id }
    end

    def self.by_driver(target_driver_id)
      all.select { |trip| trip.driver_id == target_driver_id }
    end

    def self.by_rider(target_rider_id)
      all.select { |trip| trip.rider_id == target_rider_id }
    end

  end
end
