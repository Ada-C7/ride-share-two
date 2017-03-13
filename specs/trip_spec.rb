require_relative "spec_helper"

describe "Trip" do
  describe "#initialize" do
    let(:trip1) { RideSharing::Trip.find(1)}
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

    it "The input for :trip_id must be an integer > 0" do
      proc{
        RideSharing::Trip.new({trip_id: "3", driver_id: 1, rider_id: 1, date: "2017-03-13", rating:5})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({trip_id: 0, driver_id: 1, rider_id: 1, date: "2017-03-13", rating:5})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({ driver_id: 1, rider_id: 1, date: "2017-03-13", rating:5})
      }.must_raise ArgumentError
    end

    it "The input for :driver_id must be an integer >= 0" do
      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: "1", rider_id: 1, date: "2017-03-13", rating:5})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: -1, rider_id: 1, date: "2017-03-13", rating:5})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({trip_id: 1, rider_id: 1, date: "2017-03-13", rating:5})
      }.must_raise ArgumentError
    end

    it "The input for :rider_id must be an integer >= 0" do
      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: 1, rider_id: "1", date: "2017-03-13", rating:5})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: 1, rider_id: -1, date: "2017-03-13", rating:5})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: 1, date: "2017-03-13", rating:5})
      }.must_raise ArgumentError
    end


    it "The input for :date must be a string of format yyyy-mm-dd" do
      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: 1, rider_id: 1, date: "17-03-13", rating:5})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: 1, rider_id: 1, date: "2017/03/13", rating:5})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: 1, rider_id: 1, date: ["2017-03-13"], rating:5})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: 1, rider_id: 1, date: "[2017-03-13]", rating:5})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: 1, rider_id: 1, rating:5})
      }.must_raise ArgumentError
    end

    it "The input for :rating must be an integer between and including 1 and 5" do
      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: 1, rider_id: 1, date: "2017-03-13", rating: 6})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: 1, rider_id: 1, date: "2017-03-13", rating: 0})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: 1, rider_id: 1, date: "2017-03-13", rating: "1"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: 1, rider_id: 1, date: "2017-03-13", rating: [5]})
      }.must_raise ArgumentError

      proc{
        RideSharing::Trip.new({trip_id: 1, driver_id: 1, rider_id: 1, date: "2017-03-13"})
      }.must_raise ArgumentError

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
      all_trips.length.must_equal 12 #Out of 20
      all_trips.first.id.must_equal 1
      all_trips[1].id.wont_equal 2
      all_trips.last.id.wont_equal 20
    end

    it "trips.csv should return 600 trips" do
      all_trips = RideSharing::Trip.all
      all_trips.length.must_equal 600
    end
  end # End of describe "Trip#self.all"


  describe "#self.find" do
    it "returns an object of class RideSharing::Trip if id isfound" do
      returned_object = RideSharing::Trip.find(1)
      returned_object.must_be_kind_of RideSharing::Trip
    end

    it "Returns nil if id is not found" do
      RideSharing::Trip.find(601).must_be_nil
    end
  end # End of describe "Trip#self.find"


  describe "#self.find_all_trips_for_driver" do
    let(:trip_collection_d1) {RideSharing::Trip.find_all_trips_for_driver(1)}
    it "Will return an array" do
      trip_collection_d1.must_be_kind_of Array
    end

    it "Must return an array with elements of class RideSharing::Trip" do
      trip_collection_d1.each do |obj|
        obj.must_be_kind_of RideSharing::Trip
      end
    end

    it "Must return an array of Trip objects only for driver with id 1" do
      trip_collection_d1.each do |obj|
        obj.driver_id.must_equal 1
      end
    end

    it "Must return an empty array if driver id is not found or valid" do
      RideSharing::Trip.find_all_trips_for_driver(101).must_be_kind_of Array
      RideSharing::Trip.find_all_trips_for_driver(101).must_be_empty
      RideSharing::Trip.find_all_trips_for_driver("100").must_be_kind_of Array
      RideSharing::Trip.find_all_trips_for_driver("100").must_be_empty
    end
  end # End of describe "#self.find_all_trips_for_driver"


  describe "#self.find_all_trips_for_rider" do
    let(:trip_collection_r1) {RideSharing::Trip.find_all_trips_for_rider(1)}
    it "Will return an array" do
      trip_collection_r1.must_be_kind_of Array
    end

    it "Must return an array with elements of class RideSharing::Trip" do
      trip_collection_r1.each do |obj|
        obj.must_be_kind_of RideSharing::Trip
      end
    end

    it "Must return an array of Trip objects only for rider with id 104" do
      trip_collection_r1.each do |obj|
        obj.rider_id.must_equal 1
      end
    end

    it "Must return an empty array if driver id is not found or not valid" do
      RideSharing::Trip.find_all_trips_for_rider(301).must_be_kind_of Array
      RideSharing::Trip.find_all_trips_for_rider(301).must_be_empty
      RideSharing::Trip.find_all_trips_for_rider("1").must_be_kind_of Array
      RideSharing::Trip.find_all_trips_for_rider("1").must_be_empty
    end
  end # End of describe "#self.find_all_trips_for_rider"


  describe "#find_driver" do
    let(:trip1) { RideSharing::Trip.find(1)}
    let(:trip154) { RideSharing::Trip.find(154)} #This trip has driver_id: 0
    it "Return must be an object of class RideSharing::Driver when driver id is valid" do
      trip1.find_driver.must_be_kind_of RideSharing::Driver
    end

    it "Return must be an object of class NilClass when driver id is NOT valid" do
      trip154.find_driver.must_be_kind_of NilClass
      trip154.find_driver.must_be_nil
    end
  end # End of describe "#find_driver"


  describe "#find_rider" do
    let(:trip1) { RideSharing::Trip.find(1)}
    let(:trip267) { RideSharing::Trip.find(267)} # This trip has rider_id: 0
    it "Return must be an object of class RideSharing::Rider" do
      trip1.find_rider.must_be_kind_of RideSharing::Rider
    end
    it "Return must be an object of class NilClass when driver id is NOT valid" do
      trip267.find_rider.must_be_kind_of NilClass
      trip267.find_rider.must_be_nil
    end
  end # End of describe "#find_driver"


  ################################################################################
    # describe "EXPLORING DATA" do
    #   it "Find trips with unvalid riders" do
    #     RideSharing::Trip.all.each do |trip|
    #       if trip.find_rider == nil
    #         puts trip.id
    #       end
    #     end
    #   end

    # it "Find trips with unvalid score" do
    #   RideSharing::Trip.all.each do |trip|
    #     if !(1..5).include? trip.rating
    #       puts trip.id
    #     end
    #   end
    # end
    #


    # end # End of describe "EXPLORING CODE:
  ################################################################################

end # End of describe "class Trip"
