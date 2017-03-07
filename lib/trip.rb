require 'csv'
#require_relative 'rider'
#require_relative 'driver'

module RideShare
  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating

    #maybe make rider_id...etc into a hash
    def initialize(trip_hash)
      @id = trip_hash[:id]
      @driver_id = trip_hash[:driver_id]
      @rider_id = trip_hash[:rider_id]
      @date = trip_hash[:date]
      #must be within an acceptable range
      @rating
    end

    def self.all
      # reads drivers.csv file
    end

    def self.find
      # finds an instance of the drivers.csv file
    end

    def self.find_many_driver(driver_id)
    end

    def self.find_many_rider(rider_id)
    end

    def driver
    end

    def rider
    end
  end
end
