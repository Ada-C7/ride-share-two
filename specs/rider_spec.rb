require_relative 'spec_helper'
# require 'simplecov'
# SimpleCov.start
#
# require 'rake/testtask'
# require 'minitest'
# require 'minitest/autorun'
# require 'minitest/reporters'
# require_relative '../lib/riders'
#
# Minitest::Reporters.use!
# Minitest::Reporters::SpecReporter.new

describe "RideShare: Rider" do
  let(:riders) {RideShare::Rider.all}

  describe "Drivers#initialize" do
    #   # it "contains individual hashes of ID, Name, VIN" do
    #   #   ada_drivers = RideShare::Drivers.new
    #   #   ada_drivers[0].must_be_kind_of Hash
    #   #   ada_drivers[0].key.must_equal
    #   # end
  end

  describe "Rider.read_csv" do
    it "returns an array of riders" do
      riders
      riders.must_be_kind_of Array
    end

    it "returns a hash of rider details" do
      riders
      riders[0].must_be_kind_of Hash
      riders[0].keys.must_equal [:id, :name, :phone_num]
    end
  end

  describe "Rider.all" do
    it "returns an array of 300 driver objects" do
      RideShare::Rider.all.length.must_equal 300
    end
  end

  describe "Rider.find_trips" do
    it "returns an array of trips" do
      riders
      trips = riders[0].find_trips
      trips.must_be_kind_of Array
    end

  end

  # describe "Driver.avg_ratings" do
  #
  # end
  #
  describe "Rider.find(id)" do
    it "returns a rider object" do
      rider = RideShare::Rider.find(300)
      rider.must_be_kind_of Hash
    end
  end

end
# end
