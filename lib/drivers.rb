require 'csv'

module RideShare
  class Drivers
    attr_reader :id, :name, :vin
    # @@drivers
    # Initialize Drivers
    # set ID, Name, License and VIN as attr_reader
    # import csv file
    # set individual driver instances as details in a hash

    def initialize(id, name, vin)
      @id = id
      @name = name
      @vin = vin
    end

    def self.read_csv

      @@drivers = CSV.read("support/riders.csv")[1..-1].map do |array_of_details|
        Rider.new(array_of_details[0].to_i, array_of_details[1].to_s, array_of_details[2].to_s)
      end

      @@drivers = CSV.read("support/drivers.csv")[1..-1].map! do |array_of_details|
        {
          id: array_of_details[0].to_i,
          name: array_of_details[1].to_s,
          vin: array_of_details[2].to_s
        }
      end
    end

    def self.all
      read_csv
    end

    # def find_trips(id)
    #Trips.find_driver_trips(id)
    #
    #   trips = []
    #
    #   # return all trip_ID of the driver in an array
    #   #
    # end
    # Find driver_trips(from trips)

    # end
    #
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
      @@drivers.each do |driver|
        if driver[:id] == id
          driver_details = driver
        end
      end
      driver_details
    end
  end
end
