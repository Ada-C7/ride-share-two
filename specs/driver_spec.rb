require_relative 'spec_helper'
require 'pry'

describe "Driver" do

  describe "initialize" do
    it "Raises an ArgumentError when VIN is not 17 characters" do
      proc {
        RideShare::Driver.new(driver_id: 150, name: "Kaitlin Ramirez", vin: "W09XNTZR9KT")
      }.must_raise ArgumentError
    end
  end

  describe "Driver.create_all_drivers" do
    let(:drivers) {RideShare::Driver.create_all_drivers}
    it "Returns an array of all accounts" do
      drivers.must_be_instance_of Array
    end

    it "The number of drivers is correct" do
      drivers.length.must_equal 100
    end
  end

  describe "Driver.find(driver_id)" do
    it "should return the driver_id that was passed through" do
      RideShare::Driver.find(1)[:driver_id].must_equal(1)
    end

    it "should return the vin that corresponds to the driver_id" do
      RideShare::Driver.find(50)[:vin].must_equal("1B6FU8M80MVDHHTMD")
    end

    it "should return the name that corresponds to the driver_id" do
      RideShare::Driver.find(100)[:name].must_equal("Minnie Dach")
    end
  end

  describe "Driver trips" do
    it "finds all the trips for a Driver in an Array" do
      # skip
      RideShare::Driver.new(driver_id: 50, name: "Maye Bauch", vin: "1B6FU8M80MVDHHTMD").trips.must_be_instance_of Array
    end

    it "finds all the trips for the first Driver" do
      # skip
      RideShare::Driver.new(driver_id: 1, name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9").trips.length.must_equal 9
    end

    it "finds all the trips for the last Driver" do
      # driver 100 does not have any trips. look out for your tests.
      # skip
      RideShare::Driver.new(driver_id: 100, name: "Minnie Dach", vin: "XF9Z0ST7X18WD41HT").trips.must_be_empty
    end

  end

end
