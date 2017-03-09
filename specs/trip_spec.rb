require_relative 'spec_helper'
require_relative '../lib/trip'
require 'csv'
describe "Trip class" do
  # first_trip: 1,1,54,2016-04-05,3
  # second_trip: 2,67,146,2016-01-13,5
  # last_trip:600,61,168,2016-04-25,3

  describe "Trip#initialize" do
    let(:trip_2) { Ride_Share::Trip.new(trip_id: '2', driver_id: "1", rider_id: "54", date: "2016-04-05", rating: "3" )}
    it "Takes an ID, driver_id, rider_id, date and rating" do

      trip_2.must_respond_to :id
      trip_2.id.must_equal "2"

      trip_2.must_respond_to :driver_id
      trip_2.driver_id.must_equal "1"

      trip_2.must_respond_to :rider_id
      trip_2.rider_id.must_equal "54"

      trip_2.must_respond_to :date
      trip_2.date.must_equal "2016-04-05"

      trip_2.must_respond_to :rating
      trip_2.rating.must_equal "3"
    end

    it "Raises RatingError if rating < 1 or rating > 5" do

      proc { Ride_Share::Trip.new(trip_id: '2', driver_id: "1", rider_id: "54", date: "2016-04-05", rating: "10" )}.must_raise RatingError
    end


    describe "Trip#self.all" do
      let(:all_trips) { Ride_Share::Trip.all}

      it "Returns an array of all trip instances" do
        all_trips.must_be_kind_of Array
      end

      it 'Everything in the array is an instane of Ride_share::Trip class' do
        all_trips.each do |trip_instance|
          trip_instance.must_be_instance_of Ride_Share::Trip
        end
      end

      it "The number of trip records = 600, records in csv file" do
        all_trips.length.must_equal 600
      end

      it "The ID, driver_id, rider_id, date and rating of the first trip match what's in the CSV file" do
        # first_trip: 1,1,54,2016-04-05,3
        trip_id = "1"
        driver_id = "1"
        rider_id = "54"
        date = "2016-04-05"
        rating = "3"

        all_trips.first.id.must_equal trip_id
        all_trips.first.driver_id.must_equal driver_id
        all_trips.first.rider_id.must_equal rider_id
        all_trips.first.date.must_equal date
        all_trips.first.rating.must_equal rating
      end

      it "The ID, driver_id, rider_id, date and rating of the first trip match what's in the CSV file" do
        # last_trip:600,61,168,2016-04-25,3
        trip_id = "600"
        driver_id = "61"
        rider_id = "168"
        date = "2016-04-25"
        rating = "3"

        all_trips.last.id.must_equal trip_id
        all_trips.last.driver_id.must_equal driver_id
        all_trips.last.rider_id.must_equal rider_id
        all_trips.last.date.must_equal date
        all_trips.last.rating.must_equal rating
      end
    end
    describe "Trip#self.find_driver_trips" do

      it "The lenfth of trips list is the same count as in csv file" do
        specific_driver_id = "13"
        trips = Ride_Share::Trip.find_driver_trips(specific_driver_id)
        trips.length.must_equal 7
      end

      it "Returns the list of trip instances for a specific driver" do
        specific_driver_id = "13"
        trips = Ride_Share::Trip.find_driver_trips(specific_driver_id)
        trips.first.must_be_instance_of Ride_Share::Trip
      end

      it "Returns an empty list for a driver is not included in the trip csv data" do
        specific_driver_id = "9999"
        trips = Ride_Share::Trip.find_driver_trips(specific_driver_id)
        trips.must_equal []
      end
    end

    describe "Trip#self.find_rider_trips" do

      it "Returns the list of trip instances for a specific rider" do
        specific_rider_id = "54"
        trips = Ride_Share::Trip.find_rider_trips(specific_rider_id)
        trips.first.must_be_instance_of Ride_Share::Trip
      end

      it "Returns an empty list for a rider is not included in the trip csv data" do
        specific_rider_id = "9999"
        trips = Ride_Share::Trip.find_rider_trips(specific_rider_id)
        trips.must_equal []
      end
    end

    describe "Trip#retrieve_driver" do
      it "Check the driver name for the first trip" do
        # first_trip: 1,1,54,2016-04-05,3
        trip = Ride_Share::Trip.all.first

        trip.retrieve_driver.name.must_equal "Bernardo Prosacco"
      end
    end

    describe "Trip#retrieve_rider" do
      it "Check the rider name for the first trip" do
        # first_trip: 1,1,54,2016-04-05,3
        trip = Ride_Share::Trip.all.first
        trip.retrieve_rider.name.must_equal "Gracie Emmerich"
      end
    end
  end

end
