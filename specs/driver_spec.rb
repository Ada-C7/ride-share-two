require_relative 'spec_helper'

describe "Driver" do

  describe "#initialize" do
    it "takes an id, name, and vin" do
      new_driver = Driver.new(1, "Santa Claus", 98109999999999999)

      new_driver.must_respond_to :id
      new_driver.id.must_equal 1

      new_driver.must_respond_to :name
      new_driver.name.must_equal "Santa Claus"

      new_driver.must_respond_to :vin
      new_driver.vin.must_equal 98109999999999999
    end

    it "must be an instance of the Driver class" do
      kind_driver = Driver.new(1, "Santa Claus", 98109999999999999)
      kind_driver.must_be_instance_of Driver
    end

    it "must have a VIN of 17" do
      proc {
        Driver.new(10000, "Ada Lovelace", 100)
      }.must_raise ArgumentError

      proc {
        Driver.new(10000, "Ada Lovelace", "9892F")
      }.must_raise ArgumentError

      proc {
        Driver.new(10000, "Ada Lovelace", "120984EIF26384394DK28")
      }.must_raise ArgumentError
    end
  end

  describe "#trips" do
    it "returns the list of trip instances that only this driver has taken" do
      first_driver = Driver.new(1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE9")
      first_driver_trips = first_driver.trips(1)
      first_driver_trips.must_be_instance_of Array
      first_driver_trips.each { |trip| trip.must_be_instance_of Trip }
      first_driver_trips.length.must_equal 9
    end
  end

  describe "Driver#all" do
    let (:drivers)  {
      Driver.all
    }

    it "returns all drivers from the CSV file" do
      drivers.must_be_instance_of Array

      drivers.each { |i| i.must_be_instance_of Driver }

      drivers.length.must_equal 100
    end

    it "only returns drivers listed in the CSV file" do
      # created new driver
      # .all should not include this driver
    end
  end

  describe "Driver#find" do
    let (:drivers)  {
      Driver.all
    }

    it "returns a driver that exists" do
      driver = Driver.find(drivers[0].id)
      driver.must_be_instance_of Driver
    end

    it "can find the first driver from the CSV" do
      driver = Driver.find(1)
      driver.id.must_equal drivers[0].id
    end

    it "can find the last driver from the CSV" do
      driver = Driver.find(100)
      driver.id.must_equal drivers[-1].id
    end

    it "raises an error for a driver that doesn't exist" do
      proc {
        Driver.find(111111)
      }.must_raise ArgumentError
    end

    it "will only find drivers in the CSV file" do
      #will ignore driver objects not in CSV file
    end
  end

  describe "#rating" do
    # pass in driver id
    # gets an average rating for that driver
    # calls Driver(class)'s trip(id) method, which will give all the trips (with ratings for each)
    # sum all the ratings, divide by the number of trips/ratings
    # does it get the right sum?
    # does it get the right count (with which to divide with?)
    # does it get the right average?
    it "returns the average rating for a driver" do
      new_driver = Driver.new(1, "Santa Claus", 98109999999999999)
      new_driver.rating(1).must_be_instance_of Float
      new_driver.rating(1).must_equal 2.3333333333333335

      shakira = Driver.new(16, "Shakira Stamm" , "SALUVSAL3WA67SBPZ")
      shakira.rating(16).must_be_instance_of Float
      shakira.rating(16).must_equal 2.5
    end
  end

end
