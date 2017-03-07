require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver'
require 'csv'
require 'date'
Minitest::Reporters.use!

describe "Driver class" do
  describe "Driver#initialize" do
    it "Creates new instance of Driver class"do
    driver_hash = {driver_id: 2, name: "Natalia", vin: 12218997344900008}
    RideShare::Driver.new(driver_hash).class.must_equal RideShare::Driver
    end
    it "Raise ArgumentError if passing parameter is not a hash" do
      proc {
        RideShare::Driver.new([1,2,3,4,5])
      }.must_raise ArgumentError
    end
    it "Has driver_id, license, name as initial values" do
      driver_hash = {driver_id: 2,name: "Natalia", vin: 12218997344900008}
      driver = RideShare::Driver.new(driver_hash)
      driver.must_respond_to :driver_id
      driver.must_respond_to :vin
      driver.must_respond_to :name
    end
    it "Raise ArgumentError if VIN number not 17-char length long" do
      proc {
        driver_hash = {driver_id: 2, name: "Natalia", vin: 73449}
        RideShare::Driver.new(driver_hash)
      }.must_raise ArgumentError
    end
  end # end of initialize method test

  describe "Driver#all" do
    it "Driver.all returns an array" do
      RideShare::Driver.all.must_be_kind_of Array
    end
    it "Everything in the array is an Driver class" do
      all_drivers = RideShare::Driver.all
      all_drivers.each do |driver|
        driver.must_be_kind_of RideShare::Driver
      end
    end
    it " The number of drivers is correct" do
      all_drivers = RideShare::Driver.all
      all_drivers.length.must_equal 100
    end
    it " - The ID and balance of the first and last
          accounts match what's in the CSV file" do
      csv = CSV.read("support/drivers.csv", 'r')
      expected_id_first = csv[1][0].to_i
      expected_name_first = csv[1][1]
      expected_vin_first = csv[1][2]
      expected_id_last = csv[100][0].to_i
      expected_name_last = csv[100][1]
      expected_vin_last = csv[100][2]
      all_drivers = RideShare::Driver.all
      all_drivers[0].driver_id.must_equal expected_id_first
      all_drivers[0].name.must_equal expected_name_first
      all_drivers[0].vin.must_equal expected_vin_first
      all_drivers[99].driver_id.must_equal expected_id_last
      all_drivers[99].name.must_equal expected_name_last
      all_drivers[99].vin.must_equal expected_vin_last
    end
  end # end of all method




end # end of class
