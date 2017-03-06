require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Driver" do

  describe "Driver#initialize" do
    before do
      driver_info = {
        id: 1,
        name: 'Bernardo Prosacco',
        vin: 'WBWSS52P9NEYLVDE9'
      }
      @new_driver = RideShare::Driver.new(driver_info)
    end

    it "initializes with 1 argument: a driver info hash" do
      @new_driver.must_be_instance_of RideShare::Driver
    end

    it "assigns instance variables: id, name, and vin" do
      @new_driver.id.must_equal 1
      @new_driver.name.must_equal 'Bernardo Prosacco'
      @new_driver.vin.must_equal 'WBWSS52P9NEYLVDE9'
    end
  end

  describe "Driver#all" do

    # lets work with let instead of before do - end
    let(:drivers) { RideShare::Driver.all('./support/drivers.csv') }

    # before do
    #   file = './support/drivers.csv'
    #   @drivers = RideShare::Driver.all(file)
    # end

    it "returns an array" do
      drivers.must_be_instance_of Array
    end

    it "has instances of drivers in the array" do
      drivers.each { |driver| driver.must_be_instance_of RideShare::Driver }
    end

    it "has the same number of driver instances as the csv file" do
      drivers.length.must_equal 100
    end
  end
end
