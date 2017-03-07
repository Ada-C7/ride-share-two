require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/trip.rb'
require_relative '../specs/spec_helper.rb'

describe Trip do

  describe "initalize" do
    it "takes trip ID, rider ID, a driver ID, date, rating" do
      trip_id = 5
      rider_id = ""
      driver_id = ""
      date = ""
      rating = 4.5
      trip = Trip.new(trip_id, rider_id, driver_id, date, rating)
      trip.must_be_instance_of Trip
      trip.trip_id.must_equal trip_id
      trip.rider_id.must_equal rider_id
      trip.driver_id.must_equal driver_id
      trip.date.must_equal date
      trip.rating.must_equal rating
    end
  end
  describe "self.all" do
    before do
      @csv_trip = Trip.all
    end
    it "checks for an array" do
      @csv_trip.must_be_instance_of Array
    end
    it "checks every array is instance of Driver" do
      @csv_trip.each do |array|
        array.must_be_instance_of Trip
      end
    end
    it "checks correct length of csv driver file" do
        @csv_trip.length.must_equal 601
    end
  end

end
