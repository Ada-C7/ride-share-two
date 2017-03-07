require_relative 'spec_helper'

describe "Trip class" do
  it "initializes with an id, a driver_Id, a rider_id, a date, and a rating" do
    initialization_hash = {
      id: 1,
      driver_id: 2,
      rider_id: 2,
      date: "4/26/2017",
      rating: 5
        }
      trip = RideShare::Trip.new(initialization_hash)

      trip.id.must_equal 1

      trip.driver_id.must_equal 2

      trip.rider_id.must_equal 2

      trip.date.must_equal "4/26/2017"

      trip.rating.must_equal 5
  end

  it "has acceptable rating parameters - you can't initalize outside of 1 - 5" do
    skip
    initialization_hash = {
      id: 1,
      driver_id: 2,
      rider_id: 2,
      date: "4/26/2017",
      rating: 10
        }
      proc {
        trip = RideShare::Trip.new(initialization_hash)
      }.must_raise ArgumentError
  end

  it "returns a list of trips when you call .all" do
    skip
      RideShare::Trip.all.must_be_kind_of Array
  end

  it "can find the first trip from the csv" do
    skip
    RideShare::Trip.find(1).must_equal [1, 1, 54, "2016-04-05", 3]
  end

  it "can find the last trip from the csv" do
    skip
    RideShare::trip.find(600).must_equal [600, 61, 168, "2016-04-25", 3]
  end

  it "can find all trip instances for a given rider ID" do
    skip
  end

  it "can find all trip instances for a given driver ID" do
    skip
  end
end
