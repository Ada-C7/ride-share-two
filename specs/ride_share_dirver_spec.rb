require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/ride_share_driver.rb'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Driver#initialize" do
  it "Creates a Driver class" do
    args = {id: 1, name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9"}
    driver = Rideshare::Driver.new(args)
    driver.must_be_kind_of Rideshare::Driver
  end

  it "Raise an argument error if vin number is longer than 17" do
    args = {id: 1, name: "Bernardo Prosacco", vin: "WBWSS5245P9NEYLVDE29"}
    proc {Rideshare::Driver.new(args)}.must_raise ArgumentError
  end
end
