# require 'minitest/autorun'
# require 'minitest/reporters'
# require_relative '../lib/trip'
require_relative 'spec_helper'

describe "Trip class" do

  describe "initialization of Trip" do
    it "Initializes Trip with trip ID, rider ID, driver ID, date, and rating" do
      trip_id = "4321"
      driver_id = "987"
      rider_id = "1234"
      date = "2017-3-8"
      rating = "5"

      trip = RideShare::Trip.new(trip_id, driver_id, rider_id, date, rating)
      trip.must_respond_to :trip_id
      trip.trip_id.must_equal trip_id

      trip.must_respond_to :date
      trip.date.must_equal date

    end
  end

  describe "self.find_many_drivers class method" do
    it "Returns array of many Trip instances for given driver" do
      driver_trips = RideShare::Trip.find_many_drivers("1")
      driver_trips.must_be_instance_of Array
      driver_trips.length.must_equal 9
    end
  end

  describe "self.find_many_riders class method" do
    it "Returns array of many Trip instances for given rider" do
      rider_trips = RideShare::Trip.find_many_riders("296")
      rider_trips.must_be_instance_of Array
      rider_trips.length.must_equal 3
    end
  end

  describe "self.all class method" do
    it "Returns array of all trips from CSV" do
      RideShare::Trip.all.must_be_instance_of Array, "Not an array"
    end

    it "For first and last trip, trip ID and date must match what's in CSV file" do
      # skip
      trips_array = RideShare::Trip.all

      trips_array[1].trip_id.must_equal("1")
      trips_array[1].date.must_equal("2016-04-05")
      trips_array[-1].trip_id.must_equal("600")
      trips_array[-1].date.must_equal("2016-04-25")
    end

    it "Array retrieved by self.all retrieves same number of trips as is in CSV" do
      # skip
      trips_array = RideShare::Trip.all

      trips_array.length.must_equal 601
    end
  end
end
