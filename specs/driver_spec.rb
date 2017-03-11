require_relative 'spec_helper'

describe "Driver" do

  describe "initialize" do

    it "Raises an ArgumentError when VIN is not 17 characters" do
      proc {
        RideShare::Driver.new(driver_id: 150, name: "Kaitlin Ramirez", vin: "W09XNTZR9KT")
      }.must_raise ArgumentError
    end

  end

  describe "Driver.create_all_drivers" do

    before do
      @drivers = RideShare::Driver.create_all_drivers
    end

    it "Returns an array of all accounts" do
      @drivers.must_be_instance_of Array
    end

    it "The number of drivers is correct" do
      @drivers.length.must_equal 100
    end

    it "The driver_id and vin of the first and last" do
      skip

    end

  end

  describe "Driver.find(driver_id)" do

    it "should return the id that was passed through" do
      RideShare::Driver.find(1)[:driver_id].must_equal(1)
    end
    


  end

  describe "Driver trips(driver_id)" do
    # driver with id 100 does not have any trip. look out for your tests.
    it "finds all the trips for a Driver" do
      skip
    end

    it "finds all the trips for the first Driver" do
      skip
    end

    it "finds all the trips for the last Driver" do
      skip
    end
  end

end
