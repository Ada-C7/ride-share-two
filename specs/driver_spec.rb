require_relative "spec_helper"
require 'pry'

describe "Rideshare::Driver" do

  before do
    Rideshare::Driver.all
    Rideshare::Trips.all
    Rideshare::Rider.all

  end

  describe "Driver#initialize" do

    it "initializes an instance of the Driver object" do
      Rideshare::Driver.all_drivers.first.class.must_equal Rideshare::Driver
    end

    it "initializes objects that have variables that match the CSV" do
      Rideshare::Driver.all_drivers.first.id.must_equal 1
      Rideshare::Driver.all_drivers.first.name.must_equal "Bernardo Prosacco"
      Rideshare::Driver.all_drivers.first.vin.must_equal "WBWSS52P9NEYLVDE9"
    end

  end

  describe "Driver#trips" do

    it "returns an array of all the instance of the driver's trip" do
      Rideshare::Driver.all_drivers.first.trips.must_be_instance_of Array
    end

    it "returns objects that have the class Trips" do
      Rideshare::Driver.all_drivers.first.trips.first.must_be_instance_of Rideshare::Trips
    end

  end

  describe "Driver#all" do

    it "returns an array of all drivers from the CSV" do
      Rideshare::Driver.all_drivers.length.must_equal 100
      Rideshare::Driver.all_drivers.must_be_instance_of Array

    end

  end

  describe "Driver#find" do

    it "returns an instance of the variable given the driver id" do
      Rideshare::Driver.find(2).must_be_instance_of Rideshare::Driver
    end

    it "returns an object that has variables that match the CSV" do
      Rideshare::Driver.find(2).id.must_equal 2
      Rideshare::Driver.find(2).name.must_equal "Emory Rosenbaum"
      Rideshare::Driver.find(2).vin.must_equal "1B9WEX2R92R12900E"

    end

    it "raises an error when an invalid id is given" do
      proc {
        Rideshare::Driver.find(1000)
      }.must_raise ArgumentError
    end

  end

  describe "Driver#rating" do
    it "raises an error when the driver has no ratings" do
      proc { Rideshare::Driver.all_drivers.last.rating }.must_raise ArgumentError
    end


    it "returns the average rating of the driver given the driver id" do
      Rideshare::Driver.all_drivers.first.rating.must_be_instance_of Float
    end

    it "must return a Float between 1 and 5" do
      #this needs to change
      Rideshare::Driver.all_drivers.first.rating.must_be :>=, 0
      Rideshare::Driver.all_drivers.first.rating.must_be :<=, 5
    end
  end
end
