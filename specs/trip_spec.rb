require_relative 'spec_helper'

describe "RideShare::Trip" do
  let(:all_trips) { RideShare::Trip.all }
  let(:all_riders) { RideShare::Rider.all }
  let(:all_drivers) { RideShare::Driver.all }

  describe "Trip#initialize" do
    let(:trip13) { RideShare::Trip.new({ id: "13", driver_id: "83",rider_id: "298", date: "2015-05-27", rating: "5" }) }
    let(:trip_no_date) { RideShare::Trip.new({ id: 13, driver_id: 83,rider_id: 298, rating: 5 }) }

    it "creates a new instance of trip" do
      trip13.must_be_instance_of RideShare::Trip
    end

    it "passes in values correctly" do
      trip13.id.must_equal "13"
      trip13.driver_id.must_equal "83"
      trip13.rider_id.must_equal "298"
      trip13.date.must_equal "2015-05-27"
      trip13.rating.must_equal "5"
    end

    it "can create a new trip with a missing date" do
      trip_no_date.date.must_equal nil
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

    it "correctly reads in the first row of the CSV file" do
      # last row of data: 1,1,54,2016-04-05,3
      all_trips[0].id.must_equal "1"
      all_trips[0].driver_id.must_equal "1"
      all_trips[0].rider_id.must_equal "54"
      all_trips[0].date.must_equal "2016-04-05"
      all_trips[0].rating.must_equal "3"
    end

    it "correctly reads in the last row of the CSV file" do
      # last row of data: (600,61,168,2016-04-25,3)
      all_trips[-1].id.must_equal "600"
      all_trips[-1].driver_id.must_equal "61"
      all_trips[-1].rider_id.must_equal "168"
      all_trips[-1].date.must_equal "2016-04-25"
      all_trips[-1].rating.must_equal "3"
    end
  end

  describe "Trip#by_rider(rider_id)" do
    before { all_trips }
    let(:by_rider54) { RideShare::Trip.by_rider("54")}

    it "returns an array" do
      by_rider54.must_be_kind_of Array
    end

    it "each returned element is a trip instances" do
      by_rider54.each { |element| element.must_be_instance_of RideShare::Trip }
    end

    # it "each returned trip has the expected associated Rider" do
    # skip
    #   RideShare::Trip.all
    #   rider_id = 54
    #   rider_trips = RideShare::Trip.by_rider(rider_id)
    #   rider_trips.each { |element| element.rider_id.must_equal rider_id }
    # end
  end

  describe "Trip#by_driver(driver_id)" do
    before { all_trips }
    let(:by_driver61) { RideShare::Trip.by_driver("61") }

    it "returns an array" do
      by_driver61.must_be_kind_of Array
    end

    it "each returned element is a trip instances" do
      by_driver61.each { |element| element.must_be_instance_of RideShare::Trip }
    end

    # it "each returned trip has the expected associated Driver" do
    # skip
    #   RideShare::Trip.all
    #   driver_id = 61
    #   driver_trips = RideShare::Trip.by_driver(driver_id)
    #   driver_id_trips.each { |element| element.driver_id.must_equal driver_id }
    # end
  end

  describe "Trip#find_driver" do
    before { all_drivers }
    let(:find_driver83) { RideShare::Trip.new({driver_id: "83"}).find_driver }

    it "returns the instance of Driver" do
      find_driver83.must_be_instance_of RideShare::Driver
    end

    it "returns correct instance of driver by driver_id" do
      find_driver83.must_equal RideShare::Driver.find("83")
    end
  end

  describe "Trip#find_rider" do
    before { all_riders }
    let(:find_rider298) { RideShare::Trip.new({rider_id: "298"}).find_rider }

    it "returns the instance of Rider" do
      find_rider298.must_be_instance_of RideShare::Rider
    end

    it "returns correct instance of Rider by Rider_id" do
      find_rider298.must_equal RideShare::Rider.find("298")
    end
  end
end
