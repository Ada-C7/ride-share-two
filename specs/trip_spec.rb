require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/trip'

describe "RideShare::Trip" do
  describe "Trip#initialize" do
    it "creates a new instance of trip" do
    end
    it "can pass in an id" do
    end
    it "can pass in a driver_id" do
    end
    it "can pass in a rider_id" do
    end
    it "can pass in a date" do
    end
    it "can pass in rating" do
    end
    it "can create a new trip with a missing date" do
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
