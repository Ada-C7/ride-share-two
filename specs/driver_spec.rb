require_relative 'spec_helper'

describe "Driver" do

  describe "#initialize" do
    it "takes an id, name, and vin" do
      new_driver = Driver.new(1, "Santa Claus", 98109)

      new_driver.must_respond_to :id
      new_driver.id.must_equal 1

      new_driver.must_respond_to :name
      new_driver.name.must_equal "Santa Claus"

      new_driver.must_respond_to :vin
      new_driver.vin.must_equal 98109
    end

    it "must be an instance of the Driver class" do
      kind_driver = Driver.new(1, "Santa Claus", 98109)
      kind_driver.must_be_instance_of Driver
    end
  end

  describe "#trips" do
    it "returns the list of trip instances that only this driver has taken" do
      first_driver = Driver.new(1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE9")
      first_driver_trips = first_driver.trips(1)
      first_driver_trips.must_be_instance_of Array
      first_driver_trips.each { |trip| return trip }.must_be_instance_of Array

      # takes in driver id
      # returns a list of all this driver's trips
      # each trip (element) must be an Array, as trips is an array of arrays
    end
  end

  describe "Driver#all" do
    before do
      @drivers = Driver.all
    end

    it "returns all drivers from the CSV file" do
      @drivers.must_be_instance_of Array

      (@drivers.each { |i| return i }).must_be_instance_of Driver

      @drivers.length.must_equal 100
    end
  end

  describe "Driver#find" do
    before do
      @drivers = Driver.all
    end

    it "returns a driver that exists" do
      driver = Driver.find(@drivers[0].id)
      driver.must_be_instance_of Driver
    end

    it "can find the first driver from the CSV" do
      driver = Driver.find(1)
      driver.id.must_equal @drivers[0].id
    end

    it "can find the last driver from the CSV" do
      driver = Driver.find(100)
      driver.id.must_equal @drivers[-1].id
    end

    it "raises an error for a driver that doesn't exist" do
      proc {
        Driver.find(111111)
      }.must_raise ArgumentError
    end
  end

  describe "#rating" do
    # pass in driver id
    # gets an average rating for that driver
    # calls Driver(class)'s trip(id) method, which will give all the trips (with ratings for each)
    # sum all the ratings, divide by the number of trips/ratings
    it "returns the average rating for a driver" do
      new_driver = Driver.new(1, "Santa Claus", 98109)
      new_driver.rating(1).must_be_instance_of Float
      new_driver.rating(1).must_equal 2.3333333333333335
    end
  end

end
