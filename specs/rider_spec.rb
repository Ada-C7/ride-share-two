require_relative 'spec_helper.rb'

describe "Rider" do
  describe "initialize" do
    #responds to all the arguments

  end

  describe "all" do
    it "returns an Array" do

    end

    it "everything in the Array is a Rider instance" do

    end

    it "gets everything in the csv" do

    end

    it "gets the first item" do

    end

    it "gets the last item"  do

    end

    describe "Error Checking" do
      #name is a string
      #rider_id is an integer
      #phone_number is ??
    end

  end

  describe "find" do
    it "returns an instance of Rider" do
      #must_be_instance of Rider
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
