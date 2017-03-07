# require 'simplecov'
# SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver'
require 'csv'

describe "Driver" do
  describe "constructor" do
    let (:driver) {RideShare::Driver.new}

    it "can be instantiated" do
      driver.must_be_instance_of RideShare::Driver
    end
  end
end
