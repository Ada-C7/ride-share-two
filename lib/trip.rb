# Trip
#
# Each trip should:
#
# TODO: have an ID, rider ID, a driver ID, date, rating
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
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
    end

    def self.all
      trips_array = []
      read_file = CSV.read('support/trips.csv')

      read_file.map do |line|
        trip_id = line[0].to_i
        driver_id = line[1].to_i
        rider_id = line[2].to_i
        date = line[3].to_s
        rating = line[4].to_i
        new_trip = self.new(trip_id, driver_id, rider_id, date, rating)
        trips_array << new_trip
      end
      return trips_array
    end

  end
end


# test_1 = RideShare::Trip.new(213124, 1, 1, "dfg", "jake")
#
# puts test_1
