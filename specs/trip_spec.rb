require_relative 'spec_helper'
require_relative '../lib/trip'

describe RideShare::Trip do

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

end
