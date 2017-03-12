
require_relative 'spec_helper'

describe "Trip" do

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
  it "Raises ArgumentError if id is not found." do
    proc { find_trip = Trip.find(602) }.must_raise ArgumentError
  end
end

describe "trip_driver(driver_id)" do

  it "Should return the driver_id of a given trip" do

  end
end

describe "find_rider(rider_id)" do

  it "Should return rider_id for a given trip" do

  end
end

#edge?
describe "trips_by_driver" do

  it "Returns the number of trips on a specific day" do
  end

  it "Returns the rider id of a rider with multiple trips per driver instance"
end


describe "trips_by_rider" do

  it "Returns a trip with no rider? " do
  end

  it "Returns a rating for a given trip instance" do
  end

end
