require_relative 'spec_helper'

describe "RideShare::Rider" do

  let (:new_rider) { RideShare::Rider.new(2345, "Some Dude", "800-000-000") }
  let (:valid_rider) { RideShare::Rider.find(30) }

  describe "RideShare::Rider #iniitalize" do

    let (:rider_init) { RideShare::Rider.new(2345, "Some Dude", "800-000-000") }

    it "A new rider can be initialized with an id, name, and phone number" do
      rider_init.must_be_instance_of RideShare::Rider
    end

    it "Raises ArgumentError if arguments are invalid" do
      proc { RideShare::Rider.new("2345", "Some Dude", "800-000-000") }.must_raise ArgumentError
      proc { RideShare::Rider.new(2345, 2345, "800-000-000") }.must_raise ArgumentError
      proc { RideShare::Rider.new(2345, "Some Dude", 800000000) }.must_raise ArgumentError
    end

  end


  describe "RideShare::Rider #trips" do

    let (:rider_trips) { RideShare::Rider.find(30).trips }

    it "Returns an array" do
      rider_trips.must_be_instance_of Array
    end

    it "All objects in the array are RideShare::Trip instances" do
      rider_trips.each do | trip |
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "The driver_id of each trip matches the given argument" do
      rider_trips.each do | trip |
        trip.rider_id.must_equal 30
      end
    end

    it "Returns the correct number of trips" do
      rider_trips.length.must_equal 2
    end

    it "Raises an argument error if driver has no trips" do
      proc{ RideShare::Rider.find(300).trips }.must_raise ArgumentError
    end

  end


  describe "RideShare::Rider #drivers" do

    let (:new_rider) { RideShare::Rider.new(30, "Kelsey", "800-000-000") }

    it "Returns an array" do
      new_rider.drivers.must_be_instance_of Array
    end

    it "All objects in the array are Drivers" do
      new_rider.drivers.each do | driver |
        driver.must_be_instance_of RideShare::Driver
      end
    end

  end


  describe "RideShare::Rider#self.all" do

    let (:all_riders) { RideShare::Rider.all }

    it "Initializes first line from riders.csv as a new RideShare::Rider instance" do
      all_riders.first.must_be_instance_of RideShare::Rider
    end

    it "Correctly reads the first line from the riders.csv file" do
      all_riders.first.id.must_equal 1
      all_riders.first.name.must_equal "Nina Hintz Sr."
      all_riders.first.phone.must_equal "560.815.3059"
    end

    it "Ititializes last line from riders.csv as a new RideShare::Rider instance" do
      all_riders.last.must_be_instance_of RideShare::Rider
    end

    it "Correctly reads the last line from the riders.csv file" do
      all_riders.last.id.must_equal 300
      all_riders.last.name.must_equal "Miss Isom Gleason"
      all_riders.last.phone.must_equal "791-114-8423 x70188"
    end

    it "Ititializes random line from riders.csv as a new RideShare::Rider instance" do
      all_riders[115].must_be_instance_of RideShare::Rider
    end

    it "Correctly reads random line from the riders.csv file" do
      all_riders[115].id.must_equal 116
      all_riders[115].name.must_equal "Laurianne Larkin"
      all_riders[115].phone.must_equal "567.228.1637 x86366"
    end

  end


  describe "RideShare::Rider#self.find" do

    let (:found_rider) { RideShare::Rider.find(100) }

    it "Returns a RideShare::Rider" do
      found_rider.must_be_instance_of RideShare::Rider
    end

    it "Is able to find random rider using the rider ID" do
      found_rider.id.must_equal 100
      found_rider.name.must_equal "Hipolito Rogahn"
      found_rider.phone.must_equal "944.179.4883"
    end

    it "Will raise an ArgumentError if Rider ID is not found" do
      proc { RideShare::Rider.find(400) }.must_raise ArgumentError
    end

  end

end
