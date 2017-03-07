require_relative 'spec_helper'

describe "Trip" do
  describe "initialize" do
    it "takes an id, driver_id, rider_id, date, and rating" do
      new_trip = Trip.new(1234, 1, 56, "2016-04-05", 5)

      new_trip.must_respond_to :id
      new_trip.id.must_equal 1234

      new_trip.must_respond_to :driver
      new_trip.driver_id.must_equal 1

      new_trip.must_respond_to :rider
      new_trip.rider_id.must_equal 56

      new_trip.must_respond_to :date
      new_trip.date.must_equal "2016-04-05"

      new_trip.must_respond_to :rating
      new_trip.rating.must_equal 5
    end

    it "must be an instance of the Trip class" do
      great_trip = Trip.new(1234, 1, 56, "2016-04-05", 5)
      great_trip.must_be_instance_of Trip
    end
  end # end of describe initialize

  describe "Trip.all" do
    before do
      @trips = Trip.all
    end

    it "it returns all the trips from the CSV file" do
      @trips.must_be_instance_of Array

      (@trips.each { |i| return i }).must_be_instance_of Trip

      @trips.length.must_equal 600
    end
  end # end of describe Trip.all method

end # end of describe Trip
