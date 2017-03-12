# Trip

require 'csv'

module RideShare
  class Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating
    def initialize(trip_id, driver_id, rider_id, date, rating)
      @trip_id = trip_id
      @driver_id = driver_id
      @rider_id = rider_id
      @date = date # Do not 'really' need, right?
      @rating = rating
    end

    # DONE: have an ID, rider ID, a driver ID, date, rating
    # DONE: Each rating should be within an acceptable range (1-5)
    # DONE: retrieve all trips from the CSV file
    def self.all
      # TODO: Clean up variable names.
      read_file = CSV.readlines('support/trips.csv')

      cleaned_array = read_file.delete_if do |row|
        row == read_file[0]
      end

      trips_array = []
      cleaned_array.map do |params|
        if params[4].to_i >= 1 && params[4].to_i <= 5
          #trip_id, driver_id, rider_id, date, rating
          trips = self.new(params[0].to_s, params[1].to_s, params[2].to_s, params[3].to_s, params[4].to_s)
          trips_array << trips
        end
      end
      return trips_array
    end

    # DONE: find all trip instances for a given driver ID
    # DONE: retrieve the associated driver instance through the driver ID
    def find_all_driver_instances(driver_id)
      driver_instance_array = []
      new_instance = RideShare::Trip.all

      new_instance.each do |trip|
        if trip.driver_id == driver_id
          driver_instance_array << [trip.trip_id, trip.driver_id, trip.rider_id, trip.date, trip.rating]
        end
      end
      return driver_instance_array
    end

    # DONE: find all trip instances for a given rider ID
    # DONE: retrieve the associated rider instance through the rider ID
    def find_all_rider_instances(rider_id)
      rider_instance_array = []
      new_instance = RideShare::Trip.all

      new_instance.each do |trip|
        if trip.rider_id == rider_id
          rider_instance_array << [trip.trip_id, trip.driver_id, trip.rider_id, trip.date, trip.rating]
        end
      end
      return rider_instance_array
    end

  end
end


# test_1 = RideShare::Trip.all
#
# puts test_1

# test_1 = RideShare::Trip.new("", "", "", "", "")
#
# puts test_1.find_all_driver_instances("67")

# test_1 = RideShare::Trip.new("", "", "", "", "")
#
# puts test_1.find_all_driver_instances("1")
