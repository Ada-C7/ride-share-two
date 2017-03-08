require_relative 'spec_helper'
require_relative '../lib/trip'

describe RideShare::Trip do
    describe "#initialize" do
      it "Does not allow a trip without an ID" do
        proc {
          RideShare::Trip.new(driver_id: 8, rider_id: 263, date: "2015-12-14", rating: 4)
        }.must_raise ArgumentError
      end

      it "Does not allow a rating below 1" do
        proc {
          RideShare::Trip.new(id: 10, driver_id: 8, rider_id: 263, date: "2015-12-14", rating: 0)
        }.must_raise ArgumentError
      end

      it "Does not allow a rating 5" do
        proc {
          RideShare::Trip.new(id: 10, driver_id: 8, rider_id: 263, date: "2015-12-14", rating: 6)
        }.must_raise ArgumentError
      end
    end

    describe "self.all" do
      let(:all) { RideShare::Trip.all }

      it "Creates an array of all trips from the csv file" do
        all.must_be_instance_of Array
        all.first.must_be_instance_of RideShare::Trip
      end

      it "Includes the first trip in the csv file" do
        all.first.rider_id.must_equal 54
      end

      it "Includes the last trip in the csv file" do
        all.last.rider_id.must_equal 168
      end
    end

    describe "self.find" do
      it "Returns a trip object when given a valid trip ID" do
        trip = RideShare::Trip.find(111)

        trip.must_be_instance_of RideShare::Trip
        trip.driver_id.must_equal 90
      end

      it "Returns nil when given an invalid trip ID" do
        RideShare::Trip.find("TRICKERY!").must_be_nil
      end
    end

    describe "self.by_driver" do
      it "Returns an array of trips when given a valid driver ID" do
        trips = RideShare::Trip.by_driver(76)

        trips.must_be_instance_of Array
        trips.first.must_be_instance_of RideShare::Trip
      end
    end

    describe "Instance Methods" do
      let(:trip) { RideShare::Trip.new(id: 10, driver_id: 8, rider_id: 263, date: "2015-12-14", rating: 5) }

      describe "#driver" do
        it "Returns the driver object associated with the trip instance" do
          trip.driver.must_be_instance_of RideShare::Driver
          trip.driver.id.must_equal 8
        end
      end

      describe "#rider" do
        it "Returns the rider object associated with the trip instance" do
          trip.rider.must_be_instance_of RideShare::Rider
          trip.rider.id.must_equal 263
        end
      end
    end

end
