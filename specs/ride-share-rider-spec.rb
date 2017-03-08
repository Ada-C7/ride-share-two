require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'csv'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/ride-share-rider'
require_relative 'spec-helper'

describe "RideShare::Rider" do

  let(:my_rider) { RideShare::Rider.new(2,"name", 395873456958409)}

  describe "initialize method" do

    it "must be an instance of Rider class" do
      my_rider.must_be_instance_of RideShare::Rider
    end

    it "name must be a string" do
      my_rider.name.must_be_kind_of String
    end

    it "id must be a number" do
      my_rider.id.must_be_kind_of Integer
    end

    it "phone number must be a number" do
      my_rider.phone.must_be_kind_of Integer
    end
  end

  describe "all method" do

    it "returns an array of all riders" do

      riders_array = RideShare::Rider.all
      riders_array.must_be_instance_of Array

      riders_array.each do |rider|
        rider.class.must_equal RideShare::Rider
      end

      riders_array.length.must_equal(300)

      riders_array[0].id.must_equal(1) # checking first element of array
      riders_array[0].name.must_equal("Nina Hintz Sr.")

      riders_array[299].id.must_equal(300) # checking last element of array
      riders_array[299].name.must_equal("Miss Isom Gleason")

    end
  end

  describe "find method" do

    it "returns rider that exists" do
      RideShare::Rider.find(3).wont_be_nil # non nil
    end

    it "can find the first rider from the CSV" do
      RideShare::Rider.find(1).wont_be_nil
    end

    it "can find the last rider from the CSV" do
      RideShare::Rider.find(300).wont_be_nil
    end
  end

  describe "to_s method" do

    it "returns string" do
      my_rider.to_s.must_be_kind_of String
    end
  end
end
