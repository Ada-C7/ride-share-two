require 'csv'

module RideShare
  class Trip
    attr_accessor :trip_id, :rider_id, :driver_id, :date, :rating

    def initialize(trip_id, driver_id, rider_id, date, rating)
      raise ArgumentError.new ("rating must be between 1-5") if rating > 5 || rating < 1
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date
      @rating = rating
    end

    def self.all_trip_info
      all_trips_array = []
      CSV.read('support/trips.csv').each do |object|
        trip_id = object[0].to_i
        driver_id = object[1].to_i
        rider_id = object[2].to_i
        date = object[3].to_s
        rating = object[4].to_i
        a_trip = RideShare::Trip.new(trip_id, driver_id, rider_id, date, rating)
        all_trips_array << a_trip
      end
      return all_trips_array
      # return all the trips in the trip csv
    end

    def self.driver_trip_instances(driver_id)
      driver_trips = []
      trips = RideShare::Trip.all_trip_info
      trips.each do |object|
        if driver_id == object.driver_id
          driver_trips << object
        end
      end
      return driver_trips
    end

    # retrieve the associated rider instance through the rider ID
    def self.all_rider_trip_instances(rider_id)
      rider_trips = []
      trips = RideShare::Rider.all_rider_info
      trips.each do |object|
        if rider_id == object.rider_id
        rider_trips << trips
        end
      end
      return rider_trips
    end

  end
end

# RideShare::Trip.driver_trip_instances(1)
# new_trip = RideShare::Trip.new( 1, 1, 54, "2016-04-05", 3)
# new_trip
# trip_id,driver_id,rider_id,date,rating
# 1,1,54,2016-04-05,3
# 2,67,146,2016-01-13,5

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
