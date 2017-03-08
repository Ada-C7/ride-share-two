require_relative './spec_helper'


describe "Rider" do
  before do
    @rider_hash = {
      id: 32,
      name: "Melba Torphy",
      phone: "246.356.5591 x70530"
    }
  end

  let(:rider) { RideShare::Rider.new(@rider_hash) }

  describe "Rider initialize" do
    it "has required attributes" do
      rider.name.must_equal "Melba Torphy"
      rider.id.must_equal 32
      rider.phone.must_equal "246.356.5591 x70530"
    end

  end

  describe "self.all" do
    let(:all_riders) { RideShare::Rider.all }

    it "creates an array of new Rider instances from a CSV file" do
      all_riders.must_be_instance_of Array
      all_riders.first.must_be_instance_of RideShare::Rider
      all_riders.last.must_be_instance_of RideShare::Rider
    end

    it "creates new Riders that match the name and ID of first/last lines in file" do
      all_riders.first.id.must_equal 1
      all_riders.first.name.must_equal "Nina Hintz Sr."
      all_riders.last.id.must_equal 300
      all_riders.last.name.must_equal "Miss Isom Gleason"
    end


  end

  describe "self.find" do
    it "returns a rider that exists" do
      RideShare::Rider.find(24).wont_be_nil
    end

    it "can find a selection of drivers from the CSV" do
      RideShare::Rider.find(269).name.must_equal "April Zemlak"
      RideShare::Rider.find(17).name.must_equal "Rebekah Hodkiewicz"
    end

    it "raises an error for a rider ID that doesn't exist" do
      proc { RideShare::Rider.find(374)}.must_raise ArgumentError
    end
  end


  describe "get_trips" do
    it "retrieves a list of trip instances with this rider's id" do
      sample_trip = rider.get_trips.first
      sample_trip.must_be_instance_of RideShare::Trip
      sample_trip.rider_id.must_equal rider.id
    end
  end

  describe "get_drivers" do
    it "correctly generates a list of drivers associated with this rider's trips" do
      # rider.get_drivers
      # need to adjust sample rider to have more trips (try rider 45)
    end
  end


end
