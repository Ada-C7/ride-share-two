require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/ride_share_rider.rb'
require_relative '../lib/ride_share_trip.rb'

describe "Rider" do
  # let (:rider) {rider = Rideshare::Driver.new(args)}

  describe "Rider#initialize" do
    it "Creates a Rider class" do
      args = {id: 1, name: "Nina Hintz Sr.", phone_num: "560.815.3059"}
      rider = Rideshare::Rider.new(args)
      rider.must_be_kind_of Rideshare::Rider
    end
  end

  describe "Rider.all" do
    it "Retrieve all riders from the CSV file" do
      Rideshare::Rider.all.length.must_equal 300
    end

    it "Retrieve all riders from the CSV file" do
      all = Rideshare::Rider.all
      expected = {id: 300, name: "Miss Isom Gleason", phone_num: "791-114-8423 x70188"}
      all.last.must_equal expected
    end
  end
  #
  describe "Rider.find" do
    it "Find a specific rider using their numeric ID" do
      found = Rideshare::Rider.find(3)
      expected = {id: 3, name: "Marcellus Hoeger", phone_num: "(222) 926-0138"}
      found.must_equal expected
    end
  end

  describe "Rider#all_trips" do
    it "Retrieve the list of trip instances that only this rider has taken" do
      args = {id: 1, name: "Nina Hintz Sr.", phone_num: "560.815.3059"}
      expected = [
        {:trip_id=>46, :driver_id=>98, :rider_id=>1, :date=>"2016-06-28", :rating=>2},
        {:trip_id=>272, :driver_id=>17, :rider_id=>1, :date=>"2015-09-14", :rating=>4}
      ]
      rider = Rideshare::Rider.new(args)
      rider.all_trips.must_equal expected
    end
  end

  describe "Rider#all_drivers" do
    it "Retrieve the list of all previous drvier instances" do
      args = {id: 1, name: "Nina Hintz Sr.", phone_num: "560.815.3059"}
      rider = Rideshare::Rider.new(args)
      expected = [
        {id: 98, name: "Ms. Winston Emard", vin: "1F9Z5CF13VV8041ND"},
        {id: 17, name: "Federico Bins V", vin: "W092FDPH6FNNK102M"}
      ]
      rider.all_drivers.must_equal expected
    end
  end
end
