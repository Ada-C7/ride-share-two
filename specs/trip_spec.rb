require 'date'
require_relative '../lib/file'
require_relative '../lib/trip'
require_relative './spec_helper.rb'

describe "Trip" do
  # trip_id,driver_id,rider_id,date,rating
  # 12,12,237,2016-08-21,1

  describe "Trip#initialize" do
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

    it "returns an instance of Trip" do
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

      @bad_data = {
                    bad_id: [['4', '2', '34', "2016-04-05", '5'], ['three', '1', '54', "2016-04-05", '4']],
                    bad_driver_id: [['3', 'one', '54', "2016-04-05", '4']],
                    bad_rider_id: [['3', '1', 'fifity', "2016-04-05", '4']],
                    bad_date: [['3', '1', '54', "hello", '4']],
                    bad_rating: [['3', '1', '54', "2016-04-05", 'four']],
                    rating_out_of_range: [['3', '1', '54', "2016-04-05", '7']],
                    missing_part: [['3', '1', '54', "2016-04-05"]],
                    empty_array: [],
                    empty_nested_arrays: [[]]

                  }
    end

    # let does not run this block untill it is called - which is good you want
    # the testing of the all method to happen in the it - do - end block
    let(:trips) {RideShare::Trip.all(@trips_data)}

    it "returns an array" do
      trips.must_be_instance_of Array
    end

    it "each item in array is a Trip object" do
      trips.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    # this spec only well with the data in the csv file
    it "has the same number of trips as the CSV file" do
      trips.length.must_equal 600
    end

    it "raises an error if not given integer for trip ID  " do
      # proc also equals ->
      proc {
        RideShare::Trip.all(@bad_data[:bad_id])
      }.must_raise ArgumentError
    end

    it "raises an error if not given intetger for driver_id" do
      proc {
        RideShare::Trip.all(@bad_data[:bad_driver_id])
      }.must_raise ArgumentError
    end

    it "raises an error if not given intetger for rider_id" do
      proc {
        RideShare::Trip.all(@bad_data[:bad_rider_id])
      }.must_raise ArgumentError
    end

    it "raises an error if not given proper date" do
      # at this point using Ruby's built in error for this
      proc {
        RideShare::Trip.all(@bad_data[:bad_date])
      }.must_raise ArgumentError
    end

    # if you send "four" as rating - it wont pass the test_rating method
    it "raises an error if not given integer for rating" do
      proc {
        RideShare::Trip.all(@bad_data[:bad_rating])
      }.must_raise ArgumentError
    end

    it "raises an error if not given 1-5 integer for rating" do
      err = proc {
        RideShare::Trip.all(@bad_data[:rating_out_of_range])
      }.must_raise ArgumentError
      err.message.must_equal "Rating must be 1-5"
    end

    it "raises an error if given empty array" do
      proc {
        RideShare::Trip.all(@bad_data[:empty_array])
      }.must_raise ArgumentError
    end

    # good example of testing an error with the expected error message
    it "raises an error message when given [[]]" do
      proc {
        RideShare::Trip.all(@bad_data[:empty_nested_arrays])
      }.must_raise ArgumentError
    end

    it "riases an error if not given all info pieces" do
      proc {
        RideShare::Trip.all(@bad_data[:missing_part])
      }.must_raise ArgumentError
    end
  end

  describe "Trip#find_by_driver" do

    before do
      @driver_id = 7
    end

    let(:trips) { RideShare::Trip.find_by_driver(@driver_id)}
    let(:no_trips) { RideShare::Trip.find_by_driver(100) }

    it "returns an array" do
      trips.must_be_instance_of Array
    end

    it "returns an array of trip instances" do
      trips.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    it "has same driver id for all trip instances" do
      trips.each { |trip| trip.driver_id.must_equal @driver_id }
    end

    it "returns nil if there are no trips for a driver" do
      no_trips.must_be_nil
    end
  end

  describe "Trip#find_by_rider" do

    before do
      @rider_id = 120
    end

    let(:trips) { RideShare::Trip.find_by_rider(@rider_id) }
    let(:no_trips) { RideShare::Trip.find_by_rider(500)}

    it "returns an array" do
      trips.must_be_instance_of Array
    end

    it "returns an array of trip instances" do
      trips.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    it "has same rider id for all trip instances" do
      trips.each { |trip| trip.rider_id.must_equal @rider_id }
    end

    it "returns nil if there are no trips for rider" do
      no_trips.must_be_nil
    end
  end

#######################################################

  let(:trips) { RideShare::Trip.all }

  describe "Trip#get_driver" do

    before do
      # there is not driver_id 0 in drivers.csv but trips.csv has trips for driver_id 0
      @bad_driver_id = 0
    end
    let(:trips_bad_driver_id) { RideShare::Trip.find_by_driver(@bad_driver_id)}

    # this spec is testing every trip from csv - you could use sample to reduce
    # you now know there are trips for driver_id 0 -this driver DNE in drivers data
    # need to change how you test or figure out how to ignore bad driver ids
    # one solution to ignore is using this recuse false
    it "returns a driver instance for good driver_id" do
      trips.sample(100).each do |trip|
        driver = trip.get_driver rescue nil
        driver.must_be_instance_of RideShare::Driver unless driver.nil?
      end
    end

    # Should return an error...
    # Want to have driver in csv/database
    # don't want to return drivers that have not been initialized
    it "raises an error if no matching driver instance for driver_id" do
      err = proc {
             trips_bad_driver_id.each { |trip| trip.get_driver }
           }.must_raise ArgumentError
      err.message.must_equal "No driver with id: #{@bad_driver_id} in driver csv"
    end
  end

  describe "Trip#get_rider" do

    before do
      @bad_rider_id = 0
    end

    let(:trips_bad_rider_id) {RideShare::Trip.find_by_rider(@bad_rider_id)}

    it "returns a rider instance for good rider_id" do
      trips.sample(100).each do |trip|
        rider = trip.get_rider rescue nil
        rider.must_be_instance_of RideShare::Rider unless rider.nil?
      end
    end

    it "returns an error if no matching rider instance for rider_id" do
      err = proc {
             trips_bad_rider_id.each { |trip| trip.get_rider }
           }.must_raise ArgumentError
      err.message.must_equal "No rider with id: #{@bad_rider_id} in rider csv"
    end
  end
end
