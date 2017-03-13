require_relative 'spec_helper'
require 'pry'

# If anyone wants an edge test for the Rider#drivers method to see if the list of drivers it returns is unique, riders 41, 164, 92, 74, 63, and 250 have all had more than one ride with the same driver.

# RIDER with no trips to use as an edge case
# 116, 300, 42

describe "Rider" do

  describe "initialize" do
    let(:rider) {RideShare::Rider.new(rider_id: 554, name: "Kaitlin Ramirez", phone_num: "555-555-1234")}
    it "Can create a new instance of the Rider class" do
      # skip
      rider.must_be_instance_of RideShare::Rider
    end

    it "can assign instance variables according to the input hash" do
      rider.name.must_equal "Kaitlin Ramirez"
      rider.rider_id.must_be_instance_of Fixnum
      rider.phone_num.must_be_instance_of String
    end
  end

  describe "create_all_riders" do
    let(:riders) {RideShare::Rider.create_all_riders}
    it "returns an array of all riders" do
      # skip
      riders.must_be_instance_of Array
    end

    it "returns the correct number of riders" do
      # skip
      riders.length.must_equal 300
    end
  end

  describe "find(rider_id)" do
    it "should return the rider_id that was passed through" do
      skip
      RideShare::Rider.find(1)[:rider_id].must_equal 1
    end

    it "should return the name of the given rider_id" do
      skip
      RideShare::Rider.find(150)[:name].must_equal "Angelita Donnelly III"
    end

    it "should return the phone number of the given rider_id" do
      skip
      RideShare::Rider.find(300)[:phone_num].must_equal "791-114-8423 x70188"
    end
  end

  describe "trips" do
    it "finds all the trips for a Rider in an Array" do
      skip
      RideShare::Rider.new(rider_id: 1, name: "Nina Hintz Sr.", phone_num: "560.815.3059").trips.must_be_instance_of Array
    end

    it "finds trips for a Rider without trips" do
      skip
      RideShare::Rider.new(rider_id: 42, name: "Marcelina Howe", phone_num: "656-421-8363 x85791").trips.must_be_empty
    end
  end

  describe "unique_drivers" do
    it "returns an Array of all the drivers a rider has had" do
      skip
      RideShare::Rider.new(rider_id: 56, name: "Rebecca Moen DVM", phone_num: "(117) 028-4562 x913").unique_drivers.must_be_instance_of Array
    end

    it "returns an empty Array if the rider has not taken any trips, thus no drivers" do
      skip
      RideShare::Rider.new(rider_id: 116, name: "Laurianne Larkin", phone_num: "567.228.1637 x86366").unique_drivers.must_be_empty
    end

    it "returns an Array of one item if the rider has had only one driver" do
      skip
      RideShare::Rider.new(rider_id: 41, name: "Ms. Westley Pouros", phone_num: "133.000.1809 x9028" ).unique_drivers.length.must_equal 1
    end
  end

end
