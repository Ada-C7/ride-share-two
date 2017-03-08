require_relative 'spec_helper'

describe "RideShare::Trip" do

  describe "RideShare::Trip#iniitalize" do

    it "A new trip can be initiailzed with a trip id, driver id, rider id, date, and rating" do
      new_trip = RideShare::Trip.new(1234, 2345, 3456, "2016-03-06", 5)
      new_trip.must_be_instance_of RideShare::Trip
    end

    # it "Checks if rating is valid (between 1 and 5). If invalid, defaault rating is set to 3" do
    #   new_trip = RideShare::Trip.new(1234, 2345, 3456, "2016-03-06", 10)
    #   new_trip.rating.must_equal 3
    # end

  end


  describe "RideShare::Trip#trip_driver" do

    let (:random_trip) { RideShare::Trip.new(1234, 30, 30, "2016-02-06", 10) }

    it "Returns an instance of RideShare::Driver" do
      random_trip.trip_driver.must_be_instance_of RideShare::Driver
    end
  end


  describe "RideShare::Trip#trip_rider" do
  end


  describe "RideShare::Trip#self.all" do

    let (:first_trip) { RideShare::Trip.all[0] }
    let (:last_trip) { RideShare::Trip.all[-1] }
    let (:random_trip) { RideShare::Trip.all[249] }

    it "Returns an array" do
      RideShare::Trip.all.must_be_kind_of Array
    end

    it "All items in array are instances of RideShare::Trip" do
      RideShare::Trip.all.each do | trip |
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "Initializes first line from trips.csv as a new RideShare::Trip instance" do
      first_trip.must_be_instance_of RideShare::Trip
      first_trip.trip_id.must_equal 1
      first_trip.driver_id.must_equal 1
      first_trip.rider_id.must_equal 54
      first_trip.date.must_equal "2016-04-05"
      first_trip.rating.must_equal 3
    end

    it "Ititializes last line from trips.csv as a new RideShare::Trip instance" do
      last_trip.must_be_instance_of RideShare::Trip
      last_trip.trip_id.must_equal 600
      last_trip.driver_id.must_equal 61
      last_trip.rider_id.must_equal 168
      last_trip.date.must_equal "2016-04-25"
      last_trip.rating.must_equal 3
    end

    it "Ititializes random line from trips.csv as a new RideShare::Trip instance" do
      random_trip.must_be_instance_of RideShare::Trip
      random_trip.trip_id.must_equal 250
      random_trip.driver_id.must_equal 69
      random_trip.rider_id.must_equal 203
      random_trip.date.must_equal "2016-04-14"
      random_trip.rating.must_equal 1
    end

  end


  describe "RideShare::Trip#self.drivers_trips" do

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


  describe "RideShare::Trip#riders_trips" do

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
