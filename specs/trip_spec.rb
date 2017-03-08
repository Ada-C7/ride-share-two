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

    it "must return empty Array if that rider id can't be found" do
      rider_trips = RideShare::Trip.find_trips_by_rider 777
      rider_trips.must_be_instance_of Array
      rider_trips.length.must_equal 0
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
      trip = trips[30]
      trip.driver.must_be_instance_of RideShare::Driver
    end

    it "lets you know if it doesn't have the driver info" do
      fake_trip = RideShare::Trip.new(450, 7676, 8734, "2016-06-01", 5)
      fake_trip.driver.must_be_instance_of NilClass

    end
  end

  describe "rider" do
    it "returns a Rider instance" do
      trip = trips[23]
      rider_info = trip.rider
      rider_info.must_be_instance_of RideShare::Rider
      rider_info.id.must_equal trip.rider_id
      rider_info.id.must_equal 280
    # CSV file: 24,75,280,2015-11-04,4
    end

    it "returns nil if the rider isn't found" do
      #don't think this is possible to test through current CSV files?
      trip =  RideShare::Trip.new(6500, 727272, 7845, "2016-12-29", 4)
      rider_info = trip.rider
      rider_info.must_be_instance_of NilClass
    end
  end

end
