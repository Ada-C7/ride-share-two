require_relative 'spec_helper'

describe "Trip" do
  describe "constructor" do
    before do
      @id = 68
      @rider_id = 78
      @driver_id = 88
      @date = '2017-8-03' #can't be a future date
      @rating = 3 # int, 1-5
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

    it "raises an argument error if rating is not initialized with an integer" do
      proc {
        RideShare::Trip.new(rating: '3')
      }.must_raise ArgumentError
    end

    it "raises an invalid rating error if rating is not above 1" do
      invalid_rating = 0

      proc {
        RideShare::Trip.new(rating: invalid_rating)
      }.must_raise RideShare::InvalidRatingError
    end

    it "raises an invalid rating error if rating is not below 5" do
      invalid_rating = 6

      proc {
        RideShare::Trip.new(rating: invalid_rating)
      }.must_raise RideShare::InvalidRatingError
    end

    it "accepts a rating of 1" do
      rating = 1
      trip = RideShare::Trip.new(rating: rating)
      trip.rating.must_equal rating
    end

    it "accepts a rating of 5" do
      rating = 5
      trip = RideShare::Trip.new(rating: rating)
      trip.rating.must_equal rating
    end
  end
end
