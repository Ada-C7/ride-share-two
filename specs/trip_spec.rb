require_relative 'spec_helper.rb'

describe "RideShare::Trip" do

  before do
    @trip = RideShare::Trip.new({id: 13, driver_id: 83,rider_id: 298, date: "2015-05-27", rating: 5})
  end

  describe "Trip#initialize" do
    it "creates a new instance of trip" do
      @trip.must_be_instance_of RideShare::Trip
    end
    it "passes in the id" do
      @trip.id.must_equal 13
    end
    it "passes in the driver_id" do
      @trip.driver_id.must_equal 83
    end
    it "passes in the rider_id" do
      @trip.rider_id.must_equal 298
    end
    it "passes in the date" do
      @trip.date.must_equal "2015-05-27"
    end
    it "passes in the rating" do
      @trip.rating.must_equal 5
    end
    it "can create a new trip with a missing date" do
      no_date_trip = RideShare::Trip.new({id: 13, driver_id: 83,rider_id: 298, rating: 5})
      no_date_trip.date.must_equal nil
    end
  end

  describe "Trip#all" do

  before do
    @all_trips = RideShare::Trip.all
  end

    it "returns an array" do
      @all_trips.must_be_kind_of Array
    end
    it "each returned element is a trip instances" do
      @all_trips.each do |object|
        object.must_be_instance_of RideShare::Trip
      end
    end
    it "returns the correct number of elements" do
      @all_trips.length.must_equal 600 # rows in CSV file
    end
    it "correctly reads in the first row of the CSV file" do
      # last row of data: 1,1,54,2016-04-05,3
      @all_trips[0].id.must_equal "1"
      @all_trips[0].driver_id.must_equal "1"
      @all_trips[0].rider_id.must_equal "54"
      @all_trips[0].date.must_equal "2016-04-05"
      @all_trips[0].rating.must_equal "3"
    end
    it "correctly reads in the last row of the CSV file" do
      # last row of data: (600,61,168,2016-04-25,3)
      @all_trips[-1].id.must_equal "600"
      @all_trips[-1].driver_id.must_equal "61"
      @all_trips[-1].rider_id.must_equal "168"
      @all_trips[-1].date.must_equal "2016-04-25"
      @all_trips[-1].rating.must_equal "3"
    end
  end

  describe "Trip#trips_rode(rider_id)" do
    it "returns an array" do
    skip
      rider_id = 54
      @trip.trips_rode(rider_id).must_be_kind_of Array
    end
    it "each returned element is a trip instances" do
    skip
    end
  end

  describe "Trip#trips_driver(driver_id)" do
    it "returns an array" do
    skip
      driver_id = 61
      @trip.trips_driver(driver_id).must_be_kind_of Array
    end
    it "each returned element is a trip instances" do
    skip
    end
  end

  describe "Trip#find_driver" do
    it "returns an instance of driver" do
    skip
    end
    it "returns correct instance of driver" do
    skip
    end
  end

  describe "Trip#find_rider" do
    it "returns an instance of rider" do
    skip
    end
    it "returns correct instance of rider" do
    skip
    end
  end
end
