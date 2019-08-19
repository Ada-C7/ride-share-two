require_relative 'spec_helper'

describe "Rider tests" do
  let(:rider) { RideShare::Rider.new({ id: 8, name: "Galois", phone: "206-555-2468" }) }
  let(:riders_array) { RideShare::Rider.all }
  let(:csv_info) { CSV.read('support/riders.csv')[1..-1] }
  let(:rider146) { RideShare::Rider.find(146) }
  let(:rider300) { RideShare::Rider.find(300) }
  let(:rider103) { RideShare::Rider.find(103) }

  describe "Rider#initialize" do
    it "Takes an ID, name, and phone number" do
      rider.must_respond_to :id
      rider.id.must_equal 8

      rider.must_respond_to :name
      rider.name.must_equal "Galois"

      rider.must_respond_to :phone
      rider.phone.must_equal "206-555-2468"
    end

    it "Only accepts non-negative integer IDs" do
      rider_hash1 = { id: "id", name: "Ada", phone: "2065552468" }
      rider_hash2 = { id: -4, name: "Ada", phone: "2065552468" }

      proc { RideShare::Rider.new(rider_hash1) }.must_raise ArgumentError
      proc { RideShare::Rider.new(rider_hash2) }.must_raise ArgumentError
    end

    it "Only accepts non-empty strings for Name and Phone Number" do
      rider_hash1 = { id: 4, name: "", phone: "2065552468" }
      rider_hash2 = { id: 4, name: 45, phone: "2065552468" }

      proc { RideShare::Rider.new(rider_hash1) }.must_raise ArgumentError
      proc { RideShare::Rider.new(rider_hash2) }.must_raise ArgumentError

      rider_hash3 = { id: 4, name: "Ada", phone: "" }
      rider_hash4 = { id: 4, name: "Ada", phone: [] }

      proc { RideShare::Rider.new(rider_hash3) }.must_raise ArgumentError
      proc { RideShare::Rider.new(rider_hash4) }.must_raise ArgumentError
    end

    it "All fields are required" do
      rider_hash1 = { name: "Galois", phone: "206-555-2468" }
      rider_hash2 = { id: 8, phone: "206-555-2468" }
      rider_hash3 = { id: 8, name: "Galois" }

      proc { RideShare::Rider.new(rider_hash1) }.must_raise ArgumentError
      proc { RideShare::Rider.new(rider_hash2) }.must_raise ArgumentError
      proc { RideShare::Rider.new(rider_hash3) }.must_raise ArgumentError
    end
  end

  describe "Rider.all" do
    it "Rider.all returns an array" do
      riders_array.must_be_instance_of Array
    end

    it "The first and last element of the array is a Rider" do
      riders_array[0].must_be_instance_of RideShare::Rider
      riders_array[-1].must_be_instance_of RideShare::Rider
    end

    it "The number of riders is correct" do
      riders_array.length.must_equal csv_info.count
    end

    it "The information for the first & last rider is correct" do
      riders_array[0].id.must_equal csv_info[0][0].to_i
      riders_array[0].name.must_equal csv_info[0][1]
      riders_array[0].phone.must_equal csv_info[0][2]

      riders_array[-1].id.must_equal csv_info[-1][0].to_i
      riders_array[-1].name.must_equal csv_info[-1][1]
      riders_array[-1].phone.must_equal csv_info[-1][2]
    end
  end

  describe "Rider.find" do
    it "Returns a rider that exists" do
      RideShare::Rider.find(16).must_be_instance_of RideShare::Rider
      RideShare::Rider.find(16).name.must_equal "Mr. Onie Spinka"
    end

    it "Can find the first rider from the CSV" do
      RideShare::Rider.find(csv_info[0][0].to_i).must_be_instance_of RideShare::Rider
      RideShare::Rider.find(csv_info[0][0].to_i).name.must_equal csv_info[0][1]
    end

    it "Can find the last rider from the CSV" do
      RideShare::Rider.find(csv_info[-1][0].to_i).must_be_instance_of RideShare::Rider
      RideShare::Rider.find(csv_info[-1][0].to_i).phone.must_equal csv_info[-1][2]
    end

    it "Raises an error for a rider that doesn't exist" do
      proc { RideShare::Rider.find(0) }.must_raise NoRiderError
    end
  end

  describe "Rider#trips" do
    it "Returns an array" do
      rider.trips.must_be_instance_of Array
    end

    it "First and last element of array are Trips" do
      rider.trips[0].must_be_instance_of RideShare::Trip
      rider.trips[-1].must_be_instance_of RideShare::Trip
    end

    it "The number of trips is correct for Rider 146" do
      RideShare::Rider.find(146).trips.length.must_equal 4
    end

    it "Returns an empty array if no trips are found" do
      rider300.trips.must_equal []
    end
  end

  describe "Rider#drivers" do
    it "Returns an array" do
      rider.drivers.must_be_instance_of Array
    end

    it "First and last element of array are Drivers" do
      rider.drivers[0].must_be_instance_of RideShare::Driver
      rider.drivers[-1].must_be_instance_of RideShare::Driver
    end

    it "The number of drivers is correct for Rider 146" do
      rider146.drivers.length.must_equal 4
    end

    it "Drivers are not duplicated for a rider that's had a driver > 1 time" do
      rider164_drivers = RideShare::Rider.find(164).drivers
      rider164_drivers.length.must_equal 5
    end

    it "Returns an empty array if no trips were taken" do
      rider300.drivers.must_equal []
    end

    it "Outputs a message if it tries to find a driver with an ID that doesn't exist" do
      proc { rider103.drivers }.must_output (/.+/)
    end

    it "Trips taken with driver IDs that don't return a Driver won't add to the array" do
      rider103.drivers.length.must_equal 1
    end
  end
end
