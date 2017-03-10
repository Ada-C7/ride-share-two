
require_relative 'spec_helper'

describe "Ride_share_two::Driver" do
  let(:drivers){Ride_share_two::Driver.all_drivers}
  describe "Driver#initialize" do
    it "Takes driver_id, driver_name, vin" do
      driver_id = "1"
      driver_name = "Bernardo Prosacco"
      vin = "WBWSS52P9NEYLVDE9"
      driver1 = Ride_share_two::Driver.new(driver_id, driver_name, vin)
      driver1.driver_id.must_equal "1"
      driver1.driver_name.must_equal "Bernardo Prosacco"
      driver1.vin.must_equal "WBWSS52P9NEYLVDE9"
    end

    it "Raises an ArgumentError when vin is not proper length" do
      proc {
        Ride_share_two::Driver.new(0, "Bernardo Prosacco", "aaaaaa")
      }.must_raise ArgumentError
    end

    it "Raises an ArgumentError when driver_id is not type of Integer" do
      proc {
        Ride_share_two::Driver.new(-1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE9")
      }.must_raise ArgumentError
    end
  end

  describe "#self.all_drivers" do
    it "retrieve driver information from CSV file" do
      drivers.length.must_equal 100

    end
  end
  describe "#self.find_driver" do
    it " finds a specific driver using their numeric ID" do
      Ride_share_two::Driver.find_driver(1).must_equal "Bernardo Prosacco"
    end

    it "has parameter of id as integer " do
      proc {
        Ride_share_two::Driver.find_driver("a")
      }.must_raise ArgumentError
    end
  end

  describe "#find_trips_for_driver" do
    it "retrieve the list of trip instances that only this driver has taken" do
      drivers[0].find_trips_for_driver.length.must_equal 9
    end
  end
  describe "#average_driver_rating" do
    it "finds a specific retrieve an average rating for that driver based on all trips taken" do
      Ride_share_two::Driver.all_drivers[0].average_driver_rating.must_equal 2
    end
  end
end
