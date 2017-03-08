require_relative 'spec_helper'

# Try to use let! :) instead of before

describe "Trip class" do
  let(:tripin) { RideShare::Trip.new(trip_id: 1337, driver_id: 1234, rider_id: 4321, date: "2017-07-17", rating: 5) }

  describe "Trip#initialize" do
    it "It takes a trip_hash argument" do
      tripin.must_be_instance_of RideShare::Trip
    end

    it "Has the correct values that were passed" do
      tripin.trip_id.must_equal 1337
      tripin.driver_id.must_equal 1234
      tripin.rider_id.must_equal 4321
      tripin.date.must_equal "2017-07-17"
      tripin.rating.must_equal 5
    end
  end

  xdescribe "Trip.all" do
    it "" do
    end
  end

  xdescribe "Trip.find" do
    it "" do
    end
  end

  xdescribe "Trip.find_many_rider" do
    it "" do
    end
  end

  xdescribe "Trip.find_many_driver" do
    it "" do
    end
  end

  describe "Trip.rider" do
    it "" do
    end
  end

  describe "Trip.driver" do
    it "" do
    end
  end
end
