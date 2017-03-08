require_relative 'spec_helper'

describe "Trip" do

  describe "Trip#initialize" do

    before do
      @args = { trip_id: 25, driver_id: 18, rider_id: 2 , date: "2016-04-05" , rating: 5 }
      @trip = RideShare::Trip.new(@args)
    end

    it "Can be initialized" do
      @trip.must_be_instance_of RideShare::Trip
    end

    it "Takes a trip id" do
      @trip.must_respond_to :trip_id
      @trip.trip_id.must_equal @args[:trip_id]
    end

    it "Raises an ArgumentError if trip id is not an integer" do
      proc {
        RideShare::Trip.new(trip_id: "2", driver_id: 1, rider_id: 3, date: "5-6-16", rating: 5)
      }.must_raise ArgumentError
    end

    it "Takes a rider id" do
      @trip.must_respond_to :rider_id
      @trip.rider_id.must_equal @args[:rider_id]
    end

    it "Raises an ArgumentError if rider id is not an integer" do
      proc {
        RideShare::Trip.new(trip_id: 2, driver_id: 1, rider_id: "3", date: "5-6-16", rating: 5)
      }.must_raise ArgumentError
    end

    it "Takes a driver id" do
      @trip.must_respond_to :driver_id
      @trip.driver_id.must_equal @args[:driver_id]
    end

    it "Raises an ArgumentError if driver id is not an integer" do
      proc {
        RideShare::Trip.new(trip_id: 2, driver_id: "1", rider_id: 3, date: "5-6-16", rating: 5)
      }.must_raise ArgumentError
    end

    it "Takes a date" do
      @trip.must_respond_to :date
      @trip.date.must_equal @args[:date]
    end

    it "Takes a rating" do
      @trip.must_respond_to :rating
      @trip.rating.must_equal @args[:rating]
    end

    it "Raises an ArgumentError if rating is not an integer" do
      proc {
        RideShare::Trip.new(trip_id: 2, driver_id: 1, rider_id: 3, date: "5-6-16", rating: "5")
      }.must_raise ArgumentError
    end

    it "Raises an ArgumentError if rating is inappropriate value" do
      proc {
        RideShare::Trip.new(trip_id: 2, driver_id: 1, rider_id: 3, date: "5-6-16", rating: 6)
      }.must_raise ArgumentError

      proc {
        RideShare::Trip.new(trip_id: 2, driver_id: 1, rider_id: 3, date: "5-6-16", rating: 0)
      }.must_raise ArgumentError

      proc {
        RideShare::Trip.new(trip_id: 2, driver_id: 1, rider_id: 3, date: "5-6-16", rating: -1)
      }.must_raise ArgumentError
    end

  end

  describe "Trip.all" do

    before do
      @all_trips = RideShare::Trip.all
    end

    it "Can be called as a class method for the Trip class" do
      RideShare::Trip.must_respond_to :all
    end

    it "Returns an array of all trips" do
      @all_trips.must_be_kind_of Array

      @all_trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "Contains the correct amount of trips" do
      @all_trips.length.must_equal 600
    end

    it "Matches the trip information of the first and last trips in csv" do
      @all_trips.first.trip_id.must_equal 1
      @all_trips.first.driver_id.must_equal 1
      @all_trips.first.rider_id.must_equal 54
      @all_trips.first.date.must_equal "2016-04-05"
      @all_trips.first.rating.must_equal 3

      @all_trips.last.trip_id.must_equal 600
      @all_trips.last.driver_id.must_equal 61
      @all_trips.last.rider_id.must_equal 168
      @all_trips.last.date.must_equal "2016-04-25"
      @all_trips.last.rating.must_equal 3
    end

  end

  describe "Trip.find_for_driver" do

    before do
      @driver_id = 1
      @driver_trips = RideShare::Trip.find_for_driver(@driver_id)
    end

    it "Can be called as class method for the Trip class" do
      RideShare::Trip.must_respond_to :find_for_driver
    end

    it "Returns an array" do
      @driver_trips.must_be_kind_of Array
    end

    it "Returns instances of the Trip class" do
      @driver_trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "Returns the appropriate trips" do
      @driver_trips.each do |trip|
        trip.driver_id.must_equal @driver_id
      end
    end

    it "Raises an error for a driver who doesn't exist" do
      proc {
        RideShare::Trip.find_for_driver(968)
      }.must_raise RideShare::InvalidDriver
    end

  end

  describe "Trip.find_for_rider" do

    before do
      @rider_id = 54
      @rider_trips = RideShare::Trip.find_for_rider(@rider_id)
    end

    it "Can be called as class method for the Trip class" do
      RideShare::Trip.must_respond_to :find_for_rider
    end

    it "Returns an array" do
      @rider_trips.must_be_kind_of Array
    end

    it "Returns instances of the Trip class" do
      @rider_trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "Returns the appropriate trips" do
      @rider_trips.each do |trip|
        trip.rider_id.must_equal @rider_id
      end
    end

    it "Raises an error for a driver who doesn't exist" do
      proc {
        RideShare::Trip.find_for_rider(2367)
      }.must_raise RideShare::InvalidRider
    end

  end

  describe "Trip#driver" do

    before do
      @args = { trip_id: 25, driver_id: 18, rider_id: 2 , date: "2016-04-05" , rating: 5 }
      @trip = RideShare::Trip.new(@args)
    end

    it "Can be called on an instance of the Trip class" do
      @trip.must_respond_to :driver
    end

    it "Returns an instance of the Driver class" do
      @trip.driver.must_be_instance_of RideShare::Driver
    end

    it "Returns the appropriate instance of the Driver class" do
      @trip.driver.driver_id.must_equal @args[:driver_id]
    end
  end
end
