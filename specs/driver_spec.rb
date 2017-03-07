
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require_relative '../lib/driver.rb'

describe "Ride_share_two" do
  describe "Driver#initialize" do
    it "Takes driver_id, driver_name, vin" do
      driver_id = 1
      driver_name = "Bernardo Prosacco"
      vin = "WBWSS52P9NEYLVDE9"
      driver1 = Ride_share_two::Driver.new(driver_id, driver_name, vin)
    end

    it "Raises an ArgumentError when vin is not proper length" do
      proc {
        Ride_share_two::Driver.new(1, "Bernardo Prosacco", "aaaaaa")
      }.must_raise ArgumentError
    end
  end
end
