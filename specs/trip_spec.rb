require_relative 'spec_helper'

describe "Trip_initialize" do

    it "Takes an ID, Rider ID, Driver ID, date, and a rating" do
      trip_id = 1337
      rider_id = 318
      driver_id = 54
      date = "date"
      rating = 4
      trip = RideShareTwo::Trip.new(trip_id, rider_id, driver_id, date, rating)

      trip.must_respond_to :trip_id
      trip_id.must_equal trip_id

      trip.must_respond_to :rider_id
      trip.rider_id.must_equal rider_id

      trip.must_respond_to :driver_id
      trip.driver_id.must_equal driver_id

      trip.must_respond_to :date
      trip.date.must_equal date

      trip.must_respond_to :rating
      trip.rating.must_equal rating
    end
end
