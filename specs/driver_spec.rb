require_relative 'spec_helper'

describe "Driver" do

  describe "initialize" do
    it "must be an instance of the Driver class" do
      kind_driver = Driver.new(1, "Santa Claus", 98109)
      kind_driver.must_be_instance_of Driver
    end
  end

  describe "trips" do
    it "text" do
      kind_driver = Driver.new(1, "Santa Claus", 98109)
      kind_driver.trips.must_be_instance_of Array
      # each trip (element) must be an Array, as trips is an array of arrays
    end
  end

  describe "all" do

  end

  describe "find" do

  end

  describe "rating" do

  end

end
