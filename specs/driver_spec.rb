require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver.rb'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Driver" do
  it "Can be instantiated" do
    @driver = RideShare::Driver.new
    @driver.must_be_instance_of RideShare::Driver
  end
end
