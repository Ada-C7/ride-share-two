require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/rider'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Rider" do
  describe "Rider#Initialize" do

    before do
      rider_info = {
        id: 6,
        name: "Patience Keeling II",
        phone_number: "412-432-7640"
      }
      @new_rider = RideShare::Rider.new(rider_info)
    end

    it "raises an argumen error if ..." do
      skip
    end

    it "initializes with 1 argument: a rider info hash" do
      @new_rider.must_be_instance_of RideShare::Rider
    end

    it "assigns instance variables: id, name, phone_number" do
      @new_rider.id.must_equal 6
      @new_rider.name.must_equal "Patience Keeling II"
      @new_rider.phone_number.must_equal "412-432-7640"
    end
  end

  describe "Rider#all" do
    let(:riders) { RideShare::Rider.all('./support/riders.csv') }

    it "requires one argument - a csv file" do
      proc {
        RideShare::Rider.all("random text")
      }.must_raise Errno::ENOENT
    end

    it "returns an array" do
      riders.must_be_instance_of Array
    end

    it "has instances of riders in the array" do
      riders.each { |rider| rider.must_be_instance_of RideShare::Rider }
    end

    it "has the same number of riders instances as the CSV file" do
      riders.length.must_equal 300
    end
  end
end
