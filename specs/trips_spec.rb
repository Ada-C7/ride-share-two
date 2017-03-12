require_relative "spec_helper"
require 'pry'

describe "Rideshare::Trips" do

  before do
    Rideshare::Driver.all
    Rideshare::Trips.all
    Rideshare::Rider.all
  end


  describe "Trips#initialize" do

    it "initializes instances of the trips object through .all" do
      Rideshare::Trips.all_trips.first.class.must_equal Rideshare::Trips
    end

    it "initializes objects that have variables that match the CSV" do
      Rideshare::Trips.all_trips.first.trip_id.must_equal 1
      Rideshare::Trips.all_trips.first.driver_id.must_equal 1
      Rideshare::Trips.all_trips.first.rider_id.must_equal 54
      Rideshare::Trips.all_trips.first.date.must_equal "2016-04-05"
      Rideshare::Trips.all_trips.first.rating.must_equal 3
    end
  end

  describe "Trips#all" do

    it "returns an array of all trips from the CSV" do
      Rideshare::Trips.all_trips.length.must_equal 600
      Rideshare::Trips.all_trips.must_be_instance_of Array

    end

  end

  describe "Trips#trips_driver" do

    it "returns driver objects" do
      Rideshare::Trips.all_trips.first.trip_driver.must_be_instance_of Rideshare::Driver
    end

  end

  describe "Trips#trips_rider" do

    it "returns rider objects" do
      # Rideshare::Rider.all_riders
      Rideshare::Trips.all_trips.first.trip_rider.must_be_instance_of Rideshare::Rider
    end

  end

  describe "Trips#all_by_driver" do

    it "returns an array of the driver's trips" do
      Rideshare::Trips.all_by_driver(5).must_be_instance_of Array
      Rideshare::Trips.all_by_driver(5).first.must_be_instance_of Rideshare::Trips
      Rideshare::Trips.all_by_driver(5).first.rider_id.must_equal 140

    end

  end

  describe "Trips#all_by_rider" do

    it "returns an array of the driver's trips" do
      Rideshare::Trips.all_by_rider(5).must_be_instance_of Array
      Rideshare::Trips.all_by_rider(5).first.must_be_instance_of Rideshare::Trips
      Rideshare::Trips.all_by_rider(54).first.driver_id.must_equal 1
    end

  end

  describe "Trips#cost" do

    it "returns the cost of the trip instance" do
      Rideshare::Trips.all_trips.first.cost.must_equal 2
    end
  end

  describe "Trips#duration" do

    it "returns the duration of the trip instance" do
      Rideshare::Trips.all_trips.first.duration.must_equal 30
    end
  end

end
