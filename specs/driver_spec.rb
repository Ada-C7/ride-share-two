require_relative 'spec_helper'

describe "Driver" do
  describe "constructor" do
    before do
      @name = 'Ada'
      @id = 108
      @vin = '123456789abcdefeg'
    end

    it "can be instantiated" do
      driver = RideShare::Driver.new(name: @name, id: @id, vin: @vin)
      driver.must_be_instance_of RideShare::Driver
    end

    it "takes a name, VIN, and ID" do
      driver = RideShare::Driver.new(name: @name, id: @id, vin: @vin)

      driver.must_respond_to :name
      driver.name.must_equal @name

      driver.must_respond_to :id
      driver.id.must_equal @id

      driver.must_respond_to :vin
      driver.vin.must_equal @vin
    end

    it "raises an error if the VIN is not 17 characters long" do
      invalid_vin = '123456dfsd'

      proc {
        RideShare::Driver.new(name: @name, id: @id, vin: invalid_vin)
      }.must_raise RideShare::InvalidVinError
    end

    it "raises an error if the VIN has a character other than a letter or number" do
      invalid_vin = '12345!!#2345ddegd'

      proc {
        RideShare::Driver.new(name: @name, id: @id, vin: invalid_vin)
      }.must_raise RideShare::InvalidVinError
    end
  end

  describe "trips" do
    it "returns an array" do
      skip
    end

    it "returns an array with only Trip objects" do
      skip
    end

    it "returns Trips that only THIS driver has taken" do
      skip
    end
  end

  describe "avg_rating" do
    it "returns a float to 1 decimal point" do
      skip
    end

    it "returns the overall avg_rating for a driver" do
      #test decimal point
      skip
    end
  end

  describe "Driver.all" do
    # need to isolate opening CSV in own method/class variable?
    # rescue CSV?

    it "returns an array" do
      RideShare::Driver.all.must_be_instance_of Array
    end

    it "returns an array with only Driver elements" do
      RideShare::Driver.all.each do |driver|
        driver.must_be_instance_of RideShare::Driver
      end
    end

    it "returns all drivers in the CSV file" do
      # [d1,d2,d3,d4].length = x
      # &/or [d1, d2, d3] = expected_array
    end
  end

  describe "Driver.find" do
    # return nil or raise error if search isnt found?

    # def find_and_verify private method

    it "returns an account that exists" do
      skip
    end

    it "can find the first Driver from the CSV file" do
      skip
    end

    it "can find the last Driver from the CSV file" do
      skip
    end

    it "returns nil if driver_id is not found" do
      # or raises an error
      skip
    end
  end
end
