require 'simplecov'
SimpleCov.start

require 'csv'
require_relative '../specs/spec_helper'

describe "Trips initialize" do

  it "#trip_id: returns the value of the @trip_id instance variable" do
    trips = RideShare::Trips.new(trip_id: 33, driver_id: 1, rider_id: 54, date: "2016-04-05", rating: 3)
    trips.trip_id.must_equal 33
  end

  it "#driver_id: returns the value of the @trips_id instance variable" do
    trips = RideShare::Trips.new(trip_id: 33, driver_id: 1, rider_id: 54, date: "2016-04-05", rating: 3)
    trips.driver_id.must_equal 1
  end

  it "#rider_id: returns the value of the @rider_id instance variable" do
    trips = RideShare::Trips.new(trip_id: 33, driver_id: 1, rider_id: 54, date: "2016-04-05", rating: 3)
    trips.rider_id.must_equal 54
  end

  it "#date: returns the value of the @date instance variable" do
    trips = RideShare::Trips.new(trip_id: 33, driver_id: 1, rider_id: 54, date: "2016-04-05", rating: 3)
    trips.date.must_equal "2016-04-05"
  end

  it "#rating: returns the value of the @rating instance variable" do
    trips = RideShare::Trips.new(trip_id: 33, driver_id: 1, rider_id: 54, date: "2016-04-05", rating: 3)
    trips.rating.must_equal 3
  end

  it "#rating should be within an acceptable range (1-5)" do
    trips = RideShare::Trips.new(trip_id: 33, driver_id: 1, rider_id: 54, date: "2016-04-05", rating: 3)
    (1..5).must_include trips.rating
  end

  it "raise an ArgumentError if the rating is not is not a number from 1-5" do
    proc{
      driver = RideShare::Trips.new({rating: 7})
    }.must_raise ArgumentError
  end
end

describe "Trips.all" do
  it "all rides stored in an array" do
   all_rides = RideShare::Trips.all
   all_rides.must_be_instance_of Array
  end
end

describe "Trips.get_trips_driver_id" do
  it "returns an array of trips by the driver id" do
    RideShare::Trips.get_trips_driver_id(25).each do |trip|
      trip.driver_id.must_equal 25
    end
  end
end

describe "Trips.get_trips_driver_id" do
  it "returns an array of trips by the driver id" do
    RideShare::Trips.get_trips_rider_id(40).each do |trip|
      trip.rider_id.must_equal 40
    end
  end
end
