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
        id: 12,
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

    # this is more testing the reader methods for the instance variables
    it "assigns instance variables: id, driver_id, rider_id, date, rating" do
      @new_trip.id.must_equal 12
      @new_trip.driver_id.must_equal 12
      @new_trip.rider_id.must_equal 237
      @new_trip.date.must_equal "2016-08-21"
      @new_trip.rating.must_equal 1
    end
  end

  describe "Trip#all" do

    let(:trips) { RideShare::Trip.all('./support/trips.csv') }

    it "requires a csv file" do
      proc {
        RideShare::Trip.all("random text")
      }.must_raise Errno::ENOENT
    end

    it "returns an array" do
      trips.must_be_instance_of Array
    end

    it "has instances of trips in the array" do
      trips.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    it "has the same number of trips as the CSV file" do
      trips.length.must_equal 600
    end
  end

  describe "Trip#find_by_driver" do

    before do
      @csv_file = './support/trips.csv'
      @driver_id = 7
    end

    let(:trips) { RideShare::Trip.find_by_driver(@driver_id, @csv_file)}

    it "requires two arguments" do
      skip
    end

    it "returns an array" do
      trips.must_be_instance_of Array
    end

    it "returns an array of trip instances" do
      trips.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    it "has same driver id for all trip instances" do
      trips.each { |trip| trip.driver_id.must_equal @driver_id }
    end
  end

  describe "Trip#find_by_rider" do

    before do
      @csv_file = './support/trips.csv'
      @rider_id = 120
    end

    let(:trips) { RideShare::Trip.find_by_rider(@rider_id, @csv_file)}

    it "returns an array" do
      trips.must_be_instance_of Array
    end

    it "returns an array of trip instances" do
      trips.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    it "has same rider id for all trip instances" do
      trips.each { |trip| trip.rider_id.must_equal @rider_id }
    end
  end
end
