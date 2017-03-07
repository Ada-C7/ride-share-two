require_relative 'spec_helper'

describe "Driver class" do

  it "is an instance of Driver" do
    test_driver = Driver.new({id: 1, name: "George", vehicle_id: 3313})
    test_driver.must_be_kind_of Driver
  end

  describe "Initialize method" do
    it "" do
      # nada?
    end
  end

  describe "get_trips method" do
    before do
      @driver = Driver.new({id: 1, name: "Bernardo Prosacco", vehicle_id: "WBWSS52P9NEYLVDE9"})
      @trips = Trip.all_with_driver(@driver.id)
    end

    it "returns an array" do
      @trips.must_be_kind_of Array
    end
    it "all elements are Trip instances" do
      @trips.each do |trip|
        trip.must_be_kind_of Trip
      end
    end
    it "all Trips in array have same driver_id as id passed in" do
      this_id = @driver.id
      @trips.each do |trip|
        trip.driver_id.must_equal this_id
      end
    end
  end

  describe "average_rating method" do
    it "returns a float" do

    end
    it "float is >= 1.0" do

    end
    it "float is <= 5.0" do

    end
  end

  describe "self.all method" do
    it "returns an array" do
      all_drivers = Driver.all
      all_drivers.must_be_kind_of Array
    end
    it "all elements are Driver instances" do
      all_drivers = Driver.all
      all_drivers.each do |driver|
        driver.must_be_kind_of Driver
      end
    end
  end

  describe "self.find(id) method" do
    it "returns a Driver instance" do

    end
    it "Driver's id matches the id passed in" do

    end
  end

end
