require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver'
Minitest::Reporters.use!

describe "Driver class" do
  describe "Driver#initialize" do
    it "Creates new instance of Scoring class"do
    driver_hash = {driver_id: 2, license: 3044043, vin: 122189973449}
    RideShare::Driver.new(driver_hash).class.must_equal RideShare::Driver
    end
    it "Raise ArgumentError if passing parameter is not a hash" do
      proc {
        RideShare::Driver.new([1,2,3,4,5])
      }.must_raise ArgumentError
    end
    it "Has driver_id, license and vin as initial values" do
      driver_hash = {driver_id: 2, license: 3044043, vin: 122189973449}
      driver = RideShare::Driver.new(driver_hash)
      driver.must_respond_to :driver_id
      driver.must_respond_to :license
      driver.must_respond_to :vin
    end


  end # end of initialize method test



end # end of class
