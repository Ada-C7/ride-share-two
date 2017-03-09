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

    describe "Trip#all" do
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
    xdescribe "Trip#find" do
      it "Check that class have a find method" do
        Ride_Share::Trip.must_respond_to :find
      end

      it "Returns a driver instance with correct data " do
        # 57,Fermin Jakubowski,1C9YKRAL923SACAZM
        trip_id = "57"
        trip = Ride_Share::Trip.find(trip_id)
        trip.must_be_instance_of Ride_Share::Trip
        trip.name.must_equal 'Fermin Jakubowski'
        trip.vin.must_equal '1C9YKRAL923SACAZM'
      end
      it "Raises an argument error with trip id not in the data base" do
        # 57,Fermin Jakubowski,1C9YKRAL923SACAZM
        trip_id = "9999"
        #binding.pry
        proc { Ride_Share::Trip.find(trip_id) }.must_raise ArgumentError
      end
    end



  end







end
