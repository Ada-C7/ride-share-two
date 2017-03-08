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
