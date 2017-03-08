require_relative 'spec_helper'

describe "Trip class" do
  let(:trip) {RideShare::Trip.new({trip_id: 1, driver_id: 2, rider_id: 2, date: "4/26/2017", rating: 5})}
  it "initializes with an id, a driver_id, a rider_id, a date, and a rating" do
      trip.id.must_equal 1

      trip.driver_id.must_equal 2

      trip.rider_id.must_equal 2

      trip.date.must_equal "4/26/2017"

      trip.rating.must_equal 5
  end

  it "has acceptable rating parameters - you can't initalize outside of 1 - 5" do
    # skip
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
    # skip
      RideShare::Trip.all.must_be_kind_of Array
  end

  it "can find the first trip from the csv" do
    # skip
    RideShare::Trip.find(1).date.must_equal "2016-04-05"
  end

  it "can find the last trip from the csv" do
    # skip
    RideShare::Trip.find(600).rating.must_equal 3
  end

  it "can find all trip instances for a given rider ID" do
    # skip
    RideShare::Trip.rider_find(1).length.must_equal 2
  end

  it "returns an error when asked to return a rider that does not exist" do
    # skip
    proc {
      RideShare::Trip.rider_find(601)
    }.must_raise ArgumentError
  end

  it "can find all trip instances for a given driver ID" do
    # skip
    RideShare::Trip.driver_find(1).length.must_equal 9
  end

  it "returns an error when asked to return a driver that does not exist" do
    # skip
    proc {
      RideShare::Trip.driver_find(154)
    }.must_raise ArgumentError
  end

  it "can return a driver instance for a given trip" do
    trip.driver_for_trip.id.must_equal 2
  end

  it "will raise an error if that driver does not exist" do
    initialization_hash = {
      id: 1,
      driver_id: 0,
      rider_id: 0,
      date: "4/26/2017",
      rating: 5
        }
    wrong_trip = RideShare::Trip.new(initialization_hash)

    proc {
      wrong_trip.driver_for_trip
    }.must_raise ArgumentError
  end

  it "can return a rider instance for a given trip" do
    trip.rider_for_trip.id.must_equal 2
  end

  it "will raise an error if that rider does not exist" do
    initialization_hash = {
      id: 1,
      driver_id: 2,
      rider_id: 0,
      date: "4/26/2017",
      rating: 5
        }
    wrong_trip = RideShare::Trip.new(initialization_hash)
    proc {
      wrong_trip.rider_for_trip
    }.must_raise ArgumentError
  end

end
