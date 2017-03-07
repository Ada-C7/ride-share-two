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

end
