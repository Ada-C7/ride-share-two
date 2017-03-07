require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
# require 'minitest/pride'
require 'minitest/skip_dsl'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/ride_share_driver.rb'

describe "Driver" do
  # let (:driver) {driver = Rideshare::Driver.new(args)}

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

  describe "Driver.all" do
    it "Retrieve all drivers from the CSV file" do
      Rideshare::Driver.all.length.must_equal 100
    end

    it "Retrieve all drivers from the CSV file" do
      all = Rideshare::Driver.all
      expected = {id: 100, name: "Minnie Dach", vin: "XF9Z0ST7X18WD41HT"}
      all.last.must_equal expected
    end
  end

  # describe "Driver.find" do
  #   it do
  #
  #   end
  # end
  #
  # describe "Driver#all_trips" do
  #   it do
  #
  #   end
  # end
  #
  # describe "Driver#average_rating" do
  #   it do
  #
  #   end
  # end
end
