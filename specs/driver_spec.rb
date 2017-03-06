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
  end # end oof initialize



end # end of class
