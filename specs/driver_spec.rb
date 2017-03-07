# require 'minitest/autorun'
# require 'minitest/reporters'
# require_relative '../lib/driver'
require_relative 'spec_helper'

describe "Driver class" do
  it "initializes a Driver with ID, name, and vehicle identification number" do
    id = "54321"
    name = "Joe"
    vin = "9876"
    driver = RideShare::Driver.new(id, name, vin)

    driver.must_respond_to :id
    driver.id.must_equal id

    driver.must_respond_to :name
    driver.name.must_equal name
  end

  it "Retrieves the list of trip instances unique to one instance of driver" do

  end

  it "Retrieves an average rating for a driver based on all trips taken" do

  end

  it "Retrieve list of all drivers from the CSV file" do

  end

  it "Finds a specific driver using their numeric ID" do
    
  end

end
