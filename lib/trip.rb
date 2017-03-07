require_relative 'driver'
require_relative 'rider'

module RideShare

  class Trip
  attr_reader

    # creates trips that have an ID, rider ID, driver ID, date, and rating
    def initialize(id, rider_id, driver_id, date, rating)
      @id = id
      @rider_id = rider_id
      @driver_id = driver_id
      @date = date
      @rating = rating
    end

    # verifies that rating is valid
    def valid_rating?
    end

    # retrieve the associated driver instance through the driver ID
    def trip_driver
    end

    # retrieve the associated rider instance through the rider ID
    def trip_rider
    end

    # find all trip instances for a given driver ID
    def self.all_trips
    end

    # find all trip instances for a given rider ID
    def self.drivers_trips(driver)
    end

    # retrieve all trips from the CSV file
    def self.riders_trips(rider)
    end

  end

end
