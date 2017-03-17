require_relative 'spec_helper'
require_relative '../lib/trip'


describe "Trip tests" do
  describe "Trip#initialize" do
    it "takes an id, driver_id, rider_id, date, and rating" do
        new_trip = Trip.new(1234, 1, 56, "2016-04-05", 5)

        new_trip.must_respond_to :id
        new_trip.id.must_equal 1234

        new_trip.must_respond_to :driver_id
        new_trip.driver_id.must_equal 1

        new_trip.must_respond_to :rider_id
        new_trip.rider_id.must_equal 56

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
    before do
      @all_trips = Trip.all
      @csv_file = CSV.read("./support/trips.csv", {:headers => true})
    end

    it "returns an array of all trips" do
      Trip.all.class.must_equal Array
    end

    it "each element in array is a Trip" do

      Trip.all.each do |element|
        element.must_be_instance_of Trip
      end
    end

    it "First element in array is first line in csv" do
      @all_trips[0].id.must_equal @csv_file[0][0].to_i

      @all_trips[0].driver_id.must_equal @csv_file[0][1].to_i

      @all_trips[0].rider_id.must_equal @csv_file[0][2].to_i

      @all_trips[0].date.must_equal @csv_file[0][3]


    end

    it "Last element in array is last line in csv" do
      @all_trips[-1].id.must_equal @csv_file[-1][0].to_i

      @all_trips[-1].driver_id.must_equal @csv_file[-1][1].to_i

      @all_trips[-1].rider_id.must_equal @csv_file[-1][2].to_i

      @all_trips[-1].date.must_equal @csv_file[-1][3]

    end


  end

  describe "Trip.driver(search_id)" do
    it "returns a Driver object given a driver id" do
      Trip.driver(34).must_be_instance_of Driver
    end

    it "returns the correct driver" do
      Trip.driver(34).name.must_equal "Velma O'Connell"
    end

    it "returns an error if invalid id is put in" do
      proc {Trip.driver("Asdf")}.must_raise ArgumentError
    end

    it "returns an error if driver does not exist" do
      proc {Trip.driver(000)}.must_raise ArgumentError
    end

  end

  describe "Trip.rider(search_id)" do
    it "returns a Rider object given a rider id" do
      Trip.rider(23).must_be_instance_of Rider
    end

    it "returns the correct driver" do
      Trip.rider(23).name.must_equal "Kevin Stark"
    end

    # DOUBLE CHECK THIS!!
    it "returns an error if invalid id is put in" do
      proc {Trip.driver("Asdf")}.must_raise ArgumentError
    end

    it "returns an error if rider does not exist" do
      proc {Trip.rider(000)}.must_raise ArgumentError
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

    it "raises an ArgumentError if argument passed is not an integer" do
      proc {Trip.rider_find_all("346")}.must_raise ArgumentError
    end

  end

  describe "Trip.driver_find_all(search_id)" do
    before do
      @csv_file = CSV.read("./support/trips.csv", {:headers => true})
    end
    it "raises an ArgumentError if argument passed is not an integer" do
      proc {Trip.driver_find_all("346")}.must_raise ArgumentError
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
