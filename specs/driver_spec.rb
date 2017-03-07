require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver.rb'
require_relative '../specs/spec_helper.rb'

describe Driver do
  describe "initialize" do
    it "takes an id, name, and VIN" do
      id = 5
      name = "Marisol Rosales"
      vin = "WBWSS52P9NEYLVDE9"
      driver = Driver.new(id, name, vin)
      driver.must_be_instance_of Driver
      driver.id.must_equal id
      driver.name.must_equal name
      driver.vin.must_equal vin
    end
  end
  # describe "Trip method" do
  #   before do
  #     @driver = Driver.new(@id = 5, @name = "Marisol", @vin = "WBWSS52P9NEYLVDE9")
  #   end
  #   it "driver.trip will return array" do
  #     @driver.trip.must_be_instance_of Array
  #   end
  describe "self.all" do
    before do
      @csv_driver = Driver.all
    end
    it "checks for an array" do
      @csv_driver.must_be_instance_of Array
    end
    it "checks every array is instance of Driver" do
      @csv_driver.each do |array|
        array.must_be_instance_of Driver
      end
    end
    it "checks correct length of csv driver file" do
        @csv_driver.length.must_equal 101
    end
  end


end
