require_relative 'spec_helper'

describe "RideShare::Driver" do

  let(:new_driver) { RideShare::Driver.new(1234, "Kelsey", "23423523434500000") }
  let(:new_driver2) { RideShare::Driver.new(1234, "Kelsey", "E98731") }
  let(:valid_driver) { RideShare::Driver.find(17)}


  describe "RideShare::Driver#iniitalize" do

    let(:driver_init) { RideShare::Driver.new(253, "Harry Potter", "123EFC345EGB178EX")}

    it "A new driver can be initialized with a ID, name, and vin" do
      driver_init.must_be_instance_of RideShare::Driver
    end

    it "Will raise an argument error if name is not a string" do
      proc { RideShare::Driver.new(8026, 1234, "234235234345") }.must_raise ArgumentError
    end

    it "Will raise an argument error if ID is not an integer" do
      proc { RideShare::Driver.new("8026", 1234, "234235234345") }.must_raise ArgumentError
    end

    it "Will raise an argument error if vin is not a string" do
      proc { RideShare::Driver.new(8026, 1234, 89034) }.must_raise ArgumentError
    end

    it "Will raise an argument error if vin is not a string with 17 characters" do
      proc { RideShare::Driver.new(8026, 1234, "23423234345") }.must_raise ArgumentError
    end

  end


  describe "RideShare::Driver#trips" do

    let(:driver_trips) { RideShare::Driver.find(25).trips}

    it "Returns an array" do
      driver_trips.must_be_instance_of Array
    end

    it "All objects in the array are RideShare::Trip instances" do
      driver_trips.each do | trip |
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "The driver_id of each trip matches the given argument" do
      driver_trips.each do | trip |
        trip.driver_id.must_equal 25
      end
    end

    it "Returns the correct number of trips" do
      driver_trips.length.must_equal 6
    end

  end


  describe "RideShare::Driver#avg_rating" do

    it "Returns an integer" do
       valid_driver.avg_rating.must_be_kind_of Float
    end

  end


  describe "RideShare::Driver#self.all" do

    let (:first_driver) { RideShare::Driver.all.first }
    let (:last_driver) { RideShare::Driver.all.last }
    let (:random_driver) { RideShare::Driver.all[36] }

    it "Initializes first line from drivers.csv as a new RideShare::Driver instance" do
      first_driver.id.must_equal 1
      first_driver.name.must_equal "Bernardo Prosacco"
      first_driver.vin.must_equal "WBWSS52P9NEYLVDE9"
    end

    it "Ititializes last line from drivers.csv as a new RideShare::Driver instance" do
      last_driver.id.must_equal 100
      last_driver.name.must_equal "Minnie Dach"
      last_driver.vin.must_equal "XF9Z0ST7X18WD41HT"
    end

    it "Ititializes random line from drivers.csv as a new RideShare::Driver instance" do
      random_driver.id.must_equal 37
      random_driver.name.must_equal "Arnulfo Anderson"
      random_driver.vin.must_equal "WBW8W7DC0FJLMYCCR"
    end

  end


  describe "RideShare::Driver#self.find" do

    it "Returns a RideShare::Driver" do
      valid_driver.must_be_instance_of RideShare::Driver
    end

    it "Is able to find random driver using the driver's ID" do
      valid_driver.name.must_equal "Federico Bins V"
    end

    it "Will raise an argument error if Driver ID is not found" do
      proc { RideShare::Driver.find(105) }.must_raise ArgumentError
    end

  end

end
