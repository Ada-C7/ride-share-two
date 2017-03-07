require_relative 'spec_helper'

describe "Trip Class" do

  describe "Initialize Method" do

    let(:trip) {
        RideShare::Trip.new({
        :trip_id => "1",
        :driver_id => "1",
        :rider_id => "1234",
        :date => "2017-04-07",
        :rating => "5"
        })
      }


    it "Initializes an object" do
      trip.must_be_instance_of RideShare::Trip
    end

    it "Initializes with IDs, date and rating" do
      trip.must_respond_to :trip_id
      trip.must_respond_to :driver_id
      trip.must_respond_to :rider_id
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
        trip.must_respond_to :rider_id
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

    let(:trips) { RideShare::Trip.all_drivers("1") }

    it "Returns an array" do
      trips.must_be_instance_of Array
    end

    it "Returns an array of objects" do
      trips.each { |t| t.must_be_instance_of RideShare::Trip }
    end

    it "All objects have the same driver id" do
      id = "1"
      trips.each do |trip|
        trip.driver_id.must_equal id
      end
    end
  end

  describe "self.all_riders" do

    let(:trips) { RideShare::Trip.all_riders("54") }

    it "Returns an array" do
      trips.must_be_instance_of Array
    end

    it "Returns an array of objects" do
      trips.each { |t| t.must_be_instance_of RideShare::Trip }
    end

    it "All objects have the same rider id" do
      id = "54"
      trips.each do |trip|
        trip.rider_id.must_equal id
      end
    end
  end

  describe "Driver method" do

    let(:trip) {
        RideShare::Trip.new({
        :trip_id => "1",
        :driver_id => "1",
        :rider_id => "54",
        :date => "2016-04-05",
        :rating => "3"
        })
      }

    it "Returns an instance of driver" do
      driver = trip.driver
      driver.must_be_instance_of RideShare::Driver
    end

    it "Returns the correct driver" do
      driver = trip.driver
      driver.name.must_equal "Bernardo Prosacco"
    end
  end

  describe "Rider method" do
    let(:trip) {
        RideShare::Trip.new({
        :trip_id => "1",
        :driver_id => "1",
        :rider_id => "54",
        :date => "2016-04-05",
        :rating => "3"
        })
      }

    it "Returns an instance of rider" do
      rider = trip.rider
      rider.must_be_instance_of RideShare::Rider
    end

    it "Returns the correct rider" do
      rider = trip.rider
      rider.name.must_equal "Gracie Emmerich"
    end
  end


end
