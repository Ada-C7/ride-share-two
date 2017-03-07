require_relative 'spec_helper.rb'

describe "Trip" do

  describe "initialize" do

  end

  describe "all" do
    it "returns an Array" do
    end

    it "every item in the Array is a Trip object" do
    end

    it "the Array length equals the number of lines in the csv file" do
    end

    describe "Error Checking reading the csv" do
      it "needs integer values for trip_id, driver_id, rider_id" do
      end

      it "ratings need to be between 1 and 5" do
      end

      it "check length of date string" do
      end

    end

  end

  describe "find_trips_by_rider" do
    it "takes an rider_id" do
    end

    it "raises/does something if it can't find that rider id" do
    end

    it "returns an array of trips" do
      #object must be an array
      #everything in the array must be a trip instance
    end

    it "must match the rider_id" do
      #all rider_ids must match the passed argument
    end

  end

  describe "find_trips_by_Driver" do
    it "takes a driver_id" do
    end

    it "raises/does something if it can't find that driver_id" do
    end

    it "returns an array of trips" do
      #object must be an array
      #everything in the array must be a trip instance
    end

    it "must match the driver_id" do
      #all rider_ids must match the passed argument
      #all trips that match the driver_id must be included (How to test?)
    end
  end

  describe "driver" do
    it "returns a Driver instance" do
    end

    it "lets you know if it doesn't have the driver info" do
    end
  end

  describe "rider" do
    it "returns a Rider instance" do
    end

    it "lets you know if it doesn't have the rider info" do
    end
  end

end
