require_relative 'spec_helper'

describe "Trip" do
  describe "constructor" do
    before do
      @id = 68
      @rider_id = 78
      @driver_id = 88
      @date = '2017-8-03' #can't be a future date
      @rating = 5 # int, 1-5
    end

    let (:trip) {RideShare::Trip.new(id: @id, rider_id: @rider_id,
      driver_id: @driver_id, date: @date, rating: @rating )}

    it "can be instantiated" do
      trip.must_be_instance_of RideShare::Trip
    end

    it "takes an id, rider_id, driver_id, date, and rating" do
      trip.must_respond_to :id
      trip.id.must_equal @id

      trip.must_respond_to :rider_id
      trip.rider_id.must_equal @rider_id

      trip.must_respond_to :driver_id
      trip.driver_id.must_equal @driver_id

      trip.must_respond_to :date
      trip.date.must_equal @date

      trip.must_respond_to :rating
      trip.rating.must_equal @rating
    end
  end
end
