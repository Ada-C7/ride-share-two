module RideShare

  class Trip
  attr_reader :id, :rider_id, :driver_id, :date, :rating

    # creates trips that have an ID, rider ID, driver ID, date, and rating
    def initialize(id, rider_id, driver_id, date, rating)
      @id = id
      @rider_id = rider_id
      @driver_id = driver_id
      @date = date
      @rating = (1..5).include?(rating) ? rating : 3
    end


    # retrieve the associated driver instance through the driver ID
    def trip_driver
    end


    # retrieve the associated rider instance through the rider ID
    def trip_rider
    end


    # retrieve all trips from the CSV file
    def self.all
    end


    # find all trip instances for a given driver ID
    def self.drivers_trips(driver_id)
    end


    # find all trip instances for a given rider ID
    def self.riders_trips(rider_id)
    end

  end

end
