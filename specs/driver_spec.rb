require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver'
require_relative '../lib/trip'

describe "instantiating a Driver" do
  it "#id: returns the value of the @id instance variable" do
    driver = RideShare::Driver.new(109, "Bob", "1VIN")
    driver.id.must_equal 109
  end

  it "#name: returns the value of the @name instance variable" do
    driver = RideShare::Driver.new(109, "Bob", "1VIN")
    driver.name.must_equal "Bob"
  end

  it "#vin: returns the value of the @vin instance variable" do
    driver = RideShare::Driver.new(109, "Bob", "1VIN")
    driver.vin.must_equal "1VIN"
  end
end

describe "#get_trips: retrieving trips" do
  it "a driver takes no trips, should return empty array" do
    driver = RideShare::Driver.new(109, "Bob", "1VIN")
    driver.get_trips.must_equal []
  end

  it "if driver takes trips, should return an array of Trips the driver has taken" do
    driver = RideShare::Driver.new(109, "Bob", "1VIN")

    t1 = RideShare::Trip.new(20813)
    t2 = RideShare::Trip.new(38623)

    # this trip should not be included in trips
    t3 = RideShare::Trip.new(45656)

    driver.add_trip(t1)
    driver.add_trip(t2)

    driver.get_trips.must_equal [t1, t2]
  end
end

describe "#add_trips: driver trips should increment when add_trips is called" do
  it "add a trip to the driver's list of trips" do
    driver = RideShare::Driver.new(109, "Bob", "1VIN")
    t1 = RideShare::Trip.new(20813)
    
    # check that it's empty
    driver.get_trips.must_equal []
    # add the trip
    driver.add_trip(t1)
    # check the trip was added
    driver.get_trips.must_equal [t1]
  end

  it "add can be called multiple times" do
    driver = RideShare::Driver.new(109, "Bob", "1VIN")
    t1 = RideShare::Trip.new(20813)
    t2 = RideShare::Trip.new(38623)
    t3 = RideShare::Trip.new(45656)

    driver.add_trip(t1)
    driver.add_trip(t2)
    driver.add_trip(t3)

    driver.get_trips.must_equal [t1, t2, t3]
  end

  it "should only add a trip if it is of type Trip" do
    driver = RideShare::Driver.new(109, "Bob", "1VIN")
    t1 = RideShare::Trip.new(20813)

    # should add this trip only
    driver.add_trip(t1)

    # should NOT add any of these trips
    driver.add_trip("")
    driver.add_trip(nil)
    driver.add_trip(4)
    driver.add_trip(driver)

    driver.get_trips.must_equal [t1]
  end

  it "should accept an array of Trips" do
    driver = RideShare::Driver.new(109, "Bob", "1VIN")
    t1 = RideShare::Trip.new(20813)
    t2 = RideShare::Trip.new(38623)
    t3 = RideShare::Trip.new(45656)

    # should add this trip only
    driver.add_trip(t1)

    # should also add in these two trips
    driver.add_trip([t2, t3])

    driver.get_trips.must_equal [t1, t2, t3]
  end
end
