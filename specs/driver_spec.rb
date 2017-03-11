require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
require_relative '../lib/driver'
require_relative '../lib/trips'

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
#
# describe "Driver.all" do
#   it "all drivers stored in array of hashes" do
#     all_drivers = RideShare::Driver.all
#     all_drivers.must_be_instance_of Array
#   end
# end
  # it "The ID, name, and VIN of the first and last driver match the CSV file" do
  #
  #     RideShare::Driver.all.first.driver_id.must_equal 1
  #     RideShare::Driver.all.first.name.must_equal "Bernardo Prosacco"
  #     RideShare::Driver.all.first.vin.must_equal "WBWSS52P9NEYLVDE9"
  #
  #     RideShare::Driver.all.last.driver_id.must_equal 100
  #     RideShare::Driver.all.last.name.must_equal "Minnie Dach"
  #     RideShare::Driver.all.last.vin.must_equal "XF9Z0ST7X18WD41HT"
  #
  #   index = 0
  #   CSV.read("./support/drivers.csv") do |each_driver|
  #     driver[index].driver_id.must_equal each_driver[:driver_id]
  #     driver[index].name.must_equal each_driver[:name]
  #     driver[index].vin.must_equal each_driver[:vin]
  #     index += 1
  #   end
#   # end
# end
#
# describe "#get_trips: retrieving trips" do
#   it "a driver takes no trips, should return empty hash" do
#     driver = RideShare::Driver.new(driver_id: 109, name: "Bob", vin: "1VINR567YEDWERTYU")
#     driver.get_trips.must_equal {}
#   end
#
#   it "if driver takes trips, should return an array of Trips the driver has taken" do
#     driver = RideShare::Driver.new(driver_id: 109, name: "Bob", vin: "1VINR567YEDWERTYU")
#
#     t1 = RideShare::Trip.new(20813)
#     t2 = RideShare::Trip.new(38623)
#
#     # this trip should not be included in trips
#     t3 = RideShare::Trip.new(45656)
#     driver.add_trip(t1)
#     driver.add_trip(t2)
#
#     driver.get_trips.must_equal [t1, t2]
#   end
# end
#
# describe "#add_trips: driver trips should increment when add_trips is called" do
#   it "add a trip to the driver's list of trips" do
#     driver = RideShare::Driver.new(driver_id: 109, name: "Bob", vin: "1VINR567YEDWERTYU")
#     t1 = RideShare::Trip.new(20813)
# #
#     # checks that it's empty
#     driver.get_trips.must_equal []
#     # add the trip
#     driver.add_trip(t1)
#     # checks the trip was added
#     driver.get_trips.must_equal [t1]
#   end
# #
#   it "add can be called multiple times" do
#     driver = RideShare::Driver.new(driver_id: 109, name: "Bob", vin: "1VINR567YEDWERTYU")
#     t1 = RideShare::Trip.new(20813)
#     t2 = RideShare::Trip.new(38623)
#     t3 = RideShare::Trip.new(45656)
#
#     driver.add_trip(t1)
#     driver.add_trip(t2)
#     driver.add_trip(t3)
#
#     driver.get_trips.must_equal [t1, t2, t3]
#   end
# end
#
# describe "Driver.find" do
#   it "Return a Driver by #driver_id" do
#     drivers = RideShare::Driver.find(90)
#
#     drivers.must_be_instance_of RideShare::Driver
#     drivers.driver_id.must_equal 90
#     drivers.name.must_equal "Kristy Cremin"
#     drivers.vin.must_equal "1F9FF7C27LJA041VR"
#   end
# end
