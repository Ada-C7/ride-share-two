require_relative 'spec_helper'

describe "Driver" do

  before do
    @args = {driver_id: 1, name: "Sahana", vin: "WBWSS52P9NEYLVDE9"}
    @driver = RideShare::Driver.new(@args)
  end

  describe "Driver#initialize" do

    it "Can be initialized" do
      @driver.must_be_instance_of RideShare::Driver
    end

    it "Takes a driver id" do
      @driver.must_respond_to :driver_id
      @driver.driver_id.must_equal @args[:driver_id]
    end

    it "Raises Argument Error if driver id is not an integer" do
      proc {
        RideShare::Driver.new(driver_id: "2", name: "Sahana", vin: "WBWSS52P9NEYLVDE9")
      }.must_raise ArgumentError
    end

    it "Takes a driver name" do
      @driver.must_respond_to :name
      @driver.name.must_equal @args[:name]
    end

    it "Raises Argument Error if driver name is not a string" do
      proc {
        RideShare::Driver.new(driver_id: 2, name: 65, vin: "WBWSS52P9NEYLVDE9")
      }.must_raise ArgumentError
    end

    it "Takes a vehicle identification number" do
      @driver.must_respond_to :vin
      @driver.vin.must_equal @args[:vin]
    end

    it "Raises Argument Error if given incorrect vehicle id" do
      proc {
        RideShare::Driver.new(driver_id: 2, name: "Sahana", vin: "765")
      }.must_raise ArgumentError

      proc {
        RideShare::Driver.new(driver_id: 2, name: "Sahana", vin: 765)
      }.must_raise ArgumentError
    end
  end

  describe "Driver#trips" do

    it "Can be called on an instance of the Driver class" do
      @driver.must_respond_to :trips
    end

  end

  describe "Driver#rating" do

    it "Can be called on an instance of the Driver class" do
      @driver.must_respond_to :rating
    end
  end

  describe "Driver.all" do

    it "Can be called as a class method for the Driver class" do
      RideShare::Driver.must_respond_to :all
    end

    it "Returns an array of all driver information" do
      RideShare::Driver.all.must_be_instance_of Array

      RideShare::Driver.all.each do |driver|
        driver.must_be_instance_of RideShare::Driver
      end
    end

    it "Contains the correct amount of drivers" do
      RideShare::Driver.all.length.must_equal 100
    end

    it "Matches the driver id, name, and vehicle id number of the first and last drivers in csv" do
      RideShare::Driver.all.first.driver_id.must_equal 1
      RideShare::Driver.all.first.name.must_equal "Bernardo Prosacco"
      RideShare::Driver.all.first.vin.must_equal "WBWSS52P9NEYLVDE9"

      RideShare::Driver.all.last.driver_id.must_equal 100
      RideShare::Driver.all.last.name.must_equal "Minnie Dach"
      RideShare::Driver.all.last.vin.must_equal "XF9Z0ST7X18WD41HT"
    end

  end

  describe "Driver.find" do

    it "Can be called as a class method for the Driver class" do
      RideShare::Driver.must_respond_to :find
    end

    it "Returns a driver who exists" do
      driver_id = 7
      driver = RideShare::Driver.find(driver_id)
      driver.must_be_instance_of RideShare::Driver
      driver.driver_id.must_equal driver_id
    end

    it "Can find the first driver from the CSV" do
      driver_id = 1
      driver = RideShare::Driver.find(driver_id)
      driver.must_be_instance_of RideShare::Driver
      driver.driver_id.must_equal driver_id
    end

    it "Can find the last driver from the CSV" do
      driver_id = 100
      driver = RideShare::Driver.find(driver_id)
      driver.must_be_instance_of RideShare::Driver
      driver.driver_id.must_equal driver_id
    end

    it "Raises an error for a driver who doesn't exist" do
      proc {
        RideShare::Driver.find(1111)
      }.must_raise RideShare::InvalidDriver
    end

  end
end
