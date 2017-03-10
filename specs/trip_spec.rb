require_relative "spec_helper"

describe "Trip" do
  describe "#initialize" do
    let(:trip1) { RideSharing::Trip.new(1, 1, 54, "2016-04-05", 3)}
    it " : Takes an id, driver_id, rider_id, date and rating as parameters" do
      trip1
      trip1.must_respond_to :id
      trip1.id.must_equal 1

      trip1.must_respond_to :driver_id
      trip1.driver_id.must_equal 1

      trip1.must_respond_to :rider_id
      trip1.rider_id.must_equal 54

      trip1.must_respond_to :date
      trip1.date.must_equal "2016-04-05"

      trip1.must_respond_to :rating
      trip1.rating.must_equal 3
    end

    it "All parameters are integers except date that is a string" do
      trip1
      trip1.id.must_be_kind_of Integer
      trip1.driver_id.must_be_kind_of Integer
      trip1.rider_id.must_be_kind_of Integer
      trip1.date.must_be_kind_of String
      trip1.rating.must_be_kind_of Integer
    end
  end # End of describe "Trip#initialize"


  describe "#self.all" do
    it "Returns an array." do
      path = "./support/trips_spec_true.csv"
      all_trips = RideSharing::Trip.all(path)
      all_trips.must_be_kind_of Array
    end

    it "The elements in the returned array must be RideSharing::Trip instances " do
      path = "./support/trips_spec_true.csv"
      all_trips = RideSharing::Trip.all(path)
      all_trips.each do |obj|
        obj.must_be_kind_of RideSharing::Trip
      end
      all_trips.length.must_equal 5
    end

    it "Does not initialize trip if rating is not valid" do
      path = "./support/trips_spec_false.csv"
      all_trips = RideSharing::Trip.all(path)
      all_trips.length.must_equal 3
      all_trips.first.id.must_equal 1
      all_trips[1].id.wont_equal 2
      all_trips.last.id.wont_equal 5
    end

    it "trips.csv should return 600 trips" do
      all_trips = RideSharing::Trip.all
      all_trips.length.must_equal 600
    end
  end # End of describe "Trip#self.all"


  describe "#self.find_all_trips_for_driver" do
    let(:trip_collection) {RideSharing::Trip.find_all_trips_for_driver(1)}
    it "Will return an array" do
      trip_collection
      trip_collection.must_be_kind_of Array
    end

    it "Must return an array with elements of class RideSharing::Trip" do
      trip_collection
      trip_collection.each do |obj|
        obj.must_be_kind_of RideSharing::Trip
      end
    end

    it "Must return an array of Trip objects only for driver with id 1" do
      trip_collection
      trip_collection.each do |obj|
        obj.driver_id.must_equal 1
      end
    end
  end # End of describe "#self.find_all_trips_for_driver"


  describe "#self.find_all_trips_for_rider" do
    let(:trip_collection) {RideSharing::Trip.find_all_trips_for_rider(104)}
    it "Will return an array" do
      trip_collection
      trip_collection.must_be_kind_of Array
    end

    it "Must return an array with elements of class RideSharing::Trip" do
      trip_collection
      trip_collection.each do |obj|
        obj.must_be_kind_of RideSharing::Trip
      end
    end

    it "Must return an array of Trip objects only for rider with id 104" do
      trip_collection
      trip_collection.each do |obj|
        obj.rider_id.must_equal 104
      end
    end

    it "Must return an array of Trip objects only for rider with id 39" do
      RideSharing::Trip.find_all_trips_for_rider(39).each do |obj|
        puts obj.id
      end
    end
  end # End of describe "#self.find_all_trips_for_rider"


  describe "#find_driver" do
    let(:trip1) { RideSharing::Trip.new(1, 1, 54, "2016-04-05", 3)}
    it "Return must be an object of class RideSharing::Driver" do
      trip1
      trip1.find_driver.must_be_kind_of RideSharing::Driver
    end
  end # End of describe "#find_driver"


  describe "#find_rider" do
    let(:trip1) { RideSharing::Trip.new(1, 1, 54, "2016-04-05", 3)}
    it "Return must be an object of class RideSharing::Rider" do
      trip1
      trip1.find_rider.must_be_kind_of RideSharing::Rider
    end
  end # End of describe "#find_driver"



end # End of describe "class Trip"
