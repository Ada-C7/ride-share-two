require_relative 'spec_helper'
require_relative '../lib/trip'

describe "Trip class" do
  let (:trip_hash) { { id: 162, driver_id: 6, rider_id: 93, date: "2015-03-09", rating: 4 } }
  let (:trip)  { RideShare::Trip.new(trip_hash) }

  describe "#initialize method" do
    it "Initializes a new trip instance from the parameter" do
      trip.must_be_instance_of RideShare::Trip
      trip.must_respond_to :id
      trip.id.must_equal trip_hash[:id]
      trip.must_respond_to :driver_id
      trip.driver_id.must_equal trip_hash[:driver_id]
      trip.must_respond_to :rider_id
      trip.rider_id.must_equal trip_hash[:rider_id]
      trip.must_respond_to :date
      trip.date.must_equal trip_hash[:date]
      trip.must_respond_to :rating
      trip.rating.must_equal trip_hash[:rating]
    end

    it "Raises an argument error if the rating is invalid: must be in the range (1..5)" do
      proc {
        RideShare::Driver.new({ id: 162, driver_id: 6, rider_id: 93, date: "2015-03-09", rating: 9 })
      }.must_raise ArgumentError
    end

    it "Raises an argument error if the trip_hash parameter is incomplete" do
      proc {
        RideShare::Trip.new({})
      }.must_raise ArgumentError

      proc {
        RideShare::Trip.new({ id: 162, rider_id: 93, date: "2015-03-09", rating: 4 })
      }.must_raise ArgumentError

      proc {
        RideShare::Trip.new({ nick_name: "Betsy", rating: 4 })
      }.must_raise ArgumentError
    end

    it "Raises an argument error if the parameter is not hash" do
      proc {
        RideShare::Trip.new()
      }.must_raise ArgumentError

      proc {
        RideShare::Trip.new("162,6,93,2015-03-09,4")
      }.must_raise ArgumentError
    end
  end

  # describe "#find_driver method" do
  #   it "Retrieve the associated driver instance through the driver ID" do
  #     trips_by_rider = rider.trips.class
  #     trips_by_rider.must_equal Array
  #     trips_by_rider.length.must_equal 3
  #   end
  # end
  #
  # describe "#find_rider method" do
  #   it "Retrieve the associated rider instance through the rider ID" do
  #
  #   end
  # end
  #
  # describe "#self.all method" do
  #   it "Retrieve all trips from the CSV file" do
  #
  #   end
  # end
  #
  # describe "#self.trips_by_driver method" do
  #   it "Find all trip instances for a given driver ID" do
  #
  #   end
  # end
  #
  # describe "#self.trips_by_driver method" do
  #   it "Find all trip instances for a given rider ID" do
  #
  #   end
  # end
end
