require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver.rb'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Driver" do

  before do
    @args = {id: 1, name: "Sahana", vehicle_id: "WBWSS52P9NEYLVDE9"}
    @driver = RideShare::Driver.new(@args)
  end

  describe "Driver#initialize" do

    it "Can be initialized" do
      @driver.must_be_instance_of RideShare::Driver
    end

    it "Takes a driver id" do
      @driver.must_respond_to :id
      @driver.id.must_equal @args[:id]
    end

    it "Raises Argument Error if driver id is not an integer" do
      proc {
        RideShare::Driver.new(id: "2", name: "Sahana", vehicle_id: "WBWSS52P9NEYLVDE9")
      }.must_raise ArgumentError
    end

    it "Takes a driver name" do
      @driver.must_respond_to :name
      @driver.name.must_equal @args[:name]
    end

    it "Raises Argument Error if driver name is not a string" do
      proc {
        RideShare::Driver.new(id: 2, name: 65, vehicle_id: "WBWSS52P9NEYLVDE9")
      }.must_raise ArgumentError
    end

    it "Takes a vehicle identification number" do
      @driver.must_respond_to :vehicle_id
      @driver.vehicle_id.must_equal @args[:vehicle_id]
    end

    it "Raises Argument Error if given incorrect vehicle id" do
      proc {
        RideShare::Driver.new(id: 2, name: "Sahana", vehicle_id: "765")
      }.must_raise ArgumentError

      proc {
        RideShare::Driver.new(id: 2, name: "Sahana", vehicle_id: 765)
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

  describe "Driver#all" do

    it "Can be called as a class method for the Driver class" do
      RideShare::Driver.must_respond_to :all
    end
  end

  describe "Driver#find" do

    it "Can be called as a class method for the Driver class" do
      RideShare::Driver.must_respond_to :find
    end
  end 
end
