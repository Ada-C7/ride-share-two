require_relative 'spec_helper'

describe "RideShare::Rider" do
  let(:rider) { RideShare::Rider.new({ id: "13", name: "Dr. Leilani Mertz", phone_number: "777.380.7540" }) }
  let(:all_riders) { RideShare::Rider.all }
  let(:rider_found) { RideShare::Rider.find("13") }

  describe "Rider#initialize" do
    it "creates a new instance of Rider" do
      rider.must_be_instance_of RideShare::Rider
    end

    it "passes in correct values" do
      rider.id.must_equal "13"
      rider.name.must_equal "Dr. Leilani Mertz"
      rider.phone_number.must_equal "777.380.7540"
    end

    it "can create a new rider with a missing phone" do
      no_phone = RideShare::Rider.new({id: "87", name: "Tamiko Terada"})
      no_phone.phone_number.must_equal nil
    end
  end

  describe "Rider#all" do
    it "returns an array" do
      all_riders.must_be_kind_of Array
    end

    it "each returned element is a rider instances" do
      all_riders.each do |object|
        object.must_be_instance_of RideShare::Rider
      end
    end

    it "returns the correct number of elements" do
      all_riders.length.must_equal 300 # rows in CSV file
    end

    it "correctly reads in the first row of the CSV file" do
      # last row of data: 1,Nina Hintz Sr.,560.815.3059
      all_riders[0].id.must_equal "1"
      all_riders[0].name.must_equal "Nina Hintz Sr."
      all_riders[0].phone_number.must_equal "560.815.3059"
    end

    it "correctly reads in the last row of the CSV file" do
      # last row of data: 300,Miss Isom Gleason,791-114-8423 x70188
      all_riders[-1].id.must_equal "300"
      all_riders[-1].name.must_equal "Miss Isom Gleason"
      all_riders[-1].phone_number.must_equal "791-114-8423 x70188"
    end
  end

  describe "Rider#find" do
    before { RideShare::Rider.all }

    it "return value is a Rider instance" do
      rider_found.must_be_instance_of RideShare::Rider
    end

    # it "displays a message if the Rider is not found" do
    #   @no_rider = RideShare::Rider.find("9999")
    # end

    it "finds the correct instance of Rider" do
      rider_found.id.must_equal "13"
      rider_found.name.must_equal "Dr. Leilani Mertz"
      rider_found.phone_number.must_equal "777.380.7540"
    end
  end

  describe "Rider#past_trips" do
    before { RideShare::Trip.all }

    it "returns value an an Array" do
      rider.past_trips.must_be_kind_of Array
    end

    it "first element is an instance of Trip" do
      rider.past_trips[0].must_be_instance_of RideShare::Trip
    end

    it "last element is a Trip associated with the expected rider" do
      rider.past_trips[-1].rider_id.must_equal "13"
    end
  end

  describe "Rider#past_drivers" do
    before do
      RideShare::Trip.all
      RideShare::Driver.all
    end
    it "returns value as an Array" do
      rider.past_drivers.must_be_kind_of Array
    end

    it "first element is an instance of Driver" do
      rider.past_drivers[0].must_be_instance_of RideShare::Driver
    end

    it "last Driver is associated with the Rider through a Trip" do
    skip
      # find out how to test this
    end
  end
end
