require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/ride_share_driver.rb'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Driver#initialize" do
  it "Creates a Driver class" do
    # args = (id: 1, name: "Bernardo Prosacco", license_num: "HXIK386F3", vin: "WBWSS52P9NEYLVDE9")
    driver = Rideshare::Driver.new(id: 1, name: "Bernardo Prosacco", license_num: "HXIK386F3", vin: "WBWSS52P9NEYLVDE9")
    driver.must_be_kind_of Rideshare::Driver
  end
end
