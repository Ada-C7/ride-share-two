require_relative 'spec_helper'
require_relative '../lib/driver'

describe "Driver tests" do
  describe "Driver#initialize" do
    it "takes an id, name, and vin" do
        new_driver = Driver.new("3", "Bob Jones", "L1CXMYNZ3MMGTTYWU")

        new_driver.must_respond_to :id
        new_driver.id.must_equal "3"

        new_driver.must_respond_to :name
        new_driver.name.must_equal "Bob Jones"

        new_driver.must_respond_to :vin
        new_driver.vin.must_equal "L1CXMYNZ3MMGTTYWU"
    end

    it "raises an error if vin is not 17 characters long" do

      proc {Driver.new("3", "Bob Jones", "12345")
      }.must_raise ArgumentError

    end

  end


  describe "Driver.all" do
    it "Returns an array of all drivers" do
      drivers_array = Driver.all

      drivers_array.class.must_equal Array

    end

    it "Everything in array is a Driver" do
      drivers_array = Driver.all

      drivers_array.each do |element|
        element.must_be_instance_of Driver
      end
    end

  end

  describe "Driver#trips" do
    it "returns an array of trips taken" do
      new_driver = Driver.new(1, "Jan Brown", "HFG347DJ84HKX9872")

      new_driver.trips.class.must_equal Array

    end

    it "each element in the array is a trip" do
      new_driver = Driver.new(7, "Lizeth Dickens", "W09XNTZR9KTFK10WW")

      new_driver.trips.each do |element|
        element.must_be_instance_of Trip
      end

    end

  end

end
