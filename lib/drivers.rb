require 'csv'

module RideShare
  class Drivers
    attr_reader :id, :name, :VIN
    @@drivers
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
      @@drivers = CSV.read("support/drivers.csv")[1..-1].map! do |array_of_details|
        {
          id: array_of_details[0],
          name: array_of_details[1],
          vin: array_of_details[2]
        }
      end
    end

    def self.all
      @@drivers
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
      # @@drivers.each do |driver|
      #   if driver[:id] == id
      #     driver_details = driver
      #   end
      # end
      # ## TW: Should I return driver instead of puts?
      # p driver_object
    end
  end
end
# end

RideShare::Drivers.read_csv
RideShare::Drivers.find(99)
