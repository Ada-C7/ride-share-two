require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
# require 'minitest/pride'
require 'minitest/skip_dsl'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/ride_share_trip.rb'

describe "Trip" do
  describe "Trip#initialize" do
    it "Creates a Trip class" do
      args = {trip_id: 2 , driver_id: 67, rider_id: 146, date: 2016-01-13, rating: 5}
      trip = Rideshare::Trip.new(args)
      trip.must_be_kind_of Rideshare::Trip
    end

    it "Raise an argument error if rating is not 1-5" do
      args = {trip_id: 2 , driver_id: 67, rider_id: 146, date: 2016-01-13, rating: 6}
      proc {Rideshare::Trip.new(args)}.must_raise ArgumentError
    end
  end


  describe "Trip#find_driver(driver_id)" do
    it "Retrieve the associated driver instance through the driver id" do
      expected = {id: 3, name: "Daryl Nitzsche", vin: "SAL6P2M2XNHC5Y656"}
      Rideshare::Trip.find_driver(3).must_equal expected
    end
  end

  describe "Trip#find_rider(rider_id)" do
    it "Retrieve the associated rider instance through the rider id" do
    end
  end
end
