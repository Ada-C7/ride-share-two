require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
# require 'minitest/pride'
require 'minitest/skip_dsl'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/ride_share_trip.rb'
require_relative '../lib/ride_share_driver.rb'
require_relative '../lib/ride_share_rider.rb'


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


  describe "Trip#find_trip_by_driver(driver_id)" do
    it "Find all trip instances for a given driver ID" do
      expected = [
        {:trip_id=>1, :driver_id=>1, :rider_id=>54, :date=>"2016-04-05", :rating=>3},
        {:trip_id=>122, :driver_id=>1, :rider_id=>247, :date=>"2015-12-24", :rating=>5},
        {:trip_id=>124, :driver_id=>1, :rider_id=>26, :date=>"2016-10-16", :rating=>4},
        {:trip_id=>216, :driver_id=>1, :rider_id=>201, :date=>"2015-03-24", :rating=>1},
        {:trip_id=>417, :driver_id=>1, :rider_id=>129, :date=>"2015-03-29", :rating=>1},
        {:trip_id=>434, :driver_id=>1, :rider_id=>112, :date=>"2015-06-07", :rating=>2},
        {:trip_id=>439, :driver_id=>1, :rider_id=>146, :date=>"2015-09-23", :rating=>1},
        {:trip_id=>530, :driver_id=>1, :rider_id=>196, :date=>"2016-04-04", :rating=>1},
        {:trip_id=>553, :driver_id=>1, :rider_id=>266, :date=>"2016-12-16", :rating=>3}
      ]
      Rideshare::Trip.find_trip_by_driver(1).must_equal expected
    end
  end

  describe "Trip#find_trip_by_rider(rider_id)" do
    it "Find all trip instances for a given rider ID" do
      expected = [
        {:trip_id=>46, :driver_id=>98, :rider_id=>1, :date=>"2016-06-28", :rating=>2},
        {:trip_id=>272, :driver_id=>17, :rider_id=>1, :date=>"2015-09-14", :rating=>4}
      ]
      Rideshare::Trip.find_trip_by_rider(1).must_equal expected
    end
  end

  describe "Trip.all" do
    it "Retrieve all trips from the CSV file" do
      all = Rideshare::Trip.all
      expected = {trip_id: 600, driver_id: 61, rider_id: 168, date: "2016-04-25", rating: 3}
      all.last.must_equal expected
    end
  end

  describe "Trip#driver_info" do
    it "Retrieve the associated driver instance through the driver ID" do
      args = {trip_id: 1 , driver_id: 1, rider_id: 54, date: 2016-04-05, rating: 3}
      trip = Rideshare::Trip.new(args)
      expected = {id: 1, name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9"}
      trip.driver_info.must_equal expected
    end
  end

  describe "Trip#rider" do
    it "Retreve the associated rider instance through the rider ID" do
      args = {trip_id: 46 , driver_id: 98, rider_id: 1, date: 2016-06-28, rating: 2}
      trip = Rideshare::Trip.new(args)
      expected = {id: 1, name: "Nina Hintz Sr.", phone_num: "560.815.3059"}
      trip.rider_info.must_equal expected
    end
  end


end
