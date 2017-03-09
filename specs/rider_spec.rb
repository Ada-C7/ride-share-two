require_relative 'spec_helper'

describe "Rider" do
   let(:riders) {RideShare::Rider.all}

  describe "initialize" do

    # 3 tests to check Argument Errors

  end

  describe "all" do
    it "returns an Array" do
      riders.must_be_instance_of Array
    end

    it "everything in the Array is a Rider instance" do
      riders.each do |rider|
        rider.must_be_instance_of RideShare::Rider
      end
    end

    it "gets everything in the csv" do
       riders.length.must_equal 300
    end

    it "gets the first item" do
        riders[0].name.must_equal "Nina Hintz Sr."
    end

    it "gets the last item"  do
        riders.last.phone.must_equal "791-114-8423 x70188"

    end

    describe "Error Checking" do
      #name is a string
      #rider_id is an integer
      #phone_number is ??
    end

  end

  describe "find" do

    it "returns an instance of Rider" do
      rider = RideShare::Rider.find 22
      rider.must_be_instance_of RideShare::Rider
      rider.id.must_equal 22

    end

    it "returns nil if Rider is not found" do
      rider = RideShare::Rider.find 450
      rider.must_be_instance_of NilClass
    end

  end


  describe "trips" do

    it "returns an Array of trips" do
      rider = riders[53]
      rider.trips.must_be_instance_of Array
      rider.trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
        trip.rider_id.must_equal rider.id
      end
    end

  end

  describe "drivers" do

    it "returns an Array of Drivers" do
      rider = riders[53]
      rider.id.must_equal 54
      rider.must_be_instance_of RideShare::Rider

      all_drivers = rider.drivers
      all_drivers.must_be_instance_of Array
      all_drivers.each do |driver|
        driver.must_be_instance_of RideShare::Driver
      end
      all_drivers.length.must_equal 2
    end

    it "each Driver is only included once in Array" do
      rider41 = riders[40]
      rider41.drivers.length.must_equal 2

      rider250 = riders[249]
      rider250.drivers.length.must_equal 3
    end

  end
end
