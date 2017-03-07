require_relative "spec_helper"

describe "Trip" do
  describe "#initialize" do
    let(:trip1) { RideSharing::Trip.new(1, 1, 54, "2016-04-05", 3)}
    it " : Takes an id, driver_id, rider_id, date and rating as parameters" do

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
      all_trips[0].rating.must_equal 3
      all_trips[1].rating.wont_equal 6
    end

    it "trips.csv should return 600 trips" do
      all_trips = RideSharing::Trip.all
      all_trips.length.must_equal 600
    end
  end # End of describe "Trip#self.all"



end # End of describe "class Trip"
