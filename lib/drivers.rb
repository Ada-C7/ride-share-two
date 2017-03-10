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

      ## Raise error here (rescue in read_csv)
    end

    def self.read_csv
      @@drivers = []
      if @@drivers.empty?
        CSV.foreach("support/drivers.csv", {:headers => true}) do |line|
          @@drivers << self.new({id: line[0].to_i, name: line[1].to_s, vin: line[2].to_s})
        end
      end
      @@drivers
    end


    def self.all
      read_csv
    end

    # def find_trips
    #   Trip.find_driver_trips(@id)
    #
    #   trips = []
    #
    #   # return all trip_ID of the driver in an array
    #   #
    # end
    # Find driver_trips(from trips)
    #
    # end

    # def avg_ratings(id)
    #   #Ratings are in trips
    #   ratings = []
    #   drivers.each do |driver|
    #     if driver[:id] == id
    #     end
    # Calculate Average Rating(driver_id)
    # take all the ratings from RideShare::Trips.find_driver_trips
    #push ratings into an array and find average

    # Find a specific driver(driver_id)
    # return the instance of that driver (hash of details)

    def self.find(id)
      driver_details = nil
      all.each do |driver|
        if driver.id == id
          driver_details = driver
        end
      end
      driver_details
    end

  end
end
