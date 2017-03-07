require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'date'
require_relative '../lib/trip'
require_relative '../lib/file'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Trip" do

  # trip_id,driver_id,rider_id,date,rating
  # 12,12,237,2016-08-21,1

  describe "Trip#Initialize" do
    before do
      trip_info = {
        id: 12,
        driver_id: 12,
        rider_id: 237,
        date: Date.parse('2001-02-03'),
        rating: 1
      }
      @new_trip = RideShare::Trip.new(trip_info)
    end

    # you only need to check the input if it's coming from a untrusted source (like a user)
    # test it when you import (when you read the CSV file) (note anything outside your code is untrustful)
    it "raises an argument error if..." do
      skip
    end

    it "initializes with 1 argument" do
      @new_trip.must_be_instance_of RideShare::Trip
    end

    # this is more testing the reader methods for the instance variables
    it "assigns instance variables: id, driver_id, rider_id, date, rating" do
      @new_trip.id.must_equal 12
      @new_trip.driver_id.must_equal 12
      @new_trip.rider_id.must_equal 237
      @new_trip.date.must_be_instance_of Date
      @new_trip.rating.must_equal 1
    end
  end

  describe "Trip#all" do

    #example of trip data

    # 1,1,54,2016-04-05,3
    # 2,67,146,2016-01-13,5
    # 3,50,87,2016-05-02,3
    # 4,13,70,2016-05-14,4
    # 5,3,12,2015-12-14,2

    # so if you passed in trip_data arrays you can more easily make bad data
    # writing these are easier than making csv files (more contained)
    # chris says write one for each type of error - good luck figuring out all errors
    # you can use let to pass in the bad arrays
    # [ [], [], [], [] ]

    before do
      @trips_data = RideShare::FileData.read_csv('./support/trips.csv')
      # all data is words - wont pass integer test
      @trips_data_bad_1 = [
                          ["three"], ["one"], ["january 13, 2020"], ["five"]
                          ]
      # @trips_data_bad_2 =
      # @trips_data_bad_3 =
    end

    let(:trips) {RideShare::Trip.all(@trips_data)}

    # can I make a loop out of these assertions and then set lets
    # format:
    # let
    # run loop
    # new let
    # run loop
    # etc...

    it "takes an array of data" do
      skip
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
      csv_file = './support/trips.csv'
      @trips_data = RideShare::FileData.read_csv(csv_file)
      @driver_id = 7
    end

    let(:trips) { RideShare::Trip.find_by_driver(@driver_id, @trips_data)}

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
  #
  describe "Trip#find_by_rider" do

    before do
      csv_file = './support/trips.csv'
      @trips_data = RideShare::FileData.read_csv(csv_file)
      @rider_id = 120
    end

    let(:trips) { RideShare::Trip.find_by_rider(@rider_id, @trips_data)}

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
