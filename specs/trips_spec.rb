require_relative 'spec_helper'

describe "Trip" do
  describe "initialize" do

    let(:valid_trip) {Rideshare::Trip.new({ trip_id: 1,driver_id: 2,rider_id: 3,date: "today",rating: 4 }, :trip_id) }

    let(:no_driver_trip) {Rideshare::Trip.new({ trip_id: 1,rider_id: 3,date: "today",rating: 4 }, :trip_id) }

    let(:no_rider_trip) {Rideshare::Trip.new({ trip_id: 1, driver_id: 3,date: "today",rating: 4 }, :trip_id) }

    let(:no_trip_id) {Rideshare::Trip.new({ driver_id: 1,rider_id: 3,date: "today",rating: 4 }, :trip_id) }

    let(:weird_rating) {Rideshare::Trip.new({ trip_id: 1, driver_id: 1,rider_id: 3,date: "today",rating: 0 }, :trip_id) }


    it "has a driver id, rider id, trip id, date, rating a name of the right types" do
      valid_trip.driver_id.must_be_kind_of Integer
      valid_trip.rider_id.must_be_kind_of Integer
      valid_trip.trip_id.must_be_kind_of Integer
      valid_trip.date.must_be_kind_of String
    end

    it "properly stores the search variable as :id" do
      valid_trip.id.must_equal valid_trip.trip_id
    end

    it "raises an argument error if driver_id, trip_id, or rider_id are missing" do
      no_driver_trip.must_raise ArgumentError
      no_rider_trip.must_raise ArgumentError
      no_trip_id.must_raise ArgumentError
    end

    it "outputs a warning if :rating is outside acceptable range, but stores row with rating as nil" do
      proc{weird_rating}.must_output /.+/
    end
  end
end
