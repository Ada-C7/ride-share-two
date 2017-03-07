require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'csv'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/ride-share-driver'

describe "RideShare::Driver" do

  let(:my_driver) { RideShare::Driver.new(2,"name", "WBWSS52P9NEYLVDE9")}

  describe "initialize method" do

    it "must be an instance of Driver class" do
      my_driver.must_be_instance_of RideShare::Driver
    end

    it "name must be a string" do
      my_driver.name.must_be_kind_of String
    end

    it "id must be a number" do
      my_driver.id.must_be_kind_of Integer
    end

    it "VIN must be a string" do
      my_driver.vin.must_be_kind_of String
    end

    it "VIN must be a 17 characters/numbers long" do
      my_driver.vin.length.must_equal 17
    end

  end

  describe "all method" do

    it "returns an array of all drivers" do

      drivers_array = RideShare::Driver.all
      drivers_array.must_be_instance_of Array

      drivers_array.each do |driver|
        driver.class.must_equal RideShare::Driver
      end

      drivers_array.length.must_equal(100)

      drivers_array[0].id.must_equal(1) # checking first element of array
      drivers_array[0].name.must_equal("Bernardo Prosacco")

      drivers_array[99].id.must_equal(100) # checking last element of array
      drivers_array[99].name.must_equal("Minnie Dach")

    end
  end

  describe "find method" do

    it "returns driver that exists" do
      RideShare::Driver.find(3).wont_be_nil # non nil
    end

    it "can find the first driver from the CSV" do
      RideShare::Driver.find(1).wont_be_nil
    end

    it "can find the last driver from the CSV" do
      RideShare::Driver.find(100).wont_be_nil
    end
  end

  describe "to_s method" do

    it "returns string" do
      my_driver.to_s.must_be_kind_of String
    end
  end
end
