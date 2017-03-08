require_relative 'spec_helper'
require 'pry'

describe "Driver Class" do

  describe "Initialize Method" do

    let(:driver) {
        RideShare::Driver.new({
        :id => 1,
        :name => "Bob McBob",
        :vin => 12345
        })
      }


    it "Initializes an object" do
      driver.must_be_instance_of RideShare::Driver
    end

    it "Initializes with an ID, name, and VIN" do
      driver.must_respond_to :id
      driver.must_respond_to :name
      driver.must_respond_to :vin
    end
  end

  describe "self.all" do

    let(:drivers) {RideShare::Driver.all }

    it "Returns an array" do
      drivers.must_be_instance_of Array
    end

    it "Returns an Array with elements" do
      drivers.length.must_be :>, 0
    end

    it "Returns an array of Driver Objects" do
      drivers.each do |driver|
        driver.must_be_instance_of RideShare::Driver
      end
    end

    it "Each driver object contains an id, name and vin" do
      drivers.each do |driver|
        driver.must_respond_to :id
        driver.must_respond_to :name
        driver.must_respond_to :vin
      end
    end

    it "Contains the correct information" do
      first = drivers[0]
      first.name.must_equal "Bernardo Prosacco"
      first.id.must_equal "1"
      first.vin.must_equal "WBWSS52P9NEYLVDE9"
    end
  end

  describe "self.find" do

    let(:driver) { RideShare::Driver.find("1") }

    it "Returns a driver object based on ID" do
      driver.must_be_instance_of RideShare::Driver
    end

    it "Returns the correct driver object" do
      driver.name.must_equal "Bernardo Prosacco"
      driver.vin.must_equal "WBWSS52P9NEYLVDE9"
    end

    it "Does not allow an invalid ID" do
      proc {
        RideShare::Driver.find("WBWSS52P9NEYLVDE9")
      }.must_raise InvalidIdError
    end

    it "Returns nil if the ID is not found" do
      RideShare::Driver.find("0").must_equal nil
    end

  end

  describe "Trips method" do

    let(:driver) { RideShare::Driver.all.first }



    it "Returns an Array" do
      drives = driver.trips
      drives.must_be_instance_of Array
    end

    it "Returns an Array of Objects" do
      drives = driver.trips
      drives.each { |d| d.must_be_instance_of RideShare::Trip }
    end

    it "Returns the correct information" do
      drives = driver.trips
      first = drives.first

      first.date.must_equal "2016-04-05"
    end

    it "Returns nil if a driver has no trips" do
      driver = RideShare::Driver.find("100")
      driver.trips.must_equal nil
    end
  end

  describe "Rating method" do
    let(:driver) { RideShare::Driver.all.first }
    let(:rating) { driver.rating }

    it "Returns a float" do
      rating.must_be_instance_of Float
    end

    it "Returns nil if there is no trip instances" do
      driver = RideShare::Driver.find("100")
      driver.rating.must_equal nil
    end

  end

end
