require_relative 'spec_helper'

describe "Trip class" do

  it "is an instance of Trip" do
    test_trip = Trip.new({id: 1, rider_id: 33, driver_id: 22, date: "01-02-0102", rating: 5})
    test_trip.must_be_kind_of Trip
  end

  describe "Initialize method" do
    it "" do
      # nada?
    end
  end

  describe "get_driver method" do
    it "returns an instance of Driver" do

    end
    it "Driver's id matches driver_id on instance of Trip" do

    end
  end

  describe "get_rider method" do
    it "returns an instance of Rider" do

    end
    it "Rider's id matches rider_id on instance of Trip" do

    end
  end

  describe "self.all_with_driver(id) method" do
    it "returns array" do

    end
    it "all items in array must be Trips" do

    end
    it "all driver_ids of Trips in array must match the id passed in" do

    end
  end

  describe "self.all_with_rider(id) method" do
    it "returns array" do

    end
    it "all items in array must be Trips" do

    end
    it "all rider_ids of Trips in array must match the id passed in" do

    end
  end

end
