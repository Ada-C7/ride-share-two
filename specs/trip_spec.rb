require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/trip'
Minitest::Reporters.use!

describe "Trip class" do
  describe "Trip#initialize" do
    it "Creates new instance of Trip class"do
    trip_hash = {trip_id: 123, rider_id: 2, driver_id: 34, date: "03/06/2017", rating: 4}
    RideShare::Trip.new(trip_hash).class.must_equal RideShare::Trip
    end
    it "Raise ArgumentError if passing parameter is not a hash" do
      proc {
        RideShare::Trip.new([1,2,3,4,5])
      }.must_raise ArgumentError
    end
    it "Has driver_id, rider_id, trip_id , rating and date as initial values" do
      trip_hash = {trip_id: 123, rider_id: 2, driver_id: 34, date: "03/06/2017", rating: 4}
      trip = RideShare::Trip.new(trip_hash)
      trip.must_respond_to :trip_id
      trip.must_respond_to :rider_id
      trip.must_respond_to :driver_id
      trip.must_respond_to :date
      trip.must_respond_to :rating
    end
  end # end of initialize method test

  describe "Trip#driver" do
    it " Return instance of class Driver" do
      trip_hash = {trip_id: 123, rider_id: 2, driver_id: 34, date: "03/06/2017", rating: 4}
      trip = RideShare::Trip.new(trip_hash)
      trip.driver.class.must_equal RideShare::Driver
    end
    it "Id of returned driver must be the same as instance variable @driver_id of Trip class" do
      trip_hash = {trip_id: 123, rider_id: 2, driver_id: 34, date: "03/06/2017", rating: 4}
      trip = RideShare::Trip.new(trip_hash)
      trip.driver.driver_id.must_equal trip.driver_id
    end
    it "Raise ArgumentError if driver with id is not found" do
      proc{
        trip_hash = {trip_id: 123, rider_id: 2, driver_id: 50000, date: "03/06/2017", rating: 4}
        trip = RideShare::Trip.new(trip_hash)
        trip.driver
      }.must_raise ArgumentError
    end
  end # end of rider method

  describe "Trip#rider" do
    it "Return instance of class Rider" do
      trip_hash = {trip_id: 123, rider_id: 2, driver_id: 34, date: "03/06/2017", rating: 4}
      trip = RideShare::Trip.new(trip_hash)
      trip.rider.class.must_equal RideShare::Rider
    end
    it "Id of returned rider must be the same as instance variable @rider_id of Trip class" do
      trip_hash = {trip_id: 123, rider_id: 2, driver_id: 34, date: "03/06/2017", rating: 4}
      trip = RideShare::Trip.new(trip_hash)
      trip.rider.rider_id.must_equal trip.rider_id
    end
    it "Raise ArgumentError if rider with id is not found" do
      proc{
        trip_hash = {trip_id: 123, rider_id: 200000, driver_id: 50000, date: "03/06/2017", rating: 4}
        trip = RideShare::Trip.new(trip_hash)
        trip.rider
      }.must_raise ArgumentError
    end
  end

end
