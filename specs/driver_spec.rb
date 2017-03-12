require_relative 'spec_helper'

# Try to use let! :) instead of before
describe "Driver class" do
  let(:drivers) { RideShare::Driver.all }
  let(:driving) { RideShare::Driver.new(driver_id: 7, name: "Lizeth Dickens", vin: "W09XNTZR9KTFK10WW") }

  describe "Driver#initialize" do

    it "Raises ArgumentError if driver_id is not class type integer" do
      proc { RideShare::Driver.new(driver_id: "7", name: "Ada", vin: "W09XNTZR9KTFK10WWW") }.must_raise ArgumentError
    end

    it "Raises ArgumentError if name is not class type string" do
      proc { RideShare::Driver.new(driver_id: 7, name: 1337, vin: 1337) }.must_raise ArgumentError
    end

    it "Raises ArgumentError if vin is not 17 characters long" do
      proc { RideShare::Driver.new(driver_id: 7, name: "Ada", vin: "W09XNTZR9KTFK10WWW") }.must_raise ArgumentError
    end

    it "It takes a driver_hash argument" do
      driving.must_be_instance_of RideShare::Driver
    end

    it "Has the correct values that were passed" do
      driving.driver_id.must_equal 7
      driving.name.must_equal "Lizeth Dickens"
      driving.vin.must_equal "W09XNTZR9KTFK10WW"
    end

  end

  describe "Driver.all" do

    it "Returns an array with all the drivers info" do
      drivers.class.must_equal Array
    end

    it "Everything in the array is a Driver" do
      first_driver = drivers[0]
      first_driver.class.must_equal RideShare::Driver
    end

    it "The id of the first and last driver" do
      first_driver = drivers[0].driver_id
      first_driver.must_equal 1
      last_driver = drivers.last.driver_id
      last_driver.must_equal 100
    end

    it "The name of the first and last driver" do
      first_driver = drivers[0].name
      first_driver.must_equal "Bernardo Prosacco"
      last_driver = drivers.last.name
      last_driver.must_equal "Minnie Dach"

    end

    it "The vin of the first and last driver" do
      first_driver = drivers[0].vin
      first_driver.must_equal "WBWSS52P9NEYLVDE9"
      last_driver = drivers.last.vin
      last_driver.must_equal "XF9Z0ST7X18WD41HT"
    end

    it "driver info matches what's in the CSV file" do
      #index = 1
      CSV.read("support/drivers.csv") do
        drivers[index].driver_id.must_equal line[0].to_i
        drivers[index].name.must_equal line[1]
        drivers[index].vin.must_equal line[2]

        #index += 1
      end
    end
  end

  describe "Driver.find" do
    let(:driver) { RideShare::Driver }

    it "Returns an account that exists" do
      driver_exists = driver.find(79)
      driver_exists.must_be_instance_of RideShare::Driver

      driver_exists.driver_id.must_equal 79
      driver_exists.name.must_equal "Vivian Fahey"
      driver_exists.vin.must_equal "WD3Y8KHA4B7CC63K4"
    end

    it "Can find the first account from the CSV" do
      driver_exists = driver.find(1)
      driver_exists.driver_id.must_equal 1
      driver_exists.name.must_equal "Bernardo Prosacco"
      driver_exists.vin.must_equal "WBWSS52P9NEYLVDE9"
    end

    it "Can find the last account from the CSV" do
      driver_exists = driver.find(100)
      driver_exists.driver_id.must_equal 100
      driver_exists.name.must_equal "Minnie Dach"
      driver_exists.vin.must_equal "XF9Z0ST7X18WD41HT"
    end

    it "Raises an error for an account that doesn't exist" do
      proc { driver.find(1337) }.must_raise ArgumentError
    end
  end

  describe "Driver#trips" do
    # Driver can talk to trips and this class will return a list of its trips based on the drivers id
    let(:casper) { RideShare::Driver.new(driver_id: 30, name: "Casper Flatley", vin: "L1CN7SPD96M6SNFYU") }

    it "Checking that Driver#trips returns an array with correct length" do

      casper.trips.class.must_equal Array

      casper.trips.length.must_equal RideShare::Trip.find_many_drivers(30).length
    end

    it "Returns the correct average trip ratings for a spacific driver" do
      # (5 + 3 + 3 + 4 + 2 + 2 + 2) / 7 = 3.0
      casper.average_rating.must_equal 3.0

    end
  end

end
