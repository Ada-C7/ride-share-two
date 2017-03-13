require 'simplecov'
SimpleCov.start

require 'csv'
require_relative '../specs/spec_helper'

describe "instantiating a Driver" do
  it "#driver_id: returns the value of the @driver_id instance variable" do
    driver = RideShare::Driver.new(driver_id: 109, name: "Bob", vin: "1VINR567YEDWERTYU")
    driver.driver_id.must_equal 109
  end

  it "#name: returns the value of the @name instance variable" do
    driver = RideShare::Driver.new(driver_id: 109, name: "Bob", vin: "1VINR567YEDWERTYU")
    driver.name.must_equal "Bob"
  end

  it "#vin: returns the value of the @vin instance variable" do
    driver = RideShare::Driver.new(driver_id: 109, name: "Bob", vin: "1VINR567YEDWERTYU")
    driver.vin.must_equal "1VINR567YEDWERTYU"
  end

  it "#vin is exactly 17 characters" do
    driver = RideShare::Driver.new(vin: "1VINR567YEDWERTYU")
    driver.vin.length.must_equal 17
  end

  it "raise an ArgumentError if vin is not 17 characters" do
    proc{
      driver = RideShare::Driver.new(vin: "1VINR567YEDWERT")
    }.must_raise ArgumentError
  end
end

describe "self.all" do
  it "list of all drivers stored in an array" do
    all_drivers = RideShare::Driver.all
    all_drivers.must_be_instance_of Array
  end

  it "The ID, name, and VIN of the first and last driver match the CSV file" do

      RideShare::Driver.all.first.driver_id.must_equal 1
      RideShare::Driver.all.first.name.must_equal "Bernardo Prosacco"
      RideShare::Driver.all.first.vin.must_equal "WBWSS52P9NEYLVDE9"

      RideShare::Driver.all.last.driver_id.must_equal 100
      RideShare::Driver.all.last.name.must_equal "Minnie Dach"
      RideShare::Driver.all.last.vin.must_equal "XF9Z0ST7X18WD41HT"
  
    index = 0
    CSV.read("./support/drivers.csv") do |each_driver|
      driver[index].driver_id.must_equal each_driver[:driver_id]
      driver[index].name.must_equal each_driver[:name]
      driver[index].vin.must_equal each_driver[:vin]
      index += 1
    end
  end
end

describe "self.find" do
  it "Return a Driver by #driver_id" do
    drivers = RideShare::Driver.find(90)

    drivers.must_be_instance_of RideShare::Driver
    drivers.driver_id.must_equal 90
    drivers.name.must_equal "Kristy Cremin"
    drivers.vin.must_equal "1F9FF7C27LJA041VR"
  end
end

describe "get_trips: retrieving trips" do
  it "returns an array of all the driver's trips" do
    driver = RideShare::Driver.new(driver_id: 25, name: "Briana Braun", vin: "SU9PYDRK6214WL15M")
    driver.get_trips.each do |trip|
      trip.driver_id.must_equal 25
    end
  end
end

describe "get average ratings" do
  it "#get_ratings: returns the sum of ratings" do
    driver = RideShare::Driver.new(driver_id: 25, name: "Briana Braun", vin: "SU9PYDRK6214WL15M")
    driver.get_ratings.must_equal 3.5
  end
end
