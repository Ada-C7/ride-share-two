require 'csv'

module RideShare
  class Trip
    attr_accessor :trip_id, :rider_id, :driver_id, :date, :rating

    def initialize(trip_id, driver_id, rider_id, date, rating)
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
    end
    #
    # def calculate_rating(rating)
    #   between 1-5 avg find this in the trip csv
    # end
    #
    # def driver_trips
    #   use driver trip instances in driver (its a self method)
    # end
    #
    # def rider_trips
    #   use trip instances in rider (its a self method)
    # end
    #
    def all_trips
      return all the trip sin the trip csv
    end

  end
end



#
# have an ID, rider ID, a driver ID, date, rating
# Each rating should be within an acceptable range (1-5)
# Given a trip object, you should be able to:
#
# retrieve the associated driver instance through the driver ID
# retrieve the associated rider instance through the rider ID
# You should be able to:
#
# find all trip instances for a given driver ID
# find all trip instances for a given rider ID
# retrieve all trips from the CSV file
