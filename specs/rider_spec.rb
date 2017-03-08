require_relative 'spec_helper'

describe "RideShare::Rider" do

  let (:new_rider) { RideShare::Rider.new(2345, "Some Dude", "800-000-000") }
  let (:valid_rider) { RideShare::Rider.find(30) }

  describe "RideShare::Rider#iniitalize" do

    it "A new rider can be initialized with an id, name, and phone number" do
      new_rider.must_be_instance_of RideShare::Rider
    end

  end


  describe "RideShare::Rider#trips" do

    it "Returns an array" do
      valid_rider.trips.must_be_instance_of Array
    end

    it "All objects in the array are RideShare::Trip instances" do
      valid_rider.trips.each do | trip |
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "The driver_id of each trip matches the given argument" do
      valid_rider.trips.each do | trip |
        trip.rider_id.must_equal 30
      end
    end

    it "Returns the correct number of trips" do
      valid_rider.trips.length.must_equal 2
    end

  end


  xdescribe "RideShare::Rider#drivers" do

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

    let (:first_rider) { RideShare::Rider.all.first }
    let (:last_rider) { RideShare::Rider.all.last }
    let (:random_rider) { RideShare::Rider.all[115] }

    it "Initializes first line from riders.csv as a new RideShare::Rider instance" do
      first_rider.id.must_equal 1
      first_rider.name.must_equal "Nina Hintz Sr."
      first_rider.phone.must_equal "560.815.3059"
    end

    it "Ititializes last line from riders.csv as a new RideShare::Rider instance" do
      last_rider.id.must_equal 300
      last_rider.name.must_equal "Miss Isom Gleason"
      last_rider.phone.must_equal "791-114-8423 x70188"
    end

    it "Ititializes random line from riders.csv as a new RideShare::Rider instance" do
      random_rider.id.must_equal 116
      random_rider.name.must_equal "Laurianne Larkin"
      random_rider.phone.must_equal "567.228.1637 x86366"
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
