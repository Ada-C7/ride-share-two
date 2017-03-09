
require_relative 'spec_helper'


describe "Driver" do

  # before do
  # #   @name
  # #   @id
  # #   @vehichle_id
  #     @driver_id = driver_id
  # end

  describe "self.all" do

    it "returns an array" do
      all_drivers = Driver.all
      all_drivers.must_be_instance_of Array
    end

    it "all elements of array should be drivers" do
      all_drivers = Driver.all
      all_drivers.each do |driver|
        driver.must_be_instance_of Driver
      end
    end
    it "includes first data line" do
      all_drivers = Driver.all
      first_driver = all_drivers.first
      first_driver.name.must_equal "Bernardo Prosacco"
    end

    it "includes last data line" do
      all_drivers = Driver.all
      last_driver = all_drivers.last
      last_driver.name.must_equal "Minnie Dach"

    end
    it "includes line 50 of array" do
      all_drivers = Driver.all
      mid_driver = all_drivers[49]
      mid_driver.name.must_equal "Maye Bauch"
      mid_driver.driver_id.must_equal 50
    end
  end


  describe "self.find" do
    it "Should return an instance of driver" do
      my_driver = Driver.find(1)
      my_driver.must_be_instance_of Driver
    end
  end

  it "Should raise ArgumentError if id is not found." do
    proc { my_driver = Driver.find(300) }.must_raise ArgumentError
  end
end

describe "driver_trips" do

  it "all elements of array should be trip instances" do
    all_drivers = Driver.all
    driver_trips = Trip.all
    driver_trips.must_be_instance_of Array
  end

  describe "driver_rating_test" do

    it "AVG Should return an float" do
      #all_drivers = Driver.all
      driver_trips = Trip.all
      trips = driver_trips
      ratings = []
      ratings = trips.map { |trip| trip.rating.to_f }
      #(@driver_id)
      average_rating = ratings.inject(0.0) { |sum, el| sum + el } / ratings.size
      average_rating.must_be_instance_of Float
      end
    end
  end






  # my_driver = Driver.new( {name: "Olivia", id: 1, vehicle_id: "7GD5"} )
