require_relative 'spec_helper'

describe "Ride_share_two::Trip" do
  describe "Trip#initialize" do
    it "Takes trip_id, driver_id,rider_id, date, rating" do
      trip_id = "1"
      driver_id = "1"
      rider_id = "54"
      date = "2016-04-05"
      rating = 3
      trip1 = Ride_share_two::Trip.new(trip_id, driver_id,rider_id, date, rating)
      trip1.trip_id.must_equal "1"

    end
    it "raises an ArgumentError if the rating is not within 1-5" do
      proc {
        Ride_share_two::Trip.new("1","1","54","2016-04-05",7)
      }.must_raise ArgumentError
    end
  end

  describe "#find_driver" do
    it "retrieves the associated driver instance through the driver ID" do
      trip1 = Ride_share_two::Trip.new("1","1","54","2016-04-05",3)
      trip1.find_driver.driver_name.must_equal "Bernardo Prosacco"
    end
  end

  describe "#find_rider" do
    it "retrieves the associated rider instance through the rider ID" do
      trip1 = Ride_share_two::Trip.new("1","1","54","2016-04-05",3)
      trip1.find_rider.name.must_equal "Gracie Emmerich"
    end
  end

  describe "#self_find_trips_for_riders" do
    it"retrieves the associated rider instance through the rider ID" do
      Ride_share_two::Trip.find_trips_for_rider("2").length.must_equal 1
    end

    describe "#self.find_trips_for_drivers" do
      it "find all trip instances for a given driver ID" do
        Ride_share_two::Trip.find_trips_for_drivers("1").length.must_equal 9
      end
    end

  end
end
