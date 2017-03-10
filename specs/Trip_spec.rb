
require_relative 'spec_helper'

describe "Trip" do

  # before do
  #   @name
  #   @id
  #   @vehichle_id
  # end

  describe "self.all" do

    it "returns an array" do
      all_trips = Trip.all
      all_trips.must_be_instance_of Array
    end

    it "all elements of array should be trips" do
      all_trips = Trip.all
      all_trips.each do |trip|
        trip.must_be_instance_of Trip
      end
    end

    it "includes first data line" do
      all_trips = Trip.all
      first_trip = all_trips.first
      first_trip.rider_id.must_equal "54"
    end

    it "includes last data line" do
      all_trips = Trip.all
      last_trip = all_trips.last
      last_trip.date.must_equal "2016-04-25"
    end

    it "includes line 300 of array" do
      all_trips = Trip.all
      mid_trip = all_trips[299]
      mid_trip.driver_id.must_equal "90"
    end
  end

  describe "self.find" do
    it "Should return an instance of trip" do
      my_trip = Trip.find(1)
      my_trip.must_be_instance_of Trip
    end
  end
  #
  #  it "Raises ArgumentError if id is not found." do
  #    proc { find_trip = Trip.find(602) }.must_raise ArgumentError
  #   end
   end
