require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/ride_share_driver.rb'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Driver#initialize" do
  it "Creates a Driver class" do
    driver = Driver.new(id, name, license_num, vehicle_id_num)
    driver.clasee.must_be_kind_of Rideshare::Driver
  end
end
