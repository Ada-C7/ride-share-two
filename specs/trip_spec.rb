require_relative 'spec_helper'

describe "Trip tests" do
  let(:trip) { Trip.new({ id: 2, driver_id: 4, rider_id: 8, date: "2014-07-12", rating: 5 }) }

  describe "Trip#initialize" do
    it "Takes an ID, driver_id, rider_id, date, and rating" do
      trip.must_respond_to :id
      trip.id.must_equal 2

      trip.must_respond_to :driver_id
      trip.driver_id.must_equal 4

      trip.must_respond_to :rider_id
      trip.rider_id.must_equal 8

      trip.must_respond_to :date
      trip.date.must_equal "2014-07-12"

      trip.must_respond_to :rating
      trip.rating.must_equal 5
    end
  end
end
