require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver'
Minitest::Reporters.use!

describe "Driver class" do
  describe "Driver#initialize" do
    it "Creates new instance of Driver class"do
    driver_hash = {driver_id: 2,  vin: 12218997344900008}
    RideShare::Driver.new(driver_hash).class.must_equal RideShare::Driver
    end
    it "Raise ArgumentError if passing parameter is not a hash" do
      proc {
        RideShare::Driver.new([1,2,3,4,5])
      }.must_raise ArgumentError
    end
    it "Has driver_id, license and vin as initial values" do
      driver_hash = {driver_id: 2, vin: 12218997344900008}
      driver = RideShare::Driver.new(driver_hash)
      driver.must_respond_to :driver_id
      driver.must_respond_to :vin
    end
    it "Raise ArgumentError if VIN number not 17-char length long" do
      proc {
        driver_hash = {driver_id: 2,  vin: 73449}
        RideShare::Driver.new(driver_hash)
      }.must_raise ArgumentError
    end


  end # end of initialize method test



end # end of class
