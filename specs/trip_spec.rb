require_relative 'spec_helper'

describe "Trip tests" do
  let(:trip) { RideShare::Trip.new({ id: 2, driver_id: 4, rider_id: 8, date: "2014-07-12", rating: 5 }) }

  describe "Trip#initialize" do
    it "Takes an ID, driver_id, rider_id, date, and rating" do
      trip.must_respond_to :id
      trip.id.must_equal 2

      trip.must_respond_to :driver_id
      trip.driver_id.must_equal 4

      trip.must_respond_to :rider_id
      trip.rider_id.must_equal 8

      trip.must_respond_to :date
      trip.date.must_equal "2014-07-12"

      trip.must_respond_to :rating
      trip.rating.must_equal 5
    end

    it "Only accepts positive integer IDs for all ID fields" do
      trip_hash1 = { id: "id", driver_id: 4, rider_id: 8, date: "2014-07-12", rating: 5 }
      trip_hash2 = { id: 0, driver_id: 4, rider_id: 8, date: "2014-07-12", rating: 5 }
      trip_hash3 = { id: -2, driver_id: 4, rider_id: 8, date: "2014-07-12", rating: 5 }

      proc { RideShare::Trip.new(trip_hash1) }.must_raise ArgumentError
      proc { RideShare::Trip.new(trip_hash2) }.must_raise ArgumentError
      proc { RideShare::Trip.new(trip_hash3) }.must_raise ArgumentError

      trip_hash4 = { id: 2, driver_id: "four", rider_id: 8, date: "2014-07-12", rating: 5 }
      trip_hash5 = { id: 2, driver_id: 0, rider_id: 8, date: "2014-07-12", rating: 5 }
      trip_hash6 = { id: 2, driver_id: -4, rider_id: 8, date: "2014-07-12", rating: 5 }

      proc { RideShare::Trip.new(trip_hash4) }.must_raise ArgumentError
      proc { RideShare::Trip.new(trip_hash5) }.must_raise ArgumentError
      proc { RideShare::Trip.new(trip_hash6) }.must_raise ArgumentError

      trip_hash7 = { id: 2, driver_id: 4, rider_id: [8], date: "2014-07-12", rating: 5 }
      trip_hash8 = { id: 2, driver_id: 4, rider_id: 0, date: "2014-07-12", rating: 5 }
      trip_hash9 = { id: 2, driver_id: 4, rider_id: -8, date: "2014-07-12", rating: 5 }

      proc { RideShare::Trip.new(trip_hash7) }.must_raise ArgumentError
      proc { RideShare::Trip.new(trip_hash8) }.must_raise ArgumentError
      proc { RideShare::Trip.new(trip_hash9) }.must_raise ArgumentError
    end

    it "Only accepts non-empty strings for Date" do
      trip_hash1 = { id: 2, driver_id: 4, rider_id: 8, date: 87, rating: 5 }
      trip_hash2 = { id: 2, driver_id: 4, rider_id: 8, date: "", rating: 5 }

      proc { RideShare::Trip.new(trip_hash1) }.must_raise ArgumentError
      proc { RideShare::Trip.new(trip_hash2) }.must_raise ArgumentError
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

  # describe "Trip.all" do
  #   it "Trip.all returns an array" do
  #     trips_array.must_be_instance_of Array
  #   end
  #
  #   it "The first and last element of the array is a Trip" do
  #     trips_array[0].must_be_instance_of RideShare::Trip
  #     trips_array[-1].must_be_instance_of RideShare::Trip
  #   end
  #
  #   it "The number of trips is correct" do
  #     trips_array.length.must_equal csv_info.count - 1
  #   end
  #
  #   it "The information for the first & last trip is correct" do
  #     trips_array[0].id.must_equal csv_info[1][0].to_i
  #     trips_array[0].name.must_equal csv_info[1][1]
  #     trips_array[0].phone.must_equal csv_info[1][2]
  #
  #     trips_array[-1].id.must_equal csv_info[-1][0].to_i
  #     trips_array[-1].name.must_equal csv_info[-1][1]
  #     trips_array[-1].phone.must_equal csv_info[-1][2]
  #   end
  # end
end
