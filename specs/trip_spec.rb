require_relative 'spec_helper'

# Try to use let! :) instead of before

describe "Trip class" do
  let(:tripin) { RideShare::Trip.new(trip_id: 5, driver_id: 3, rider_id: 12, date: "2015-12-14", rating: 2) }

  let(:trips) { RideShare::Trip.all }


  describe "Trip#initialize" do
    it "It takes a trip_hash argument" do
      tripin.must_be_instance_of RideShare::Trip
    end

    it "Has the correct values that were passed" do
      tripin.trip_id.must_equal 5
      tripin.driver_id.must_equal 3
      tripin.rider_id.must_equal 12
      tripin.date.must_equal "2015-12-14"
      tripin.rating.must_equal 2
    end

    # it "Raises ArgumentError if the rating is not within an acceptable range" do
    #
    #   proc { RideShare::Trip.new(trip_id: 5, driver_id: 3, rider_id: 12, date: "2015-12-14", rating: 0) }.must_raise ArgumentError
    #
    #   proc { RideShare::Trip.new(trip_id: 5, driver_id: 3, rider_id: 12, date: "2015-12-14", rating: 34) }.must_raise ArgumentError
    # end
  end

  describe "Trip.all" do

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

  describe "Trip.find_many_drivers" do
    let(:driver_on_trips) { RideShare::Trip.find_many_drivers(5) }

    it "Returns an array of trips based on driver_id" do
      driver_on_trips.class.must_equal Array
    end

    it "Returns the right lenght of an array based on spacific driver trips" do
      driver_on_trips.length.must_equal 8
    end

    it "Includes the first one found" do
      driver_on_trips.first.trip_id.must_equal 19
      driver_on_trips.first.driver_id.must_equal 5
      driver_on_trips.first.rider_id.must_equal 140
      driver_on_trips.first.date.must_equal "2016-02-16"
      driver_on_trips.first.rating.must_equal 5
    end

    it "Raises ArgumentError if the array is empty" do
      proc { RideShare::Trip.find_many_drivers(1337) }.must_raise ArgumentError
    end
  end

  describe "Trip.find_many_riders" do
    let(:rider_on_trips) { RideShare::Trip.find_many_riders(5) }

    it "Returns an array of trips based on driver_id" do
      rider_on_trips.class.must_equal Array
    end

    it "Returns the right lenght of an array based on spacific driver trips" do
      rider_on_trips.length.must_equal 1
    end

    it "Includes the first one found" do
      rider_on_trips.first.trip_id.must_equal 551
      rider_on_trips.first.driver_id.must_equal 12
      rider_on_trips.first.rider_id.must_equal 5
      rider_on_trips.first.date.must_equal "2016-12-09"
      rider_on_trips.first.rating.must_equal 1
    end

    it "Raises ArgumentError if the array is empty" do
      proc { RideShare::Trip.find_many_riders(1337) }.must_raise ArgumentError
    end
  end


  describe "Trip#driver" do

    it "Checking that Trip is talking to Driver " do
      my_trip = trips[3]
      tripin.driver.must_be_instance_of RideShare::Driver

      my_trip.driver_id.must_equal RideShare::Driver.find(50).id
      #then check that the driver_id that was pulled from my_trip matches up with the id from RideShare::Driver :)
    end
  end


  describe "Trip#rider" do
    it "Checking that Trip is talking to Driver " do
      my_trip = trips[3]
      tripin.rider.must_be_instance_of RideShare::Rider

      my_trip.rider_id.must_equal RideShare::Rider.find(87).id
    end
  end
end
