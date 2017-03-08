require_relative 'spec_helper'
require_relative '../lib/trip'

describe "Trip class" do
  let (:trip_hash) { { id: 162, driver_id: 6, rider_id: 93, date: "2015-03-09", rating: 4 } }
  let (:trip)  { RideShare::Trip.new(trip_hash) }

  describe "#initialize method" do
    it "Initializes a new trip instance from the parameter" do
      trip.must_be_instance_of RideShare::Trip
      trip.must_respond_to :id
      trip.id.must_equal trip_hash[:id]
      trip.must_respond_to :driver_id
      trip.driver_id.must_equal trip_hash[:driver_id]
      trip.must_respond_to :rider_id
      trip.rider_id.must_equal trip_hash[:rider_id]
      trip.must_respond_to :date
      trip.date.must_equal trip_hash[:date]
      trip.must_respond_to :rating
      trip.rating.must_equal trip_hash[:rating]
    end

    it "Raises an argument error if the rating is invalid: must be in the range (1..5)" do
      proc {
        RideShare::Driver.new({ id: 162, driver_id: 6, rider_id: 93, date: "2015-03-09", rating: 9 })
      }.must_raise ArgumentError
    end

    it "Raises an argument error if the trip_hash parameter is incomplete" do
      proc {
        RideShare::Trip.new({})
      }.must_raise ArgumentError

      proc {
        RideShare::Trip.new({ id: 162, rider_id: 93, date: "2015-03-09", rating: 4 })
      }.must_raise ArgumentError

      proc {
        RideShare::Trip.new({ nick_name: "Betsy", rating: 4 })
      }.must_raise ArgumentError
    end

    it "Raises an argument error if the parameter is not hash" do
      proc {
        RideShare::Trip.new()
      }.must_raise ArgumentError

      proc {
        RideShare::Trip.new("162,6,93,2015-03-09,4")
      }.must_raise ArgumentError
    end
  end

  describe "#find_driver method" do
    it "Retrieve the associated driver instance through the driver ID" do
      driver = trip.find_driver
      driver.class.must_equal RideShare::Driver
      driver.id.must_equal 6
      driver.name.must_equal "Mr. Hyman Wolf"
      driver.vin.must_equal "L1CXMYNZ3MMGTTYWU"
    end

    it "Raises an argument error if the driver id missing from the driver.csv" do
      trip = RideShare::Trip.new({ id: 162, driver_id: 123456789, rider_id: 93, date: "2015-03-09", rating: 4 })
      proc {
        trip.find_driver
      }.must_raise ArgumentError
    end
  end

  describe "#find_rider method" do
    it "Retrieve the associated rider instance through the rider ID" do
      driver = trip.find_rider
      driver.class.must_equal RideShare::Rider
      driver.id.must_equal 93
      driver.name.must_equal "Kaylie Okuneva IV"
      driver.phone_number.must_equal "(170) 751-2406"
    end

    it "Raises an argument error if the rider id does not have a match in the rider.csv" do
      trip = RideShare::Trip.new({ id: 162, driver_id: 93, rider_id: 123456789, date: "2015-03-09", rating: 4 })
      proc {
        trip.find_rider
      }.must_raise ArgumentError
    end
  end

  let (:all_trips_array) { RideShare::Trip.all }

  describe "#self.all method" do
    it "Retrieve all trips from the CSV file" do
      all_trips_array.must_be_instance_of Array
      all_trips_array.length.must_equal 600
      all_trips_array.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    it "First element inside the returned array matches the CSV file" do
      trip = all_trips_array.first
      trip.id.must_equal 1
      trip.driver_id.must_equal 1
      trip.rider_id.must_equal 54
      trip.date.must_equal "2016-04-05"
      trip.rating.must_equal 3
    end

    it "Last element inside the returned array matches the CSV file" do
      trip = all_trips_array.last
      trip.id.must_equal 600
      trip.driver_id.must_equal 61
      trip.rider_id.must_equal 168
      trip.date.must_equal "2016-04-25"
      trip.rating.must_equal 3
    end
  end

  describe "#self.trips_by_driver method" do

    let (:trips) { RideShare::Trip.trips_by_driver(6) }

    it "Find all trip instances for a given driver ID" do
      trips.must_be_instance_of Array
      trips.length.must_equal 3
      trips.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    it "The first element inside the returned array matches the CSV file" do
      trip = trips.first
      trip.id.must_equal 162
      trip.driver_id.must_equal 6
      trip.rider_id.must_equal 93
      trip.date.must_equal "2015-03-09"
      trip.rating.must_equal 4
    end

    it "The last element inside the returned array matches the CSV file" do
      trip = trips.last
      if trip != nil
        trip.id.must_equal 295
        trip.driver_id.must_equal 6
        trip.rider_id.must_equal 87
        trip.date.must_equal "2015-08-14"
        trip.rating.must_equal 1
      end
    end

    it "Raises an ArgumentError if trip instances specified by the driver id does not exist" do
      proc {
        RideShare::Trip.trips_by_driver(123456789)
      }.must_raise ArgumentError
    end

  end

  describe "#self.trips_by_rider method" do

    let (:trips) { RideShare::Trip.trips_by_rider(93) }

    it "Find all trip instances for a given rider ID" do
      trips.must_be_instance_of Array
      trips.length.must_equal 3
      trips.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    it "The first element inside the returned array matches the CSV file" do
      trip = trips.first
      trip.id.must_equal 162
      trip.driver_id.must_equal 6
      trip.rider_id.must_equal 93
      trip.date.must_equal "2015-03-09"
      trip.rating.must_equal 4
    end

    it "The last element inside the returned array matches the CSV file" do
      trip = trips.last
      if trip != nil
        trip.id.must_equal 184
        trip.driver_id.must_equal 75
        trip.rider_id.must_equal 93
        trip.date.must_equal "2016-04-01"
        trip.rating.must_equal 2
      end
    end

    it "Raises an ArgumentError if trip instances specified by the driver id does not exist" do
      proc {
        RideShare::Trip.trips_by_rider(123456789)
      }.must_raise ArgumentError
    end
  end
end
