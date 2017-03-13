require_relative 'spec_helper'

describe "RideShare::Trip" do
  let(:all_trips) { RideShare::Trip.all }
  let(:all_riders) { RideShare::Rider.all }
  let(:all_drivers) { RideShare::Driver.all }
  let(:example_trip) { RideShare::Trip.new({ id: "13", driver_id: "83",rider_id: "298", date: "2015-05-27", rating: "5" }) }
  # initialize .all for each class--as default dataset
  before do
    all_trips
    all_riders
    all_drivers
  end

  describe "Trip#initialize" do
    it "creates a new instance of trip" do
      example_trip.must_be_instance_of RideShare::Trip
    end

    it "responds to being called" do
      example_trip.must_respond_to :id
      example_trip.must_respond_to :driver_id
      example_trip.must_respond_to :rider_id
      example_trip.must_respond_to :date
      example_trip.must_respond_to :rating
    end

    it "passes in values correctly" do
      example_trip.id.must_equal 13
      example_trip.driver_id.must_equal 83
      example_trip.rider_id.must_equal 298
      example_trip.date.must_equal "2015-05-27"
      example_trip.rating.must_equal 5
    end

    # EDGE CASE
    it "can create a new trip with missing date" do
      no_date_trip =  RideShare::Trip.new({ id: "13", driver_id: "83",rider_id: "298", rating: "5" })
      no_date_trip.date.must_be_nil
    end
  end

  describe "Trip#all" do
    it "returns an array" do
      all_trips.must_be_kind_of Array
    end

    it "each returned element is a trip instances" do
      all_trips.each do |object|
        object.must_be_instance_of RideShare::Trip
      end
    end

    it "returns the correct number of elements" do
      all_trips.length.must_equal 600 # rows in CSV file
    end

    # EDGE CASE
    it "correctly reads in the first row of the CSV file" do
      # last row of data: 1,1,54,2016-04-05,3
      all_trips[0].id.must_equal 1
      all_trips[0].driver_id.must_equal 1
      all_trips[0].rider_id.must_equal 54
      all_trips[0].date.must_equal "2016-04-05"
      all_trips[0].rating.must_equal 3
    end

    # EDGE CASE
    it "correctly reads in the last row of the CSV file" do
      # last row of data: (600,61,168,2016-04-25,3)
      all_trips[-1].id.must_equal 600
      all_trips[-1].driver_id.must_equal 61
      all_trips[-1].rider_id.must_equal 168
      all_trips[-1].date.must_equal "2016-04-25"
      all_trips[-1].rating.must_equal 3
    end
  end

  describe "Trip#by_rider(rider_id)" do
    let(:example_by_rider) { RideShare::Trip.by_rider("54")}

    it "returns an array" do
      example_by_rider.must_be_kind_of Array
    end

    it "each returned element is a Trip instance" do
      example_by_rider.each { |element| element.must_be_instance_of RideShare::Trip }
    end

    it "prints message if rider_id doesn't exist" do
      proc {
        RideShare::Trip.by_rider("999")
      }.must_output("")
    end

  end

  describe "Trip#by_driver(driver_id)" do
    let(:example_by_driver) { RideShare::Trip.by_driver("61") }

    it "returns an array" do
      example_by_driver.must_be_kind_of Array
    end

    it "each returned element is a Trip instance" do
      example_by_driver.each { |element| element.must_be_instance_of RideShare::Trip }
    end

    # EDGE CASE
    it "returns empty array if no trips are found" do
      by_driver_no_trips= RideShare::Trip.by_driver("100") # has no trips recorded
      by_driver_no_trips.must_equal []
    end
  end

  describe "Trip#find_driver" do
    let(:example_find_driver) { example_trip.find_driver }

    it "returns the instance of Driver" do
      example_find_driver.must_be_instance_of RideShare::Driver
    end

    it "has the same driver info as Driver.find" do
      example_find_driver.id.must_equal RideShare::Driver.find(83).id
      example_find_driver.name.must_equal RideShare::Driver.find(83).name
      example_find_driver.vin.must_equal RideShare::Driver.find(83).vin
    end
  end

  describe "Trip#find_rider" do
    let(:example_find_rider) { example_trip.find_rider }

    it "returns the instance of Rider" do
      example_find_rider.must_be_instance_of RideShare::Rider
    end

    it "has the same rider info as Rider.find" do
      example_find_rider.id.must_equal RideShare::Rider.find(298).id
      example_find_rider.name.must_equal RideShare::Rider.find(298).name
      example_find_rider.phone_number.must_equal RideShare::Rider.find(298).phone_number
    end
  end
end
