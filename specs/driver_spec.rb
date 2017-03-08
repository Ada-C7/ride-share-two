require_relative 'spec_helper'
# require 'simplecov'
# SimpleCov.start
#
# require 'rake/testtask'
# require 'minitest'
# require 'minitest/autorun'
# require 'minitest/reporters'
# require_relative '../lib/drivers'

# Minitest::Reporters.use!
# Minitest::Reporters::SpecReporter.new

describe "RideShare: Drivers" do
  let(:drivers) {RideShare::Drivers.read_csv}
  before do
    RideShare::Drivers.read_csv
  end

  describe "Drivers#initialize" do
  #   # it "contains individual hashes of ID, Name, VIN" do
  #   #   ada_drivers = RideShare::Drivers.new
  #   #   ada_drivers[0].must_be_kind_of Hash
  #   #   ada_drivers[0].key.must_equal
  #   # end
  end

  describe "Drivers.read_csv" do
    it "returns an array of drivers" do
      drivers
      drivers.must_be_kind_of Array
    end

    it "returns a hash of driver details" do
      drivers
      drivers[0].must_be_kind_of Hash
      drivers[0].keys.must_equal [:id, :name, :vin]
    end
  end

  describe "Drivers.all" do

    it "returns an array of 100 driver objects" do
      RideShare::Drivers.all.length.must_equal 100
    end
  end

  describe "Drivers.find_trips" do

  end

  describe "Driver.avg_ratings" do

  end

  describe "Driver.find(id)" do
    it "returns a driver object" do
      driver = RideShare::Drivers.find(99)
      driver.must_be_kind_of Hash
    end
  end

end
