
require_relative 'spec_helper'

describe "Rider" do

  describe "self.all" do

    it "returns an array" do
      all_riders = Rider.all
      all_riders.must_be_instance_of Array
    end

    it "all elements of array should be riders" do
      all_riders = Rider.all
      all_riders.each do |rider|
        rider.must_be_instance_of Rider
      end
    end

    it "includes first data line" do
      all_riders = Rider.all
      first_rider = all_riders.first
      first_rider.phone.must_equal "560.815.3059"
    end

    it "includes last data line" do
      all_riders = Rider.all
      last_rider = all_riders.last
      last_rider.name.must_equal "Miss Isom Gleason"
    end

    it "includes line 150 of array" do
      all_riders = Rider.all
      mid_rider = all_riders[149]
      mid_rider.rider_id.must_equal 150
    end
  end

  describe "self.find" do

    it "Should return an instance of rider" do
      my_rider = Rider.find(1)
      my_rider.must_be_instance_of Rider
    end

    it "Raises ArgumentError if id is not found." do
      proc { Rider.find(302) }.must_raise ArgumentError
    end
  end
end

describe "rider_trips(rider_id)" do

  it "Should return an array" do
    rider_trips = Rider.all
    rider_trips.must_be_instance_of Array
  end

  it "Should be an instance of rider" do
    rider_trips = Rider.all
    rider_trips.each do |rider|
      rider.must_be_instance_of Rider
    end
  end
  #edge?
  it "Check if rider has at least one trip" do
  end
end

  describe "drivers_per_rider" do

    it "Should return an array" do
      rider_drivers = Rider.all
      rider_drivers.must_be_instance_of Array
    end

    it "Should be an instance of Driver" do
      all_riders = Rider.all
      all_drivers = Driver.all
      all_riders.drivers_per_rider(5)
      my_driver = rider_drivers(1)
      my_driver.must_be_instance_of Driver
    end

  #edge?
  it "Should check if rider has multiple trips with a single driver." do
  end
end
