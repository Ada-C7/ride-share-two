require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'csv'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../ride-share'
require_relative 'spec-helper'

describe "RideShare::Driver" do

  let(:my_driver) { Driver.new(2,"name", "WBWSS52P9NEYLVDE9")}
  let(:driver_trips) { Driver.find_trips(1) }     # find trips for driver_id 1

  describe "initialize method" do

    it "must be an instance of Driver class" do
      my_driver.must_be_instance_of Driver
    end

    it "name must be a string" do
      my_driver.name.must_be_kind_of String
    end

    it "id must be a number" do
      my_driver.id.must_be_kind_of Integer
    end

    it "VIN must be a string" do
      my_driver.vin.must_be_kind_of String
    end

    it "VIN must be a 17 characters/numbers long" do
      my_driver.vin.length.must_equal 17
    end

  end

  describe "all method" do

    it "returns an array of all drivers" do

      drivers_array = Driver.all
      drivers_array.must_be_instance_of Array

      drivers_array.each do |driver|
        driver.class.must_equal Driver
      end

      drivers_array.length.must_equal(100)

      drivers_array[0].id.must_equal(1) # checking first element of array
      drivers_array[0].name.must_equal("Bernardo Prosacco")

      drivers_array[99].id.must_equal(100) # checking last element of array
      drivers_array[99].name.must_equal("Minnie Dach")

    end
  end

  describe "find method" do

    it "returns driver that exists" do
      Driver.find(3).wont_be_nil # non nil
    end

    it "can find the first driver from the CSV" do
      Driver.find(1).wont_be_nil
    end

    it "can find the last driver from the CSV" do
      Driver.find(100).wont_be_nil
    end
  end
  #
  describe "find trips" do

    it "returns trips that only this driver has taken" do
      driver_trips[0].trip_id.must_equal(1) # checking first element of array
    end

    it "checks lengths of driver trip array" do
      driver_trips.length.must_equal 9
    end

      # ideally we would spot check some more trip id's
      # here are some trip_ids we should see for this driver: 1,
      # 122, 124, 216, 417, 434, 439, 530, 553)
  end

  describe "get rating" do

    # retrieve an average rating for that driver based on all trips taken
    it "returns average rating for that driver based on all trips taken" do
    driver_ratings = []

    driver_trips.each do |line|
      driver_ratings << line.rating
    end

    avg_rating = (driver_ratings.inject{ |sum, n| sum + n }.to_f / driver_ratings.size).round(2)

    avg_rating.must_equal 2.33
    end

  end

  describe "to_s method" do

    it "returns string" do
      my_driver.to_s.must_be_kind_of String
    end
  end
end
