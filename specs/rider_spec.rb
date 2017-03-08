require_relative 'spec_helper'

describe "Rider" do

  before do
    @args = { rider_id: 1, name: "Nina Hintz Sr.", phone_num: "560.815.3059" }
    @rider = RideShare::Rider.new(@args)
  end

  describe "Rider#initialize" do

    it "Can be initialized" do
      @rider.must_be_instance_of RideShare::Rider
    end

    it "Takes a rider id" do
      @rider.must_respond_to :rider_id
      @rider.rider_id.must_equal @args[:rider_id]
    end

    it "Raises an ArgumentError if rider id is not an integer" do
      proc {
        RideShare::Rider.new(rider_id: "8", name: "Sahana", phone_num: "555-555-5555")
      }.must_raise ArgumentError
    end

    it "Takes a rider name" do
      @rider.must_respond_to :name
      @rider.name.must_equal @args[:name]
    end

    it "Takes a phone number" do
      @rider.must_respond_to :phone_num
      @rider.phone_num.must_equal @args[:phone_num]
    end

  end

  describe "Rider.all" do

    before do
      @all_riders = RideShare::Rider.all
    end

    it "Can be called as a class method for the Rider class" do
      RideShare::Rider.must_respond_to :all
    end

    it "Returns an array of all riders" do
      @all_riders.must_be_kind_of Array

      @all_riders.each do |rider|
        rider.must_be_instance_of RideShare::Rider
      end
    end

    it "Contains the correct amount of riders" do
      @all_riders.length.must_equal 300
    end

    it "Matches the rider information of the first and last rider" do
      @all_riders.first.rider_id.must_equal 1
      @all_riders.first.name.must_equal "Nina Hintz Sr."
      @all_riders.first.phone_num.must_equal "560.815.3059"

      @all_riders.last.rider_id.must_equal 300
      @all_riders.last.name.must_equal "Miss Isom Gleason"
      @all_riders.last.phone_num.must_equal "791-114-8423 x70188"
    end

  end

  describe "Rider.find" do

    it "Can be called as a class method for the Rider class" do
      RideShare::Rider.must_respond_to :find
    end

    it "Returns a rider who exists" do
      rider_id = 5
      rider = RideShare::Rider.find(rider_id)
      rider.must_be_instance_of RideShare::Rider
      rider.rider_id.must_equal rider_id
    end

    it "Can find the first rider from the CSV" do
      rider_id = 1
      rider = RideShare::Rider.find(rider_id)
      rider.must_be_instance_of RideShare::Rider
      rider.rider_id.must_equal rider_id
    end

    it "Can find the last rider from the CSV" do
      rider_id = 300
      rider = RideShare::Rider.find(rider_id)
      rider.must_be_instance_of RideShare::Rider
      rider.rider_id.must_equal rider_id
    end

    it "Raises an error for a rider who doesn't exist" do
      proc {
        RideShare::Rider.find(1736)
      }.must_raise RideShare::InvalidRider
    end

  end

  describe "Rider#trips" do

    it "Can be called on an instance of the Rider class" do
      @rider.must_respond_to :trips
    end

    it "Returns an array" do
      @rider.trips.must_be_kind_of Array
    end

    it "Returns instances of the Trip class" do
      @rider.trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "Returns the appropriate trips" do
      @rider.trips.each do |trip|
        trip.rider_id.must_equal @args[:rider_id]
      end
    end

    it "Returns all the appropriate trips" do
      @rider.trips.length.must_equal 2
    end

  end

  describe "Rider#drivers" do

    it "Can be called on an instance of the Rider class" do
      @rider.must_respond_to :drivers
    end

    it "Returns an array" do
      @rider.drivers.must_be_kind_of Array
    end

    it "Returns instances of the Driver class" do
      @rider.drivers.each do |driver|
        driver.must_be_instance_of RideShare::Driver
      end
    end

    it "Returns the appropriate drivers" do
      driver_ids = [98, 17]
      @rider.drivers.each do |driver|
        driver_ids.must_include driver.driver_id
      end
    end

    it "Returns all the appropriate drivers" do
      @rider.drivers.length.must_equal 2
    end

  end

end
