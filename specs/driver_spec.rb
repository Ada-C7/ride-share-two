# require 'minitest/autorun'
# require 'minitest/reporters'
# require_relative '../lib/driver'
require_relative 'spec_helper'

describe "Driver class" do
  it "initializes a Driver with ID, name, and vehicle identification number" do
    driver_id = "54321"
    name = "Joe"
    vin = "9876"
    driver = RideShare::Driver.new(driver_id, name, vin)

    driver.must_respond_to :driver_id
    driver.driver_id.must_equal driver_id

    driver.must_respond_to :name
    driver.name.must_equal name
  end

  it "Retrieves the list of trip instances unique to one instance of driver" do
    skip
  end

  it "Retrieves an average rating for a driver based on all trips taken" do
    skip
  end

  describe "self.all - Driver class method" do
    it "Retrieve list of all drivers from the CSV file" do
      # skip
      RideShare::Driver.all.must_be_instance_of Array, "This is not an array"
      puts RideShare::Driver.all
    end

    it "For first and last drivers, Driver ID and Driver VIN must match what's in CSV file" do
    end

  end
  it "Finds a specific driver using their numeric ID" do
    skip
  end

end
