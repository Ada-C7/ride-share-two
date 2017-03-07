require_relative 'spec_helper'

describe "Trip Class" do

  describe "Initialize Method" do

    let(:trip) {
        RideShare::Trip.new({
        :trip_id => "1",
        :driver_id => "1",
        :trip_id => "1234",
        :date => "2017-04-07",
        :rating => "5"
        })
      }


    it "Initializes an object" do
      trip.must_be_instance_of RideShare::Trip
    end

    it "Initializes with an ID, name, and phone number" do
      trip.must_respond_to :trip_id
      trip.must_respond_to :driver_id
      trip.must_respond_to :trip_id
      trip.must_respond_to :date
      trip.must_respond_to :rating
    end
  end

  describe "self.all" do

    let(:trips) {RideShare::Trip.all }

    it "Returns an array" do
      trips.must_be_instance_of Array
    end

    it "Returns an Array with elements" do
      trips.length.must_be :>, 0
    end

    it "Returns an array of trip Objects" do
      trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "Each trip object contains an id, name and vin" do
      trips.each do |trip|
        trip.must_respond_to :trip_id
        trip.must_respond_to :driver_id
        trip.must_respond_to :trip_id
        trip.must_respond_to :date
        trip.must_respond_to :rating
      end
    end

    it "Contains the correct information" do
      first = trips[0]
      first.trip_id.must_equal "1"
      first.driver_id.must_equal "1"
      first.date.must_equal "2016-04-05"
    end
  end

  describe "self.all_drivers" do
  end

  describe "self.all_riders" do
  end 


end
