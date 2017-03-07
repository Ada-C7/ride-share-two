require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/trip'

describe "RideShare::Trip" do
  describe "Trip#initialize" do
    before do
      trip = RideShare::Trip.new({id: 13, driver_id: 83,rider_id: 298, date: "2015-05-27", rating: 5})
    end
    it "creates a new instance of trip" do
      trip.must_be_instance_of RideShare::Trip
    end
    it "passes in the id" do
      trip.id.must_equal 13
    end
    it "passes in the driver_id" do
      trip.driver_id.must_equal 83
    end
    it "passes in the rider_id" do
      trip.rider_id.must_equal 298
    end
    it "passes in the date" do
      trip.date.must_equal "2015-05-27"
    end
    it "passes in the rating" do
      trip.rating.must_equal 5
    end
    it "can create a new trip with a missing date" do
    skip
    end
  end

  describe "Trip#all" do
    it "returns an array" do
    end
    it "each returned element is a trip instances" do
    end
    it "returns the correct number of elements" do
    end
    it "correctly reads in the first row of the CSV file" do
    end
    it "correctly reads in the last row of the CSV file" do
    end
  end

  describe "Trip#trips_rode(rider_id)" do
    it "returns an array" do
    end
    it "each returned element is a trip instances" do
    end
  end

  describe "Trip#trips_driver(driver_id)" do
    it "returns an array" do
    end
    it "each returned element is a trip instances" do
    end
  end

  describe "Trip#find_driver" do
    it "returns an instance of driver" do
    end
    it "returns correct instance of driver" do
    end
  end

  describe "Trip#find_rider" do
    it "returns an instance of rider" do
    end
    it "returns correct instance of rider" do
    end
  end
end
