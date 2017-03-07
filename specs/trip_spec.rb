require_relative 'spec_helper'
require_relative '../lib/trip'


describe "Trip tests" do
  describe "Trip#initialize" do
    it "takes an id, driver, rider, date, and rating" do
        new_trip = Trip.new("1234", "1", "56", "2016-04-05", 5)

        new_trip.must_respond_to :id
        new_trip.id.must_equal "1234"

        new_trip.must_respond_to :driver
        new_trip.driver.must_equal "1"

        new_trip.must_respond_to :rider
        new_trip.rider.must_equal "56"

        new_trip.must_respond_to :date
        new_trip.date.must_equal "2016-04-05"

        new_trip.must_respond_to :rating
        new_trip.rating.must_equal 5
    end
  end

end
