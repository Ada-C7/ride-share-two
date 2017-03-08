require_relative 'spec_helper'

# Try to use let! :) instead of before

describe "Trip class" do
  let(:tripin) { RideShare::Trip.new(trip_id: 1337, driver_id: 1234, rider_id: 4321, date: "2017-07-17", rating: 5) }

  describe "Trip#initialize" do
    it "It takes a trip_hash argument" do
      tripin.must_be_instance_of RideShare::Trip
    end

    it "Has the correct values that were passed" do
      tripin.trip_id.must_equal 1337
      tripin.driver_id.must_equal 1234
      tripin.rider_id.must_equal 4321
      tripin.date.must_equal "2017-07-17"
      tripin.rating.must_equal 5
    end
  end

  describe "Trip.all" do
    let(:trips) { RideShare::Trip.all }

    it "Returns an array with all the trip info" do
      trips.class.must_equal Array
    end

    it "Everything in the array is a trip" do
      first_trip = trips[0]
      first_trip.class.must_equal RideShare::Trip
    end

    it "Trip info matches what is in the CSV file" do
      index = 1
      CSV.read("support/trips.csv") do
        trips[index].trip_id.must_equal line[0].to_i
        trips[index].driver_id.must_equal line[1].to_i
        trips[index].rider_id.must_equal line[2].to_i
        trips[index].date.must_equal line[3]
        trips[index].rating.must_equal line[4].to_i

        index += 1
      end
    end
  end

  describe "Trip.find" do
    let(:trip) { RideShare::Trip }

    it "Retruns an account that exists" do
      trip_exists = trip.find(77)
      trip_exists.must_be_instance_of RideShare::Trip

      trip_exists.trip_id.must_equal 77
      trip_exists.driver_id.must_equal 40
      trip_exists.rider_id.must_equal 205
      trip_exists.date.must_equal "2016-05-18"
      trip_exists.rating.must_equal 2
    end

    it "Can find the last account from the CSV" do
      trip_exists = trip.find(600)
      trip_exists.trip_id.must_equal 600
      trip_exists.driver_id.must_equal 61
      trip_exists.rider_id.must_equal 168
      trip_exists.date.must_equal "2016-04-25"
      trip_exists.rating.must_equal 3

    end

    it "Raises an error for an account that doesn't exist" do
      proc { trip.find(1337) }.must_raise ArgumentError
    end
  end

  xdescribe "Trip.find_many_rider" do
    it "" do
    end
  end

  xdescribe "Trip.find_many_driver" do
    it "" do
    end
  end

  describe "Trip.rider" do
    it "" do
    end
  end

  describe "Trip.driver" do
    it "" do
    end
  end
end
