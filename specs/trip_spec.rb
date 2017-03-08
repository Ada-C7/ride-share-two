require_relative 'spec_helper'

describe "Trip tests" do
  let(:trip) { RideShare::Trip.new({ id: 2, driver_id: 4, rider_id: 8, date: "2014-07-12", rating: 5 }) }
  let(:trips_array) { RideShare::Trip.all }
  let(:csv_info) { CSV.read('support/trips.csv')[1..-1] }

  describe "Trip#initialize" do
    it "Takes an ID, driver_id, rider_id, date, and rating" do
      trip.must_respond_to :id
      trip.id.must_equal 2

      trip.must_respond_to :driver_id
      trip.driver_id.must_equal 4

      trip.must_respond_to :rider_id
      trip.rider_id.must_equal 8

      trip.must_respond_to :date
      trip.date.must_equal Date.parse("2014-07-12")

      trip.must_respond_to :rating
      trip.rating.must_equal 5
    end

    it "Only accepts non-negative integer IDs for all ID fields" do
      trip_hash1 = { id: "id", driver_id: 4, rider_id: 8, date: "2014-07-12", rating: 5 }
      trip_hash2 = { id: -2, driver_id: 4, rider_id: 8, date: "2014-07-12", rating: 5 }

      proc { RideShare::Trip.new(trip_hash1) }.must_raise ArgumentError
      proc { RideShare::Trip.new(trip_hash2) }.must_raise ArgumentError

      trip_hash3 = { id: 2, driver_id: "four", rider_id: 8, date: "2014-07-12", rating: 5 }
      trip_hash4 = { id: 2, driver_id: -4, rider_id: 8, date: "2014-07-12", rating: 5 }

      proc { RideShare::Trip.new(trip_hash3) }.must_raise ArgumentError
      proc { RideShare::Trip.new(trip_hash4) }.must_raise ArgumentError

      trip_hash5 = { id: 2, driver_id: 4, rider_id: [8], date: "2014-07-12", rating: 5 }
      trip_hash6 = { id: 2, driver_id: 4, rider_id: -8, date: "2014-07-12", rating: 5 }

      proc { RideShare::Trip.new(trip_hash5) }.must_raise ArgumentError
      proc { RideShare::Trip.new(trip_hash6) }.must_raise ArgumentError
    end

    it "Only accepts strings for Date" do
      trip_hash1 = { id: 2, driver_id: 4, rider_id: 8, date: 87, rating: 5 }
      trip_hash2 = { id: 2, driver_id: 4, rider_id: 8, date: "", rating: 5 }

      proc { RideShare::Trip.new(trip_hash1) }.must_raise ArgumentError
      proc { RideShare::Trip.new(trip_hash2) }.must_raise ArgumentError
    end

    it "Once initialized, date must be a Date" do
      trip.date.must_be_instance_of Date
    end

    it "Rating must be an integer 1-5" do
      trip_hash1 = { id: 2, driver_id: 4, rider_id: 8, date: "2014-07-12", rating: 0 }
      trip_hash2 = { id: 2, driver_id: 4, rider_id: 8, date: "2014-07-12", rating: "rating!" }
      trip_hash3 = { id: 2, driver_id: 4, rider_id: 8, date: "2014-07-12", rating: 6 }

      proc { RideShare::Trip.new(trip_hash1) }.must_raise ArgumentError
      proc { RideShare::Trip.new(trip_hash2) }.must_raise ArgumentError
      proc { RideShare::Trip.new(trip_hash3) }.must_raise ArgumentError
    end
  end

  describe "Trip.all" do
    it "Trip.all returns an array" do
      trips_array.must_be_instance_of Array
    end

    it "The first and last element of the array is a Trip" do
      trips_array[0].must_be_instance_of RideShare::Trip
      trips_array[-1].must_be_instance_of RideShare::Trip
    end

    it "The number of trips is correct" do
      trips_array.length.must_equal csv_info.count
    end

    it "The information for the first & last trip is correct" do
      trips_array[0].id.must_equal csv_info[0][0].to_i
      trips_array[0].driver_id.must_equal csv_info[0][1].to_i
      trips_array[0].rider_id.must_equal csv_info[0][2].to_i
      trips_array[0].date.must_equal Date.parse(csv_info[0][3])
      trips_array[0].rating.must_equal csv_info[0][4].to_i

      trips_array[-1].id.must_equal csv_info[-1][0].to_i
      trips_array[-1].driver_id.must_equal csv_info[-1][1].to_i
      trips_array[-1].rider_id.must_equal csv_info[-1][2].to_i
      trips_array[-1].date.must_equal Date.parse(csv_info[-1][3])
      trips_array[-1].rating.must_equal csv_info[-1][4].to_i
    end
  end

  describe "Trip.find_driver_trips" do
    it "Returns an Array" do
      RideShare::Trip.find_driver_trips(2).must_be_instance_of Array
    end

    it "The first and last element of the array is a Trip" do
      drivers_trips = RideShare::Trip.find_driver_trips(2)

      drivers_trips[0].must_be_instance_of RideShare::Trip
      drivers_trips[-1].must_be_instance_of RideShare::Trip
    end

    it "The number of trips is correct" do
      RideShare::Trip.find_driver_trips(2).length.must_equal 8
    end

    #do a test for what to do if no trips were taken by a driver
  end
end
