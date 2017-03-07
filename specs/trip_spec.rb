require_relative 'spec_helper'
require_relative '../lib/trip'

describe "Trip" do

  describe "#initialize" do
    it "Takes an ID, driver ID, raider ID, date, and rating" do
      id = 12345
      driver_id = 45678
      rider_id = 9876
      date = "2016-04-05"
      rating = 4
      trip = Trip.new(id, driver_id, rider_id, date, rating)

      trip.must_respond_to :id
      trip.id.must_equal id

      trip.must_respond_to :driver_id
      trip.driver_id.must_equal driver_id

      trip.must_respond_to :rider_id
      trip.rider_id.must_equal rider_id

      trip.must_respond_to :date
      trip.date.must_equal date

      trip.must_respond_to :rating
      trip.rating.must_equal rating
    end

    it "Is a kind of Driver" do
      id = 12345
      driver_id = 45678
      rider_id = 9876
      date = "2016-04-05"
      rating = 4
      trip = Trip.new(id, driver_id, rider_id, date, rating)

      trip.must_be_kind_of Trip
    end
  end

end
