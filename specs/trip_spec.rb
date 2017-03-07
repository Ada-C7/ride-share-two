require_relative 'spec_helper'

describe "RideShare::Trip" do

  describe "RideShare::Trip#iniitalize" do

    it "A new trip can be initiailzed with a trip id, rider id, driver id, date, and rating" do
      new_trip = RideShare::Trip.new(1234, 2345, 3456, "2016-03-06", 5)
      new_trip.must_be_instance_of RideShare::Trip
    end

  end

  describe "RideShare::Trip#valid_rating?" do
  end

  describe "RideShare::Trip#trip_driver" do
  end

  describe "RideShare::Trip#trip_rider" do
  end

  describe "RideShare::Trip#self.all_trips" do
  end

  describe "RideShare::Trip#self.drivers_trips" do
  end

  describe "RideShare::Trip#riders_trips" do
  end

end
