require_relative 'spec_helper'


# Try to use let! :) instead of before
describe "Driver class" do
  let(:driving) { RideShare::Driver.new(id: 1337, name: "ada", vin: "L1CKRVH55W8S6S9T1") }

  describe "Driver#initialize" do
    it "It takes a driver_hash argument" do
      driving.must_be_instance_of RideShare::Driver
    end

    it "Has the correct values that were passed" do
      driving.id.must_equal 1337
      driving.name.must_equal "ada"
      driving.vin.must_equal "L1CKRVH55W8S6S9T1"
    end

    it "Checks if vin has 17 characters" do
      skip
      driving.vin.length.must_equal 17
    end
  end

  describe "Driver.all" do
    let(:drivers) { RideShare::Driver.all }

    it "Returns an array with all the drivers info" do
      drivers.class.must_equal Array
    end

    it "Everything in the array is a Driver" do
      first_driver = drivers[0]
      first_driver.class.must_equal RideShare::Driver
    end

    it "The id of the first and last driver" do
      first_driver = drivers[1].id
      first_driver.must_equal 1
      last_driver = drivers.last.id
      last_driver.must_equal 100
    end

    it "The name of the first and last driver" do
      first_driver = drivers[1].name
      first_driver.must_equal "Bernardo Prosacco"
      last_driver = drivers.last.name
      last_driver.must_equal "Minnie Dach"

    end

    it "The vin of the first and last driver" do
      first_driver = drivers[1].vin
      first_driver.must_equal "WBWSS52P9NEYLVDE9"
      last_driver = drivers.last.vin
      last_driver.must_equal "XF9Z0ST7X18WD41HT"
    end

    it "driver info matches what's in the CSV file" do
      index = 1
      CSV.read("support/drivers.csv") do
        drivers[index].id.must_equal line[0].to_i
        drivers[index].name.must_equal line[1]
        drivers[index].vin.must_equal line[2]

        index += 1
      end
    end
  end

  describe "Driver.find" do
    let(:driver) { RideShare::Driver }

    it "Returns an account that exists" do
      driver_exists = driver.find(79)
      driver_exists.must_be_instance_of RideShare::Driver

      driver_exists.id.must_equal 79
      driver_exists.name.must_equal "Vivian Fahey"
      driver_exists.vin.must_equal "WD3Y8KHA4B7CC63K4"
    end

    it "Can find the first account from the CSV" do
      driver_exists = driver.find(1)
      driver_exists.id.must_equal 1
      driver_exists.name.must_equal "Bernardo Prosacco"
      driver_exists.vin.must_equal "WBWSS52P9NEYLVDE9"
    end

    it "Can find the last account from the CSV" do
      driver_exists = driver.find(100)
      driver_exists.id.must_equal 100
      driver_exists.name.must_equal "Minnie Dach"
      driver_exists.vin.must_equal "XF9Z0ST7X18WD41HT"
    end

    it "Raises an error for an account that doesn't exist" do
      proc { driver.find(1337) }.must_raise ArgumentError
    end
  end

  xdescribe "Driver#trips" do
    # Driver can talk to trips and this class will return a list of its trips based on the drivers id
    it "" do

    end

    it "" do

    end
  end

end

#include exception handling for all specs...
