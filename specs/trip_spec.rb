require_relative 'spec_helper'

describe "Trip" do
  before do
    @id = 68
    @rider_id = 78
    @driver_id = 88
    @date = '2017-8-03' #can't be a future date
    @rating = 3 # int, 1-5
  end

  let (:trip) {RideShare::Trip.new(id: @id, rider_id: @rider_id,
    driver_id: @driver_id, date: @date, rating: @rating )}

  describe "constructor" do
    it "can be instantiated" do
      trip.must_be_instance_of RideShare::Trip
    end

    it "takes an id, rider_id, driver_id, date, and rating" do
      trip.must_respond_to :id
      trip.id.must_equal @id

      trip.must_respond_to :rider_id
      trip.rider_id.must_equal @rider_id

      trip.must_respond_to :driver_id
      trip.driver_id.must_equal @driver_id

      trip.must_respond_to :date
      trip.date.must_equal @date

      trip.must_respond_to :rating
      trip.rating.must_equal @rating
    end

    # Trip rating must equal 1, 2, 3. 4. or 5
    it "raises an argument error if rating is not initialized with an integer" do
      proc {
        RideShare::Trip.new(rating: '3')
      }.must_raise ArgumentError
    end

    it "raises an invalid rating error if rating is not above 1" do
      invalid_rating = 0

      proc {
        RideShare::Trip.new(rating: invalid_rating)
      }.must_raise RideShare::InvalidRatingError
    end

    it "raises an invalid rating error if rating is not below 5" do
      invalid_rating = 6

      proc {
        RideShare::Trip.new(rating: invalid_rating)
      }.must_raise RideShare::InvalidRatingError
    end

    it "accepts a rating of 1" do
      rating = 1
      trip = RideShare::Trip.new(rating: rating)
      trip.rating.must_equal rating
    end

    it "accepts a rating of 5" do
      rating = 5
      trip = RideShare::Trip.new(rating: rating)
      trip.rating.must_equal rating
    end
  end

  # As this method calls the Driver.find method, extensive testing was not done.
  describe "driver" do
    it "returns the Driver instance that matches the Trip's driver_id attribute" do
      driver = trip.driver

      driver.must_be_instance_of RideShare::Driver
      driver.id.must_equal trip.driver_id
    end

    it "returns nil if @driver_id is undefined" do
      trip = RideShare::Trip.new(id: @id)
      trip.driver.must_be_nil
    end
  end

  # As this method calls the Rider.find method, extensive testing was not done.
  describe "rider" do
    it "returns the Rider instance that matches the Trip's rider_id attribute" do
      rider = trip.rider

      rider.must_be_instance_of RideShare::Rider
      rider.id.must_equal trip.rider_id
    end

    it "returns nil if @rider_id is undefined" do
      trip = RideShare::Trip.new(id: @id)
      trip.rider.must_be_nil
    end
  end

  describe "Trip.all" do
    let (:trips) {RideShare::Trip.all}
    let (:trip_csv_info) {CSV.read("support/trips.csv")[1 .. -1]} # ignore headers

    it "returns an array" do
      trips.must_be_instance_of Array
    end

    it "contains only Trip elements in the returned array" do
      trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "returns the correct number of trips" do
      expected_num_of_trips = trip_csv_info.size
      num_of_trips = trips.size

      num_of_trips.must_equal expected_num_of_trips
    end

    it "initializes a first Trip with the CSV's first listed trip id, rider id,
    driver id, date, and rating" do
      first_trip_id = trip_csv_info.first[0].to_i
      first_trip_driver_id = trip_csv_info.first[1].to_i
      first_trip_rider_id = trip_csv_info.first[2].to_i
      first_trip_date = trip_csv_info.first[3]
      first_trip_rating = trip_csv_info.first[4].to_i

      trips.first.id.must_equal first_trip_id
      trips.first.driver_id.must_equal first_trip_driver_id
      trips.first.rider_id.must_equal first_trip_rider_id
      trips.first.date.must_equal first_trip_date
      trips.first.rating.must_equal first_trip_rating
    end

    it "initializes a last Trip with the CSV's last listed trip id, rider id,
    driver id, date, and rating" do
    last_trip_id = trip_csv_info.last[0].to_i
    last_trip_driver_id = trip_csv_info.last[1].to_i
    last_trip_rider_id = trip_csv_info.last[2].to_i
    last_trip_date = trip_csv_info.last[3]
    last_trip_rating = trip_csv_info.last[4].to_i

    trips.last.id.must_equal last_trip_id
    trips.last.driver_id.must_equal last_trip_driver_id
    trips.last.rider_id.must_equal last_trip_rider_id
    trips.last.date.must_equal last_trip_date
    trips.last.rating.must_equal last_trip_rating
    end
  end

  # seems excessive. What tests are necessary?
  describe "Trip.find_all_for_driver" do
    let (:trips_for_driver_88) {RideShare::Trip.find_all_for_driver(88)}
    # Driver 88 -> Trip [47, 80, 174, 271, 548]

    it "returns an array" do
      trips_for_driver_88.must_be_instance_of Array
    end

    it "contains only Trip instances in the returned array" do
      trips_for_driver_88.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "returns the correct number of Trips" do
      trips_for_driver_88.length.must_equal 5
    end

    it "returns Trip instances that have a driver_id matching the one given" do
      trips_for_driver_88.each do |trip|
        trip.driver_id.must_equal 88
      end
    end

    it "finds the first Trip associated with a given driver_id from the csv file" do
      trips_for_driver_88.first.id.must_equal 47
    end

    it "finds the last Trip associated with a given driver_id from the csv file" do
      trips_for_driver_88.last.id.must_equal 548
    end

    it "returns an empty array if the driver_id is not found" do
      fake_driver_id = 108
      trips_for_fake_driver = RideShare::Trip.find_all_for_driver(fake_driver_id)
      trips_for_fake_driver.must_be_empty
    end
  end

  describe "Trip.find_all_for_rider" do
    let (:trips_for_rider_88) {RideShare::Trip.find_all_for_rider(88)}
    # Rider 88 -> Trip [139, 273, 285, 310, 352, 490]

    it "returns an array" do
      trips_for_rider_88.must_be_instance_of Array
    end

    it "contains only Trip instances in the returned array" do
      trips_for_rider_88.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "returns the correct number of Trips" do
      trips_for_rider_88.length.must_equal 6
    end

    it "returns Trip instances that have a rider_id matching the one given" do
      trips_for_rider_88.each do |trip|
        trip.rider_id.must_equal 88
      end
    end

    it "finds the first Trip associated with a given rider_id from the csv file" do
      trips_for_rider_88.first.id.must_equal 139
    end

    it "finds the last Trip associated with a given rider_id from the csv file" do
      trips_for_rider_88.last.id.must_equal 490
    end

    it "returns an empty array if the rider_id is not found" do
      fake_rider_id = 308
      trips_for_fake_rider = RideShare::Trip.find_all_for_rider(fake_rider_id)
      trips_for_fake_rider.must_be_empty
    end
  end
end
