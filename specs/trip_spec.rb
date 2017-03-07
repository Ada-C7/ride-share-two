require_relative 'spec_helper.rb'

describe "Trip" do
  let(:trips) {RideShare::Trip.all}

  describe "initialize" do

  end

  describe "all" do
    it "returns an Array" do
      trips.must_be_instance_of Array
    end

    it "every item in the Array is a Trip object" do
      trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "the Array length equals the number of lines in the csv file minus header row" do
      trips.length.must_equal 600
    end

    describe "Error Checking reading the csv" do
      it "needs integer values for trip_id, driver_id, rider_id" do
      end

      it "ratings need to be between 1 and 5" do
      end

    end

  end

  describe "find_trips_by_rider" do
    it "takes a rider_id" do

    end

    it "raises/does something if it can't find that rider id" do
      skip
    end

    it "returns an array of trips" do
      rider_trips = RideShare::Trip.find_trips_by_rider 140
      rider_trips.must_be_instance_of Array
      rider_trips.length.must_equal 4
      #object must be an array
      #everything in the array must be a trip instance
    end

    it "must match the rider_id" do
      rider_trips = RideShare::Trip.find_trips_by_rider 63
      rider_trips.length.must_equal 3
      rider_trips.each do |rider|
        rider.rider_id.must_equal 63
      end
    end

    it "must return nil if that rider id can't be found" do
      rider_trips = RideShare::Trip.find_trips_by_rider 777
      rider_trips.must_be_instance_of NilClass
    end
    #all rider_ids must match the passed argument


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
