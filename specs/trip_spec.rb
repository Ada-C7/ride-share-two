require_relative 'spec_helper'
require_relative '../lib/trip'
require 'csv'
describe "Trip class" do
  # first_trip: 1,1,54,2016-04-05,3
  # second_trip: 2,67,146,2016-01-13,5
  # last_trip:600,61,168,2016-04-25,3

  describe "Trip#initialize" do
    let(:trip_2) { Ride_Share::Trip.new(trip_id: '2', driver_id: "1", rider_id: "54", date: "2016-04-05", rating: "3" )}
    it "Takes an ID,  driver_id, rider_id, date and rating" do

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

    describe "Driver#all" do
      let(:all_drivers) { Ride_Share::Driver.all}

      it "Returns an array of all driver instances" do
        all_drivers.must_be_kind_of Array
      end

      it 'Everything in the array is an instane of Ride_share::Driver class' do
        all_drivers.each do |driver_instance|
          driver_instance.must_be_instance_of Ride_Share::Driver
        end
      end

      it "The number of driver records = 100, records in csv file" do
        all_drivers.length.must_equal 100
      end

      it "The ID and name and vihecle identification of the first driver match what's in the CSV file" do
        #1 Bernardo Prosacco	WBWSS52P9NEYLVDE9
        driver_id = "1"
        name = "Bernardo Prosacco"
        vin = "WBWSS52P9NEYLVDE9"

        all_drivers.first.id.must_equal driver_id
        all_drivers.first.name.must_equal name
        all_drivers.first.vin.must_equal vin
      end

      it "The ID and name and vihecle identification of the last driver match what's in the CSV file" do
        # 100,Minnie Dach,XF9Z0ST7X18WD41HT
        driver_id = "100"
        name = "Minnie Dach"
        vin = "XF9Z0ST7X18WD41HT"

        all_drivers.last.id.must_equal driver_id
        all_drivers.last.name.must_equal name
        all_drivers.last.vin.must_equal vin
      end
    end
  end







end
