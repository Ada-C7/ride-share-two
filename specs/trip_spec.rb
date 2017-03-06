require_relative 'spec_helper'

describe "Trip class" do

  it "is an instance of Trip" do
    test_trip = Trip.new({id: 1, rider_id: 33, driver_id: 22, date: "01-02-0102", rating: 5})
    test_trip.must_be_kind_of Trip
  end

  describe "Initialize method" do
    it "" do

    end
  end

  describe "get_driver method" do
    it "" do

    end
  end

  describe "get_rider method" do
    it "" do

    end
  end

  describe "self.all_with_driver(id) method" do
    it "" do

    end
  end

  describe "self.all_with_rider(id) method" do
    it "" do

    end
  end

end
