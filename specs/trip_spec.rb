require_relative 'spec_helper'

describe "Trip class" do
  let(:trips) { RideShare::Trip.all }
  let(:driver_trips) { RideShare::Trip.trips_by_driver(24) }
  let(:rider_trips) { RideShare::Trip.trips_by_rider(280) }
  let(:trip)  {RideShare::Trip.new(15, 26, 143, "2016-06-17", 5
    )}
    describe "#initialize method"  do
      it "Initializes a new trip instance from the parameter" do
        trip.must_be_instance_of RideShare::Trip
        trip.must_respond_to :id
        trip.id.must_equal 15
        trip.must_respond_to :driver_id
        trip.driver_id.must_equal 26
        trip.must_respond_to :rider_id
        trip.rider_id.must_equal 143
        trip.must_respond_to :date
        trip.date.must_equal "2016-06-17"
        trip.must_respond_to :rating
        trip.rating.must_equal 5
      end

      it "raises an argument error if Trip's ID or driver id or rider id or date are invalid" do
        proc {
          RideShare::Trip.new("one", 26, 143, "2016-06-17", 5)
        }.must_raise ArgumentError
        proc {
          RideShare::Trip.new(1, "twenty", 143, "2016-06-17", 5)
        }.must_raise ArgumentError
        proc {
          RideShare::Trip.new(1, 26, [143], "2016-06-17", 5)
        }.must_raise ArgumentError
        proc {
          RideShare::Trip.new(1, 26, 143, 16|06|17, 5)
        }.must_raise ArgumentError
      end

      it "raises an invalid rating error if rating is not an integer between 1 and 5" do
        proc {
          RideShare::Trip.new(1, 26, 143, "2016-06-17", 9)
        }.must_raise InvalidRatingError
      end
    end

    describe "Find driver" do
      it "retrieve the associated driver instance through the driver ID" do
        trip.find_driver.must_be_instance_of RideShare::Driver
        trip.find_driver.driver_id.must_equal 26
      end
    end

    describe "Find Rider" do
      it "retrieve the associated rider instance through the rider ID" do
        trip.find_rider.must_be_instance_of RideShare::Rider
        trip.find_rider.rider_id.must_equal 143
      end
    end

    describe "Self trips by Driver" do
      it "find all trip instances for a given driver ID" do
        driver_trips.must_be_instance_of Array
      end

      it "raises an error if a non-integer is provided as driver id" do
        proc {
          RideShare::Trip.trips_by_driver("one")
        }.must_raise ArgumentError
      end
    end

    describe "Self trips by Rider" do
      it "find all trip instances for a given rider ID" do
        rider_trips.must_be_instance_of Array
      end

      it "raises an error if a non-integer is provided as rider id" do
        proc {
          RideShare::Trip.trips_by_rider("one")
        }.must_raise ArgumentError
      end
    end

    describe "Self all method" do
      it "retrieve all trips from the CSV file
      " do
      trips.each { |trip| trip.must_be_instance_of RideShare::Trip }
      trips.length.must_equal 600
    end

      it "Include first trip" do
      trips.first.driver_id.must_equal 1
    end

    it "Include last trip" do
      trips.last.driver_id.must_equal 61
    end
  end
end
