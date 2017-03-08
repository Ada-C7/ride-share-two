require_relative 'spec_helper'

describe "RideShare::Trip" do

  describe "RideShare::Trip #iniitalize" do

    let (:trip_init) { RideShare::Trip.new(1234, 2345, 3456, "2016-03-06", 5) }

    it "A new trip can be initiailzed with a trip id, driver id, rider id, date, and rating" do
      trip_init.must_be_instance_of RideShare::Trip
      trip_init.trip_id.must_equal 1234
      trip_init.driver_id.must_equal 2345
      trip_init.rider_id.must_equal 3456
      trip_init.date.must_equal "2016-03-06"
      trip_init.rating.must_equal 5
    end

    it "Checks for valid inputs" do
      
    end

    it "Will raise an ArgumentError if an invalid rating given" do
      proc { RideShare::Trip.new(1234, 2345, 3456, "2016-03-06", 10)}.must_raise ArgumentError
    end

  end


  describe "RideShare::Trip #trip_driver" do

    let (:trip_driver) { RideShare::Trip.new(1234, 30, 1, "2016-02-06", 5).trip_driver }

    it "Returns an instance of RideShare::Driver" do
      trip_driver.must_be_instance_of RideShare::Driver
    end

    it "Returns the driver that matches the given driver_id" do
      trip_driver.id.must_equal 30
      trip_driver.name.must_equal "Casper Flatley"
      trip_driver.vin.must_equal "L1CN7SPD96M6SNFYU"
    end

  end


  describe "RideShare::Trip #trip_rider" do

    let (:trip_rider) { RideShare::Trip.new(8366, 23, 74, "2015-04-23", 2).trip_rider }

    it "Returns an instance of RideShare::Rider" do
      trip_rider.must_be_instance_of RideShare::Rider
    end

    it "Returns the rider that matches the given rider id" do
      trip_rider.id.must_equal 74
      trip_rider.name.must_equal "Felicity Cole"
      trip_rider.phone.must_equal "889-451-6215"
    end

  end


  describe "RideShare::Trip #self.all" do

    let (:all_riders) { RideShare::Trip.all }

    it "Returns an array" do
      all_riders.must_be_kind_of Array
    end

    it "All items in array are instances of RideShare::Trip" do
      all_riders.each do | trip |
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "Initializes first line from trips.csv as a new RideShare::Trip instance" do
      all_riders.first.must_be_instance_of RideShare::Trip
      all_riders.first.trip_id.must_equal 1
      all_riders.first.driver_id.must_equal 1
      all_riders.first.rider_id.must_equal 54
      all_riders.first.date.must_equal "2016-04-05"
      all_riders.first.rating.must_equal 3
    end

    it "Ititializes last line from trips.csv as a new RideShare::Trip instance" do
      all_riders.last.must_be_instance_of RideShare::Trip
      all_riders.last.trip_id.must_equal 600
      all_riders.last.driver_id.must_equal 61
      all_riders.last.rider_id.must_equal 168
      all_riders.last.date.must_equal "2016-04-25"
      all_riders.last.rating.must_equal 3
    end

    it "Ititializes random line from trips.csv as a new RideShare::Trip instance" do
      all_riders[249].must_be_instance_of RideShare::Trip
      all_riders[249].trip_id.must_equal 250
      all_riders[249].driver_id.must_equal 69
      all_riders[249].rider_id.must_equal 203
      all_riders[249].date.must_equal "2016-04-14"
      all_riders[249].rating.must_equal 1
    end

  end


  describe "RideShare::Trip #self.drivers_trips" do

    let (:drivers_trips) { RideShare::Trip.drivers_trips(9) }

    it "Returns an Array" do
      drivers_trips.must_be_kind_of Array
    end

    it "Each object within the returned array must be an instance of RideShare::Trip" do
      drivers_trips.each do | trip |
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "Each object within the returned array must have a Driver ID that matches the argument" do
      drivers_trips.each do | trip |
        trip.driver_id.must_equal 9
      end
    end

    it "Will raise an ArgumentError if ID not found" do
      proc { RideShare::Trip.drivers_trips(40000) }.must_raise ArgumentError
    end

  end


  describe "RideShare::Trip #riders_trips" do

    let (:riders_trips) { RideShare::Trip.riders_trips(57) }

    it "Returns an Array" do
      riders_trips.must_be_kind_of Array
    end

    it "Each object within the returned array must be an instance of RideShare::Trip" do
      riders_trips.each do | trip |
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "Each object within the returned array must have a Rider ID that matches the argument" do
      riders_trips.each do | trip |
        trip.rider_id.must_equal 57
      end
    end

    it "Will raise an ArgumentError if ID not found" do
      proc { RideShare::Trip.riders_trips(40000) }.must_raise ArgumentError
    end

    it "Returns the correct number of trips" do
      riders_trips.length.must_equal 4
    end

  end

end
