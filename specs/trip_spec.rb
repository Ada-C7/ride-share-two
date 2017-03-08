require_relative 'spec_helper.rb'

describe "Trip" do
  let(:trips) {RideShare::Trip.all}

  describe "initialize" do
    it "raises an Argument Error for invalid Trip ID" do
      proc {
        RideShare::Trip.new("7", 84, 236, "2015-05-20", 4)
      }.must_raise ArgumentError
    end

    it "raises an Argument Error for invalid Driver ID" do
      proc {
        RideShare::Trip.new(7,"84",236,"2015-05-20",4)
      }.must_raise ArgumentError
    end

    it "raises an Argument Error for invalid Rider ID" do
      proc {
        RideShare::Trip.new(7, 84, "236", "2015-05-20", 4)
      }.must_raise ArgumentError
    end

    it "raises an Argument Error for invalid date" do

      proc {
        RideShare::Trip.new(7, 84, 236, "2025-05", 5)
      }.must_raise ArgumentError


      proc {
        RideShare::Trip.new(7, 84, 236, "201805-33", 5)
      }.must_raise ArgumentError

      proc {
        RideShare::Trip.new(7, 84, 236, "2017-31-12", 5)
      }.must_raise ArgumentError

    end

    it "raises an Argument Error for invalid rating" do
      proc {
        RideShare::Trip.new(7, 84, 236, "2015-05-20", 0)
      }.must_raise BadRatingError
    end

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

    it "Array length equals number of lines in csv file minus header row" do
      trips.length.must_equal 600
    end

    it "does not include trips with invalid ratings" do
      proc {
        RideShare::Trip.all
      }.must_output /.+/
    end
  end

  describe "find_trips_by_rider" do

    it "returns an array of trips" do
      rider_trips = RideShare::Trip.find_trips_by_rider 140
      rider_trips.must_be_instance_of Array
      rider_trips.length.must_equal 4
      #object must be an array
      #everything in the array must be a trip instance
    end

    it "trip rider id must match passed rider_id" do
      rider_trips = RideShare::Trip.find_trips_by_rider 63
      rider_trips.length.must_equal 3
      rider_trips.all? { |rider| rider.rider_id.must_equal 63 }
    end

    it "returns empty Array if rider id can't be found" do
      rider_trips = RideShare::Trip.find_trips_by_rider 777
      rider_trips.must_be_instance_of Array
      rider_trips.length.must_equal 0
    end
  end

  describe "find_trips_by_driver" do

    it "returns empty array if no trips assoc. with driver" do
      driver_trips = RideShare::Trip.find_trips_by_driver 777
      driver_trips.must_be_instance_of Array
      driver_trips.length.must_equal 0
    end

    it "returns Array of trips" do
      driver96_trips = RideShare::Trip.find_trips_by_driver 96
      driver96_trips.must_be_instance_of Array
      driver96_trips.length.must_equal 7
    end

    it "all trips match the driver_id" do
      driver96_trips = RideShare::Trip.find_trips_by_driver 96
      driver96_ids = driver96_trips.map {|trip| trip.driver_id}
      driver96_ids.all? { |id| id.must_equal 96}
    end

  end

  describe "driver" do

    it "returns a Driver instance" do
      trip = trips[30]
      trip.driver.must_be_instance_of RideShare::Driver
    end

    it "returns nil if driver isn't found" do
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

    it "returns nil if rider isn't found" do
      #don't think this is possible to test through current CSV files?
      trip =  RideShare::Trip.new(6500, 727272, 7845, "2016-12-29", 4)
      rider_info = trip.rider
      rider_info.must_be_instance_of NilClass
    end
  end

end
