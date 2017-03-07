require_relative 'spec_helper'

describe "Driver" do

  describe "initialize" do
    it "must be an instance of the Driver class" do
      kind_driver = Driver.new(1, "Santa Claus", 98109)
      kind_driver.must_be_instance_of Driver
    end
  end

  describe "trips" do
    it "returns the list of trip instances that only this driver has taken" do
      skip
      kind_driver = Driver.new(1, "Santa Claus", 98109)
      kind_driver.trips.must_be_instance_of Array
      # each trip (element) must be an Array, as trips is an array of arrays
    end
  end

  describe "Driver.all" do
    before do
      @drivers = Driver.all
    end

    it "returns all drivers from the CSV file" do
      @drivers.must_be_instance_of Array

      (@drivers.each { |i| return i }).must_be_instance_of Driver

      @drivers.length.must_equal 100
    end
  end

  describe "Driver.find" do
    before do
      @drivers = Driver.all
    end

    it "returns a driver that exists" do
      driver = Driver.find(@drivers[0].id)
      driver.must_be_instance_of Driver
    end

    it "can find the first driver from the CSV" do
      driver = Driver.find(0)
      driver.id.must_equal @drivers[0].id
    end

    it "can find the last driver from the CSV" do
      driver = Driver.find(100)
      driver.id.must_equal @drivers[-1].id
    end

    it "Raises an error for a driver that doesn't exist" do
        proc {
          Driver.find(111111)
        }.must_raise ArgumentError
    end
  end


  describe "rating" do

  end

end
