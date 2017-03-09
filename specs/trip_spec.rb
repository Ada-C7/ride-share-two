require_relative 'spec_helper'
require_relative '../lib/trip'


describe "Trip tests" do
  describe "Trip#initialize" do
    it "takes an id, driver, rider, date, and rating" do
        new_trip = Trip.new(1234, 1, 56, "2016-04-05", 5)

        new_trip.must_respond_to :id
        new_trip.id.must_equal 1234

        new_trip.must_respond_to :driver
        new_trip.driver.must_equal 1

        new_trip.must_respond_to :rider
        new_trip.rider.must_equal 56

        new_trip.must_respond_to :date
        new_trip.date.must_equal "2016-04-05"

        new_trip.must_respond_to :rating
        new_trip.rating.must_equal 5
    end

    it "rating must be on a 1-5 scale and an integer" do

      proc {Trip.new(1234, 1, 56, "2016-04-05", 7)}.must_raise ArgumentError

      proc {Trip.new(1234, 1, 56, "2016-04-05", 0)}.must_raise ArgumentError

      proc {Trip.new(1234, 1, 56, "2016-04-05", -1)}.must_raise ArgumentError

      proc {Trip.new(1234, 1, 56, "2016-04-05", 1.5)}.must_raise ArgumentError

    end


  end

  describe "Trip.all" do
    it "returns an array of all trips" do
      Trip.all.class.must_equal Array
    end

    it "each element in array is a Trip" do

      Trip.all.each do |element|
        element.must_be_instance_of Trip
      end

    end
  end

  describe "Trip.rider_find_all(search_id)" do
    before do
        @csv_file = CSV.read("./support/trips.csv", {:headers => true})
    end

    it "returns an array of all trips for specific rider" do
      Trip.rider_find_all(3).class.must_equal Array
    end

    it "each element in the array is a Trip" do
      Trip.rider_find_all(3).each do |element|
        element.class.must_equal Trip
      end
    end

    it "raises an ArgumentError if there are no trips matching rider" do
      proc {Trip.rider_find_all(@csv_file.length + 100)}.must_raise ArgumentError
    end

  end

  describe "Trip.driver_find_all(search_id)" do
    before do
      @csv_file = CSV.read("./support/trips.csv", {:headers => true})
    end

    it "returns an array of all trips for specific driver" do
      Trip.driver_find_all(3).class.must_equal Array
    end

    it "each element in the array is a Trip" do
      Trip.driver_find_all(3).each do |element|
        element.class.must_equal Trip
      end
    end

    it "raises an ArgumentError if there are no trips matching rider" do
      proc {Trip.driver_find_all(@csv_file.length + 100)}.must_raise ArgumentError
    end
  end

end
