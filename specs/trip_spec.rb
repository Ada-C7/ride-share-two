require_relative 'spec_helper.rb'

describe RideShare::Trip do
  describe "initalize" do
    it "takes trip ID, rider ID, a driver ID, date, rating" do
      trip_id = 5
      rider_id = ""
      driver_id = ""
      date = ""
      rating = 4.5
      trip = RideShare::Trip.new(trip_id, rider_id, driver_id, date, rating)
      trip.must_be_instance_of RideShare::Trip
      trip.trip_id.must_equal trip_id
      trip.rider_id.must_equal rider_id
      trip.driver_id.must_equal driver_id
      trip.date.must_equal date
      trip.rating.must_equal rating
    end
  end
  describe "self.all" do
    before do
      @csv_trip = RideShare::Trip.all
    end
    it "checks for an array" do
      @csv_trip.must_be_instance_of Array
    end
    it "checks every array is instance of Driver" do
      @csv_trip.each do |array|
        array.must_be_instance_of RideShare::Trip
      end
    end
    it "checks correct length of csv driver file" do
      @csv_trip.length.must_equal 600
    end
  end
  describe "self.find_trips_of_driver" do
    before do
      driver_id = 4
      @driver_trips = RideShare::Trip.find_trips_of_driver(driver_id)
    end
    it "check that it is returning array" do
      @driver_trips.must_be_instance_of Array
    end
    it "check that every trip in array has correct driver id for the id given" do
      @driver_trips.each do |trip|
        trip.driver_id.must_equal 4
      end
    end
    it "checks that argument error is being raised" do
      proc { RideShare::Trip.find_trips_of_driver(900)
      }.must_raise ArgumentError
    end
  end

  describe "self.find_trips_of_rider" do
    before do
      rider_id = 8
      @rider_trips = RideShare::Trip.find_trips_of_rider(rider_id)
    end
    it "checks that it is returning an array" do
      @rider_trips.must_be_instance_of Array
    end
    it "checks that the id given matches the output of riders" do
      @rider_trips.each do |rider|
        rider.rider_id.must_equal 8
      end
    end
    it "checks that argument error is being raised if given invalid rider id" do
      proc { RideShare::Trip.find_trips_of_rider("fail")
           }.must_raise ArgumentError
    end
  end

end
