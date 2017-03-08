require_relative 'spec_helper'

describe "Trip class" do
  let(:trip_hash) {{trip_id: 123, rider_id: 2, driver_id: 34, date: "2016-05-02", rating: 4, cost: 100, duration: 35}}
  let(:trip) {RideShare::Trip.new(trip_hash)}
  let(:all_trips) { RideShare::Trip.all_trips_by_driver(67) }
  let(:all_trips2) { RideShare::Trip.all_trips_by_rider(50) }
  let(:all_trips_from_csv) { RideShare::Trip.all_trips }

  describe "Trip#initialize" do
    it "Creates new instance of Trip class" do
      trip.class.must_equal RideShare::Trip
    end
    it "Raise ArgumentError if passing parameter is not a hash" do
      proc{
        RideShare::Trip.new([1,2,3,4,5])
      }.must_raise ArgumentError
    end
    it "Has driver_id, rider_id, trip_id , rating and date as initial values" do
      trip.must_respond_to :trip_id
      trip.must_respond_to :rider_id
      trip.must_respond_to :driver_id
      trip.must_respond_to :date
      trip.must_respond_to :rating
    end
    it "Raises error if rating is not betwee 1 to 5" do
      proc{ hash = {trip_id: 123, rider_id: 2, driver_id: 34, date: "2016-05-02", rating: 6, cost: 100, duration: 35}
      trip = RideShare::Trip.new(hash)
      }.must_raise ArgumentError
    end
    it "Raises error if rider id is not integer" do
      proc{ hash = {trip_id: 123, rider_id: "23", driver_id: 34, date: "2016-05-02", rating: 4, cost: 100, duration: 35}
      trip = RideShare::Trip.new(hash)
      }.must_raise ArgumentError
    end
    it "Raises error if trip id is not positive integer" do
      proc {
        hash = {trip_id: -123, rider_id: 2, driver_id: 34, date: "2016-05-02", rating: 4, cost: 100, duration: 35}
        trip = RideShare::Trip.new(hash)
        }.must_raise ArgumentError
      proc {
        hash = {trip_id: "123", rider_id: 2, driver_id: 34, date: "2016-05-02", rating: 4, cost: 100, duration: 35}
        trip = RideShare::Trip.new(hash)
        }.must_raise ArgumentError
    end
    it "Raises error if driver id is not integer" do
      proc{
         hash = {trip_id: 123, rider_id: 23, driver_id: "34", date: "2016-05-02", rating: 4, cost: 100, duration: 35}
          trip = RideShare::Trip.new(hash)
        }.must_raise ArgumentError
    end
    it "Raises error if date is not a string" do
      proc {
        hash = {trip_id: 123, rider_id: 23, driver_id: 32, date: 20160412, rating: 4, cost: 100, duration: 35}
        trip = RideShare::Trip.new(hash)
      }.must_raise ArgumentError
    end
  end # end of initialize method tests

  describe "Trip#driver" do
    it " Return instance of class Driver" do
      trip.driver.class.must_equal RideShare::Driver
    end
    it "Id of returned driver must be the same as instance variable @driver_id of Trip class" do
      trip.driver.driver_id.must_equal trip.driver_id
    end
    it "Raise ArgumentError if driver with id is not found" do
      proc {
        trip_hash = {trip_id: 123, rider_id: 2, driver_id: 50000, date: "2016-05-02", rating: 4, cost: 100, duration: 35}
        trip = RideShare::Trip.new(trip_hash)
        trip.driver
      }.must_raise ArgumentError
    end
  end # end of rider method


  describe "Trip#rider" do
    it "Return instance of class Rider" do
      trip.rider.class.must_equal RideShare::Rider
    end
    it "Id of returned rider must be the same as instance variable @rider_id of Trip class" do
      trip.rider.rider_id.must_equal trip.rider_id
    end
    it "Raise ArgumentError if rider with id is not found" do
      proc{
        trip_hash = {trip_id: 123, rider_id: 200000, driver_id: 50000, date: "2016-05-02", rating: 4, cost: 100, duration: 35}
        trip = RideShare::Trip.new(trip_hash)
        trip.rider
      }.must_raise ArgumentError
    end
  end

  describe "Trip#all_trips_by_driver" do
    it "Returns an array if driver(s) was found" do
      all_trips.class.must_equal Array
    end
    it "Returns empty array if  driver(s) was not found" do
      all_trips = RideShare::Trip.all_trips_by_driver(9000)
      all_trips.must_equal []
    end
    it "Raises error if driver id is not an integer or if <= 0" do
      proc {
        RideShare::Trip.all_trips_by_driver("21")
      }.must_raise ArgumentError
    end
    it "Each element in returned array must be instance of Trip class" do
      all_trips.each do |trip|
        trip.class.must_equal RideShare::Trip
      end
    end
    it " Trips in returned array must have the same driver_id as
    driver_id in passing parameter to  all_trips_by_driver method" do
      driver_id = 67
      all_trips.each do |trip|
        trip.driver_id.must_equal driver_id
      end
    end
    it "Finds trips of first and last driver from the list of drivers" do
      # 99 because driver with id 100 doesn't have any trips
      RideShare::Trip.all_trips_by_driver(99).length.must_be :>, 0
      RideShare::Trip.all_trips_by_driver(1).length.must_be :>, 0
    end
  end # end of all_trips_by_driver method

  describe "Trip#all_trips_by_rider" do
    it "Returns an array if rider(s) was found" do
      all_trips2.class.must_equal Array
    end
    it "Returns empty array if  driver(s) was not found" do
      all_trips = RideShare::Trip.all_trips_by_rider(9000)
      all_trips.must_equal []
    end
    it "Raises error if rider id is not an integer or if <= 0" do
      proc {
        RideShare::Trip.all_trips_by_rider("21")
      }.must_raise ArgumentError
    end
    it "Each element in returned array must be instance of Trip class" do
      all_trips2.each do |trip|
        trip.class.must_equal RideShare::Trip
      end
    end
    it " Trips in returned array must have the same rider_id as
    rider_id in passing parameter to  all_trips_by_rider method" do
      rider_id = 50
      all_trips2.each do |trip|
        trip.rider_id.must_equal rider_id
      end
    end
    it "Finds trips of two random riders from the list of riders" do
      RideShare::Trip.all_trips_by_rider(298).length.must_be :>, 0
      RideShare::Trip.all_trips_by_rider(1).length.must_be :>, 0
    end
  end # end of all_trips_by_rider method

  describe "Trip#all_trips" do
    it "Trip#all_trips return an array" do
      all_trips_from_csv.must_be_kind_of Array
    end
    it "Everything in the array is an Trip class" do
      all_trips_from_csv.each do |trip|
        trip.must_be_kind_of RideShare::Trip
      end
    end
    it " The number of trips is correct" do
      all_trips_from_csv.length.must_equal 600
    end
    it "The trip_id, driver_id, rider_id, date and rating of the first
      and last trips match what's in the CSV file" do
      csv = CSV.read("support/trips.csv", 'r')

      expected_trip_id_first = csv[1][0].to_i
      expected_driver_id_first = csv[1][1].to_i
      expected_rider_id_first = csv[1][2].to_i
      expected_date_first = csv[1][3]
      expected_rating_first = csv[1][4].to_i

      expected_trip_id_last = csv[600][0].to_i
      expected_driver_id_last = csv[600][1].to_i
      expected_rider_id_last = csv[600][2].to_i
      expected_date_last = csv[600][3]
      expected_rating_last = csv[600][4].to_i

      all_trips = RideShare::Trip.all_trips

      all_trips_from_csv[0].trip_id.must_equal expected_trip_id_first
      all_trips_from_csv[0].driver_id.must_equal expected_driver_id_first
      all_trips_from_csv[0].rider_id.must_equal expected_rider_id_first
      all_trips_from_csv[0].date.to_s.must_equal expected_date_first
      all_trips_from_csv[0].rating.must_equal expected_rating_first

      all_trips_from_csv[599].trip_id.must_equal expected_trip_id_last
      all_trips_from_csv[599].driver_id.must_equal expected_driver_id_last
      all_trips_from_csv[599].rider_id.must_equal expected_rider_id_last
      all_trips_from_csv[599].date.to_s.must_equal expected_date_last
      all_trips_from_csv[599].rating.must_equal expected_rating_last
    end
  end
end
