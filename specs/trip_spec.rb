# require 'minitest/autorun'
# require 'minitest/reporters'
# require 'minitest/skip_dsl'
# require_relative '../lib/'
# require 'csv'
# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require 'csv'
require_relative 'spec_helper'

describe "trip class" do

  it "requires 5 parameters for driver" do
    trip_id = 19992
    driver_id = 509
    rider_id = 5490
    date = "2016-04-05"
    rating = 4

    trip = RideShare::Trip.new(trip_id, driver_id, rider_id, date, rating)

    trip.must_respond_to :trip_id
    trip.trip_id.must_equal trip_id

    trip.must_respond_to :driver_id
    trip.driver_id.must_equal driver_id

    trip.must_respond_to :rider_id
    trip.rider_id.must_equal rider_id

    trip.must_respond_to :date
    trip.date.must_equal date

    trip.must_respond_to :rating
    trip.rating.must_equal rating
  end

  it "raises an ArgumentError if rating is more than 5" do
    proc {
      RideShare::Trip.new(111, 2, 500, "2016-04-05", 7)
    }.must_raise ArgumentError
  end

  it "raises an ArgumentError if rating is less than 1" do
    proc {
      RideShare::Trip.new(111, 2, 500, "2016-04-05", -1)
    }.must_raise ArgumentError
  end

  it "returns an array of all trips" do
  a = RideShare::Trip.all_trip_info
  a.must_be_instance_of Array
  end

  it "Everything in the array is an instance of Trip" do
    info = RideShare::Trip.all_trip_info
    info.each do |object|
      object.must_be_instance_of RideShare::Trip
    end
  end

  it "The trip_id, driver_id, rider_id, date, rating must match" do
    info = RideShare::Trip.all_trip_info
    info.first.trip_id.must_equal 1
    info.first.driver_id.must_equal 1
    info.first.rider_id.must_equal 54
    info.first.date.must_equal "2016-04-05"
    info.first.rating.must_equal 3
  end

  it "the elements match what's in the file" do
    info = RideShare::Trip.all_trip_info
    index = 0
    CSV.read('support/trips.csv') do |line|
    info[index].trip_id.must_equal line[0].to_i
    info[index].trip_id.must_equal line[1].to_i
    info[index].trip_id.must_equal line[2].to_i
    index += 1
    end
  end


end

  # trip_id,driver_id,rider_id,date,rating
  # 1,1,54,2016-04-05,3
  # 2,67,146,2016-01-13,5
  #
  # trip_id = 1
  # driver_id = 1
  # rider_id = 54
  # date = "2016-04-05"
  # rating = 3
