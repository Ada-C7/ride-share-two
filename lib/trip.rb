# Trip
#
# Each trip should:
#
# DONE: have an ID, rider ID, a driver ID, date, rating
# TODO: Each rating should be within an acceptable range (1-5)

# Given a trip object, you should be able to:
#
# TODO: retrieve the associated driver instance through the driver ID
# TODO: retrieve the associated rider instance through the rider ID

# You should be able to:
#
# TODO: find all trip instances for a given driver ID
# TODO: find all trip instances for a given rider ID
# TODO: retrieve all trips from the CSV file

require 'csv'

module RideShare
  class Trip
    def initialize(trip_id, driver_id, rider_id, date, rating)
      @trip_id = trip_id
      # @driver_id = driver_id
      # @rider_id = rider_id
      @date = date # Do not 'really' need, right?
      @rating = rating
    end

    def self.all
    end

    def find_all_driver_instances
    end

    def find_all_rider_instances
    end

  end
end


# test_1 = RideShare::Trip.all
#
# puts test_1.is_a? Array
