require_relative "spec_helper"
require 'pry'

describe "Rideshare::Driver" do

  let(:driver_list) { Rideshare::Driver.all }
  let(:trips_list) { Ridershare::Trips.all }
  # before do
  #   @driver_list = Rideshare::Driver.all
  # end

  describe "Driver#initialize" do

    it "initializes an instance of the Driver object" do
      driver_list.first.class.must_equal Rideshare::Driver
    end

    it "raises an error when the vin number does not equal 17 characters" do
      proc {
        Rideshare::Driver.new(101, "ann dai", "WBTDYBGY2MKY5XRHZ***")
      }.must_raise ArgumentError
    end
  end

  describe "Driver#trips" do

    it "returns an array of all the instance of the driver's trip" do
      driver_id = driver_list.first.id
      driver_list.trips(driver_id).must_be_instance_of Array
    end

    it "raises an error if the driver id does not exist" do
      driver_id = 1000
      proc {
        driver_list.trips(driver_id)
      }.must_raise ArgumentError

    end
  end

  describe "Driver#all" do

    it "returns an array of all drivers from the CSV" do
      driver_list.length.must_equal 100
    end

    it "creates a new driver instance with the appropriate instance variables" do
      driver_list.first.id.must_equal 1
      driver_list.first.name.must_equal "Bernardo Prosacco"
      driver_list.first.vin.must_equal "WBWSS52P9NEYLVDE9"
    end

  end

  describe "Driver#find" do

    it "returns an instace of the variable given the driver id" do
      driver_list.find(2).must_equal [2, "Emory Rosenbaum", "1B9WEX2R92R12900E"]
    end

    it "raises an error when an invalid id is given" do
      proc {
        driver_list.find(1000)
      }.must_raise ArgumentError
    end

  end

  describe "Driver#rating" do
      let(:driver_id)  { driver_list[50][0] }

    it "returns the average rating of the driver given the driver id" do
      driver_list.rating(driver_id).must_be_instance_of Float
    end

    it "must return a Float between 1 and 5" do
      #this needs to change
      driver_list.rating(driver_id).must_be :>=, 0
      driver_list.rating(driver_id).must_be :<=, 5
    end
  end


end
