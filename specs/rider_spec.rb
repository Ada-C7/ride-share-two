require_relative 'spec_helper'

describe "Rider tests" do
  let(:rider) { RideShare::Rider.new({ id: 8, name: "Galois", phone: "206-555-2468" }) }
  let(:riders_array) { RideShare::Rider.all }
  let(:csv_info) { CSV.read('support/riders.csv') }

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
      riders_array.length.must_equal csv_info.count - 1
    end

    it "The information for the first & last rider is correct" do
      riders_array[0].id.must_equal csv_info[1][0].to_i
      riders_array[0].name.must_equal csv_info[1][1]
      riders_array[0].phone.must_equal csv_info[1][2]

      riders_array[-1].id.must_equal csv_info[-1][0].to_i
      riders_array[-1].name.must_equal csv_info[-1][1]
      riders_array[-1].phone.must_equal csv_info[-1][2]
    end
  end
end
