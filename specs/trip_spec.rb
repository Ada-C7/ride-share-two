require_relative 'spec_helper'


describe "Trip" do

  describe "#initialize" do
    it "Takes an ID, driver ID, raider ID, date, and rating" do
      id = 12345
      driver_id = 45678
      rider_id = 9876
      date = "2016-04-05"
      rating = 4
      trip = Trip.new(id, driver_id, rider_id, date, rating)

      trip.must_respond_to :id
      trip.id.must_equal id

      trip.must_respond_to :driver_id
      trip.driver_id.must_equal driver_id

      trip.must_respond_to :rider_id
      trip.rider_id.must_equal rider_id

      trip.must_respond_to :date
      trip.date.must_equal date

      trip.must_respond_to :rating
      trip.rating.must_equal rating
    end

    it "Is a kind of Trip" do
      id = 12345
      driver_id = 45678
      rider_id = 9876
      date = "2016-04-05"
      rating = 4
      trip = Trip.new(id, driver_id, rider_id, date, rating)

      trip.must_be_kind_of Trip
    end
  end

  describe "Trip.all" do

    before do
      @trips = Trip.all
    end

    it "Returns an array of all trips" do
      @trips.class.must_equal Array
      @trips.each { |trip| trip.must_be_instance_of Trip }
      @trips.length.must_equal 600

      @trips.first.id.must_equal 1
      @trips[0].driver_id.must_equal 1
      @trips.first.rider_id.must_equal 54
      @trips.first.date.must_equal "2016-04-05"
      @trips.first.rating.must_equal 3

      @trips.last.id.must_equal 600
      @trips[-1].driver_id.must_equal 61
      @trips.last.rider_id.must_equal 168
      @trips.last.date.must_equal "2016-04-25"
      @trips.last.rating.must_equal 3

      # not working, CSV file is not being read
      # index = 0
      # CSV.read("support/trips.csv", { :headers => true }) do |line|
      #   @trips[index].id.must_equal line[0].to_i
      #   puts @trips
      #   @trips[index].driver_id.must_equal line[1].to_i
      #   @trips[index].rider_id.must_equal line[2].to_i
      #   @trips[index].date.must_equal line[3]
      #   @trips[index].rating.must_equal line[4].to_i
      #   index += 1
      # end
    end
  end

  describe "Trip.find_trips_driver" do

    before do
      @driver_trips = Trip.find_trips_driver(1)
    end

    it "Returns a list of trips" do
      @driver_trips.must_be_kind_of Array
      @driver_trips.each { |trip| trip.must_be_instance_of Trip }

      # trips = 0
      # CSV.read("support/trips.csv", { :headers => true }).each do |line|
      #    trips += 1 if line[1].to_i == 1
      # end

      @driver_trips.length.must_equal 9
    end

    it "Returns an empty array for a driver ID that doesn't exist" do
      Trip.find_trips_driver(101).must_equal []
    end
  end

  describe "Trip.find_trips_rider" do

    before do
      @rider_trips = Trip.find_trips_rider(1)
    end

    it "Returns a list of trips" do
      @rider_trips.must_be_kind_of Array
      @rider_trips.each { |trip| trip.must_be_instance_of Trip }

      @rider_trips.length.must_equal 2
    end

    it "Returns an empty array if there are no trips for this rider ID" do
      Trip.find_trips_rider(100).must_equal []
    end

    it "Returns an empty array for a rider ID that doesn't exist" do
      Trip.find_trips_rider(301).must_equal []
    end
  end

  describe "trip#driver" do
    it "Returns a driver that exists" do
      trip = Trip.new(100, 29, 138, "2016-09-04", 2)
      trip.driver.must_be_kind_of Driver
    end

    it "Returns the correct driver for a specific trip" do
      trip = Trip.new(100, 29, 138, "2016-09-04", 2)
      name = "Miss Gustave Erdman"
      trip.driver.name.must_equal name
    end

    it "Returns an empty array if there are no trips for this driver ID" do
      Trip.find_trips_driver(100).must_equal []
    end

    it "Returns nil if driver doesn't exist" do
      trip = Trip.new(83, 0, 103, "2015-12-25", 2)
      trip.driver.must_equal nil
    end
  end

  describe "trip#rider" do
    it "Returns a rider that exists" do
      trip = Trip.new(100, 29, 138, "2016-09-04", 2)
      trip.rider.must_be_kind_of Rider
    end

    it "Returns the correct rider for a specific trip" do
      trip = Trip.new(100, 29, 138, "2016-09-04", 2)
      name = "Miss Frida Abshire"
      trip.rider.name.must_equal name
    end

    it "Returns nil if rider doesn't exist" do
      trip = Trip.new(267, 14, 0, "2015-04-23", 4)
      trip.rider.must_equal nil
    end
  end

end
