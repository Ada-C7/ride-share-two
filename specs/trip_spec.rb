require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/trip'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Trip" do

  # trip_id,driver_id,rider_id,date,rating
  # 12,12,237,2016-08-21,1

  # if you want a date object for Date use:
  # Date.parse('2001-02-03')
  # also require date at top of file
  describe "Trip#Initialize" do
    before do
      trip_info = {
        trip_id: 12,
        driver_id: 12,
        rider_id: 237,
        date: "2016-08-21",
        rating: 1
      }
      @new_trip = RideShare::Trip.new(trip_info)
    end

    it "raises an argument error if..." do
      skip
    end

    it "initializes with 1 argument: a trip info hash" do
      @new_trip.must_be_instance_of RideShare::Trip
    end

    it "assigns instance variables: id, driver_id, rider_id, date, rating" do
      @new_trip.id.must_equal 12
      @new_trip.driver_id.must_equal 12
      @new_trip.rider_id.must_equal 237
    end

  end

end
