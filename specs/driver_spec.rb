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

      @drivers.first.driver_id.must_equal 1
      @drivers.first.vin.must_equal "WBWSS52P9NEYLVDE9"

      @drivers.last.driver_id.must_equal 100
      @drivers.last.vin.must_equal "XF9Z0ST7X18WD41HT"

    end

  end

  describe "Driver.find(driver_id)" do

    it "returns a Driver that exists" do
      driver = RideShare::Driver.find(5)

      driver.must_be_instance_of RideShare::Driver
      driver.driver_id.must_equal 5
      driver.name.must_equal "Verla Marquardt"
      driver.vin.must_equal "TAMLE35L3MAYRV1JD"
    end

    it "returns the first driver" do
      driver = RideShare::Driver.find(1)

      driver.must_be_instance_of RideShare::Driver
      driver.driver_id.must_equal 1
      driver.name.must_equal "Bernardo Prosacco"
      driver.vin.must_equal "WBWSS52P9NEYLVDE9"
    end

    it "returns the last driver" do
      driver = RideShare::Driver.find(100)

      driver.must_be_instance_of RideShare::Driver
      driver.driver_id.must_equal 100
      driver.name.must_equal "Minnie Dach"
      driver.vin.must_equal "XF9Z0ST7X18WD41HT"
    end

  end

  describe "Driver trips" do
    # driver with id 100 does not have any trip. look out for your tests.
    it "text" do
      skip
    end
  end

end
