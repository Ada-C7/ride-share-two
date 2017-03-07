require 'date'
require_relative './spec_helper.rb'
require_relative '../lib/file'
require_relative '../lib/trip'

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
    it "assigns reader method for instance variables" do
      @new_trip.id.must_equal 12
      @new_trip.driver_id.must_equal 12
      @new_trip.rider_id.must_equal 237
      @new_trip.date.must_be_instance_of Date
      @new_trip.rating.must_equal 1
    end
  end

  describe "Trip#all" do

    #example of trip data
    # trip_id,driver_id,rider_id,date,rating
    # 1,1,54,2016-04-05,3
    # 2,67,146,2016-01-13,5
    # 3,50,87,2016-05-02,3
    # 4,13,70,2016-05-14,4
    # 5,3,12,2015-12-14,2

    before do
      csv_file = './support/trips.csv'
      # @trips_data = RideShare::FileData.read_csv(csv_file)
      data = FileData.new(csv_file)
      @trips_data = data.read_csv_and_remove_headings
      @trips_bad_data_1 = [['three', '1', '54', "2016-04-05", '4']]
      @trips_bad_data_2 = [['3', 'one', '54', "2016-04-05", '4']]
      @trips_bad_data_3 = [['3', '1', 'fifity', "2016-04-05", '4']]
      @trips_bad_data_4 = [['3', '1', '54', "hello", '4']]
      # four will not pass the 1-5 test so that is the argument error raised
      @trips_bad_data_5 = [['3', '1', '54', "2016-04-05", 'four']]
      @trips_bad_data_6 = [['3', '1', '54', "2016-04-05", '7']]
      @trips_bad_data_7 = []
      @trips_bad_data_8 = [[]]
    end

    # let does not run this block untill it is called - which is good you want
    # the testing of the all method to happen in the it - do - end block
    let(:trips) {RideShare::Trip.all(@trips_data)}

    it "returns an array" do
      trips.must_be_instance_of Array
    end

    it "has instances of trips in the array" do
      trips.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    # this spec only well with the data in the csv file
    it "has the same number of trips as the CSV file" do
      trips.length.must_equal 600
    end

    it "raises an argument error if not given integer for trip ID  " do
      # proc also equals ->
      proc {
        RideShare::Trip.all(@trips_bad_data_1)
      }.must_raise ArgumentError
    end

    it "raises an argument error if not given intetger for driver_id" do
      proc {
        RideShare::Trip.all(@trips_bad_data_2)
      }.must_raise ArgumentError
    end

    it "raises an argument error if not given intetger for rider_id" do
      proc {
        RideShare::Trip.all(@trips_bad_data_3)
      }.must_raise ArgumentError
    end

    it "raises an argument error if not given proper date" do
      # at this point using Ruby's built in error for this
      proc {
        RideShare::Trip.all(@trips_bad_data_4)
      }.must_raise ArgumentError
    end

    # if you send "four" as rating - it wont pass the test_rating method
    it "raises an argument error if not given integer for rating" do
      proc {
        RideShare::Trip.all(@trips_bad_data_5)
      }.must_raise ArgumentError
    end

    it "raises an argument error if not given 1-5 integer for rating" do
      err = proc {
        RideShare::Trip.all(@trips_bad_data_6)
      }.must_raise ArgumentError
      err.message.must_equal "Rating must be 1-5"
    end

    it "raises an arugment error if given empty arrays" do
      proc {
        RideShare::Trip.all(@trips_bad_data_7)
      }.must_raise ArgumentError
    end

    # good example of testing an error with the expected error message
    it "given error message when given [[]]" do
      err = proc {
        RideShare::Trip.all(@trips_bad_data_8)
      }.must_raise TypeError
      err.message.must_equal "can't convert nil into Integer"
    end
  end

  describe "Trip#find_by_driver" do

    before do
      csv_file = './support/trips.csv'
      # @trips_data = RideShare::FileData.read_csv(csv_file)
      data = FileData.new(csv_file)
      @trips_data = data.read_csv_and_remove_headings
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

  describe "Trip#find_by_rider" do

    before do
      csv_file = './support/trips.csv'
      # @trips_data = RideShare::FileData.read_csv(csv_file)
      data = FileData.new(csv_file)
      @trips_data = data.read_csv_and_remove_headings
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
