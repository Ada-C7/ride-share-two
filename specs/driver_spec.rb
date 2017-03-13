require_relative 'spec_helper'

describe "Driver class" do
  describe "Initialize method" do
    it "initializes a Driver with ID, name, and vehicle identification number" do
      driver_id = "54321"
      name = "Joe"
      vin = "9876"
      driver = RideShare::Driver.new(driver_id, name, vin)

      driver.must_respond_to :driver_id
      driver.driver_id.must_equal driver_id

      driver.must_respond_to :name
      driver.name.must_equal name

      driver.must_respond_to :vin
      driver.vin.must_equal vin
    end
  end

  describe "trips method" do
    it "Retrieves the list of trip instances unique to one instance of driver" do
      # skip
      bernardo_trips = RideShare::Driver.find("1").trips
      bernardo_trips.must_be_instance_of Array
      bernardo_trips.length.must_equal 9
    end

    it "Retrieves an average rating for a driver based on all trips taken" do
      # skip
      rate_bernardo = RideShare::Driver.find("1")
      rate_bernardo.rating.must_equal 2.3
    end
  end

  describe "self.all - Driver class method" do
    it "Retrieve list of all drivers from the CSV file" do
      # skip
      RideShare::Driver.all.must_be_instance_of Array, "This is not an array"
    end

    it "For first and last drivers, Driver ID and Driver VIN must match what's in CSV file" do
      # skip
      drivers_array = RideShare::Driver.all

      drivers_array[1].driver_id.must_equal("1")
      drivers_array[1].vin.must_equal("WBWSS52P9NEYLVDE9")
      drivers_array[100].driver_id.must_equal("100")
      drivers_array[100].vin.must_equal("XF9Z0ST7X18WD41HT")
    end

    it "Array retrieved by self.all retrieves same number of drivers as is in CSV" do
      # skip
      drivers_array = RideShare::Driver.all

      drivers_array.length.must_equal 101
    end
  end

  describe "self.find class method for Driver class" do
    it "Finds a specific driver using their numeric ID" do
      # skip
        RideShare::Driver.find("1").name.must_equal "Bernardo Prosacco"
    end

    it "Finds the first driver in the database" do
      # skip
      if RideShare::Driver.all[1].driver_id == "1"
        RideShare::Driver.find("1").vin.must_equal "WBWSS52P9NEYLVDE9"
      end
    end

    it "Finds the last driver in the database" do
      # skip
      if RideShare::Driver.all[-1].driver_id == "100"
        RideShare::Driver.find("100").name.must_equal "Minnie Dach"
      end
    end

    it "Raises ArgumentError if no driver is found that matches argument given" do
      proc {
        RideShare::Driver.find("700")
      }.must_raise ArgumentError
    end
  end
end
