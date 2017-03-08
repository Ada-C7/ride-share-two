require_relative 'spec_helper'

describe "Trip" do
  before do
    @great_trip = Trip.new(1234, 1, 56, "2016-04-05", 5)
  end

  describe "#initialize" do
    it "takes an id, driver_id, rider_id, date, and rating" do
      @great_trip.must_respond_to :id
      @great_trip.id.must_equal 1234

      @great_trip.must_respond_to :driver
      @great_trip.driver_id.must_equal 1

      @great_trip.must_respond_to :rider
      @great_trip.rider_id.must_equal 56

      @great_trip.must_respond_to :date
      @great_trip.date.must_equal "2016-04-05"

      @great_trip.must_respond_to :rating
      @great_trip.rating.must_equal 5
    end

    it "must be an instance of the Trip class" do
      @great_trip.must_be_instance_of Trip
    end

    it "must have a rating between 1 - 5" do
      proc {
        Trip.new(20394, 34, 40, "2017-04-27", 7)
      }.must_raise ArgumentError
    end

  end # end of describe initialize

  describe "Trip#all" do
    before do
      @trips = Trip.all
    end

    it "it returns all the trips from the CSV file" do
      @trips.must_be_instance_of Array

      (@trips.each { |i| return i }).must_be_instance_of Trip

      @trips.length.must_equal 600
    end
  end # end of describe Trip.all method

  describe "#driver" do
    it "returns the driver instance that is associated with this driver id" do
      first_trip = Trip.new(1, 1, 54, "2016-04-05", 3)
      first_trip.driver.must_be_instance_of Driver
      first_trip.driver.id.must_equal 1
      first_trip.driver.name.must_equal "Bernardo Prosacco"
      first_trip.driver.vin.must_equal "WBWSS52P9NEYLVDE9"
    end
  end # end of describe driver method

  describe "#rider" do
    it "returns the rider instance that is associated with this rider id" do
      skip
      first_trip = Trip.new(1, 1, 54, "2016-04-05", 3)
      first_trip.rider.must_be_instance_of Rider
      first_trip.rider.id.must_equal 54
      first_trip.rider.name.must_equal "Gracie Emmerich"
      first_trip.rider.phone.must_equal "591-707-1595 x0908"
    end
  end # end of describe rider method

  describe "Trip#find_all_for_driver" do
    before do
      @trips = Trip.all
    end

    it "returns a collection of trip instances" do
      trips_for_a_driver = Trip.find_all_for_driver(@trips[0].driver_id)
      trips_for_a_driver.must_be_instance_of Array
    end

    it "returns a trip that exists" do
      trips_for_a_driver = Trip.find_all_for_driver(@trips[10].driver_id)
      trips_for_a_driver[0].must_be_instance_of Trip
    end

    it "Raises an error for a driver that doesn't exist" do
      skip
      proc {
        Trip.find_all_for_driver(111111)
      }.must_raise ArgumentError
    end
  end # end of describe find_all_for_driver method

  describe "Trip#find_all_for_rider" do
    before do
      @trips = Trip.all
    end

    it "returns a collection of trip instances" do
      trips_for_a_rider = Trip.find_all_for_rider(@trips[0].rider_id)
      trips_for_a_rider.must_be_instance_of Array
    end

    it "returns a trip that exists" do
      trips_for_a_rider = Trip.find_all_for_rider(@trips[10].rider_id)
      trips_for_a_rider[0].must_be_instance_of Ride
    end

    it "Raises an error for a driver that doesn't exist" do
      skip
      proc {
        Trip.find_all_for_rider(111111)
      }.must_raise ArgumentError
    end
  end # end of describe find_all_for_rider method

end # end of describe Trip
