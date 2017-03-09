require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'csv'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../ride-share'
require_relative 'spec-helper'

describe "RideShare::Trips" do

  let(:trips) { Trips.new(2, 4, 6, 2016-12-19, 3)}

  describe "initialize method" do

    it "must be an instance of Trips class" do
      trips.must_be_instance_of Trips
    end

    it "trip id must be a number" do
      trips.trip_id.must_be_kind_of Integer
    end

    it "driver id must be a number" do
      trips.driver_id.must_be_kind_of Integer
    end

    it "rider id must be a number" do
      trips.rider_id.must_be_kind_of Integer
    end

    it "rating must be a number between 1 and 5" do
      trips.rating.must_be_kind_of Integer
      assert(trips.rating <= 5)
      assert(trips.rating >= 1)
    end

  end

  describe "all method" do

    it "returns an array of all trips" do

      trips_array = Trips.all
      trips_array.must_be_instance_of Array

      trips_array.each do |trips|
        trips.class.must_equal Trips
      end

      trips_array.length.must_equal(600)

      trips_array[0].trip_id.must_equal(1) # checking first element of array
      trips_array[0].driver_id.must_equal(1)
      trips_array[0].rider_id.must_equal(54)
      trips_array[0].date.must_equal("2016-04-05")
      trips_array[0].rating.must_equal(3)

      trips_array[599].trip_id.must_equal(600) # checking last element of array
      trips_array[599].driver_id.must_equal(61)
      trips_array[599].rider_id.must_equal(168)
      trips_array[599].date.must_equal("2016-04-25")
      trips_array[599].rating.must_equal(3)

    end
  end

  describe "find method" do

    it "returns trip that exists" do
      Trips.find(3).wont_be_nil # non nil
    end

    it "can find the first trip from the CSV" do
      Trips.find(1).wont_be_nil
    end

    it "can find the last trip from the CSV" do
      Trips.find(600).wont_be_nil
    end

    it "nonexistent trip must be nil" do
      Trips.find(800).must_be_nil
    end

  end

  describe "to_s method" do

    it "returns string" do
      trips.to_s.must_be_kind_of String
    end
  end
end
