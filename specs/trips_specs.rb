require_relative 'spec_helper'

describe "Trip initialize" do
  it "Takes trip_id, driver_id, rider_id, date, rating" do

    trip_id = 1
    driver_id = 1
    rider_id = 54
    date = 2016-04-05
    rating = 3
    trip = RideShare::Trip.new(trip_id, driver_id, rider_id, date, rating)

    trip.must_respond_to :trip_id
    trip.trip_id.must_equal trip_id

    trip.must_respond_to :driver_id
    trip.driver_id.must_equal driver_id

    trip.must_respond_to :rider_id
    trip.rider_id.must_equal rider_id

    trip.must_respond_to :date
    trip.date.must_equal date

    trip.must_respond_to :rating
    trip.rating.must_equal rating
  end
end

describe "Trip.all" do

  before do
    @trip_array = RideShare::Trip.all
  end

  it "Returns an array of all accounts" do
    @trip_array.must_be_instance_of Array
  end
end
