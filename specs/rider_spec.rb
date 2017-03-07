require_relative 'spec_helper'

describe "Rider" do
   let(:riders) {RideShare::Rider.all}

  describe "initialize" do

    #responds to all the arguments

  end

  describe "all" do
    it "returns an Array" do
      riders.must_be_instance_of Array
    end

    it "everything in the Array is a Rider instance" do
      riders.each do |rider|
        rider.must_be_instance_of RideShare::Rider
      end
    end

    it "gets everything in the csv" do
       riders.length.must_equal 300
    end

    it "gets the first item" do
        riders[0].name.must_equal "Nina Hintz Sr."
    end

    it "gets the last item"  do
        riders.last.phone.must_equal "791-114-8423 x70188"

    end

    describe "Error Checking" do
      #name is a string
      #rider_id is an integer
      #phone_number is ??
    end

  end

  describe "find" do

    it "returns an instance of Rider" do
      rider = RideShare::Rider.find 22
      rider.must_be_instance_of RideShare::Rider
      rider.id.must_equal 22

    end

    it "returns nil if Rider is not found" do
      rider = RideShare::Rider.find 450
      rider.must_be_instance_of NilClass
    end

  end


  describe "trips" do

    it "returns an Array of trips" do
      #object is an Array
      #all elements in Array are Trip instances
    end

    it "finds all trips associated with the rider" do
      #all rider_ids match the rider's rider_id
      #no trips left behind
    end

  end

  describe "drivers" do

    it "returns an Array" do
    end

    it "everything in the Array is a Trip" do
    end

    it "finds all the trips in the given array that match the driver instance" do
    end

  end

end
