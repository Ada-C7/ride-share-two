require 'csv'
require_relative 'errors'

module RideShare
  class Driver
    attr_reader :id, :name, :vin

    def initialize(driver_details)
      @id = driver_details[:id]
      @name = driver_details[:name]
      @vin = driver_details[:vin]
      # if @vin.length != 17
      #   #don't create an entry
      # end
      # raise VinLengthError.new("Length of Vin is #{@vin.length}, not 17-digits") unless @vin.length = 17

      ## Raise error here (rescue in readCSV)
    end

    def self.readCSV
      @@drivers = []
      if @@drivers.empty?
        CSV.foreach("support/drivers.csv", {:headers => true}) do |line|
          @@drivers << self.new({id: line[0].to_i, name: line[1].to_s, vin: line[2].to_s})
        end
      end
      @@drivers
    end

    def self.getAll
      readCSV
    end

    def self.find(id)
      driver_details = nil
      getAll.each do |driver|
        if driver.id == id
          driver_details = driver
        end
      end
      driver_details
    end

    def findTrips
      Trip.getTripsByDriver(id)
    end

    def avgRating
      avg_rating = nil
      driver_ratings = []
      driver_trips = Trip.getTripsByDriver(id)
      driver_trips.each do |trip|
        driver_ratings << trip.rating
      end
      avg_rating = (driver_ratings.inject {|sum, element| sum + element} / driver_ratings.size).round(2)
    end
  end
end
