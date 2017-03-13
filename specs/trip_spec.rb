require_relative 'spec_helper'
require 'pry'

# Also if you weren't already testing for it, there are a bunch of invalid trip lines in the csv file that will make trip objects with driver ids that don't exist
describe "Trip" do

  describe "initialize" do
    it "Raises an ArgumentError when the rating is less than 1" do
      proc {
        RideShare::Trip.new(trip_id: 2, driver_id: 3, rider_id: 3, date: 2016-01-13, rating: 0)
      }.must_raise ArgumentError
    end

    it "Raises an ArgumentError when the rating is greater than 5" do
      proc {
        RideShare::Trip.new(trip_id: 1, driver_id: 2, rider_id: 2, date: 2016-02-13, rating: 6)
      }.must_raise ArgumentError
    end
  end

  describe "create_all_trips" do
    let(:trips) {RideShare::Trip.create_all_trips}
    it "Returns an array of all trips" do
      trips.must_be_instance_of Array
    end

    it "The number of trips is correct" do
      trips.length.must_equal 600
    end
  end

  describe "Find all trips for a driver" do
    it "should return an array of all trips for a driver" do
      RideShare::Trip.driver_trips(1).must_be_instance_of Array
    end
  end

  describe "driver method" do
    it "collects driver information: name and vin" do
      RideShare::Trip.new(trip_id: 1, driver_id: 1, rider_id: 54, date: 2016-04-05, rating: 3).driver.must_be_instance_of Hash
    end
  end

  describe "Find all trips for a rider" do
    it "should return an array of all trips for a rider" do
      skip
      RideShare::Trip.rider_trips(1).must_be_instance_of Array
    end
  end

  describe "rider method" do
    it "collects rider information: name and phone number" do
      skip
      RideShare::Trip.new(trip_id: 1, driver_id: 1, rider_id: 54, date: 2016-04-05, rating: 3).driver.must_be_instance_of Hash
    end
  end

end
