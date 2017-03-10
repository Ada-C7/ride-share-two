require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
require_relative '../lib/rider'

describe "instantiating a Rider" do
  it "#rider_id: returns the value of the @rider_id instance variable" do
    rider = RideShare::Rider.new(7, "Amy", "2065558989")
    rider.rider_id.must_equal 7
  end

  it "#name: returns the value of the @name instance variable" do
    rider = RideShare::Rider.new(7, "Amy", "2065558989")
    rider.name.must_equal "Amy"
  end

  it "#phone: returns the value of the @phone instance variable" do
    rider = RideShare::Rider.new(7, "Amy", "2065558989")
    rider.phone.must_equal "2065558989"
  end
end

describe "Rider.all" do
  it "all riders stored in an array" do # change to array of hashes to call by key (i.e. driver_id)?
    all_riders = RideShare::Rider.all
    all_riders.must_be_instance_of Array
  end

  it "The ID, name, and phone of the first and last rider match the CSV file" do

      RideShare::Rider.all.first.rider_id.must_equal 1
      RideShare::Rider.all.first.name.must_equal "Nina Hintz Sr."
      RideShare::Rider.all.first.phone.must_equal "560.815.3059"

      RideShare::Rider.all.last.rider_id.must_equal 300
      RideShare::Rider.all.last.name.must_equal "Miss Isom Gleason"
      RideShare::Rider.all.last.phone.must_equal "791-114-8423 x70188"

    index = 0
    CSV.read("./support/riders.csv") do |each_rider|
      rider[index].rider_id.must_equal each_driver[0].to_i
      rider[index].name.must_equal each_driver[1].to_s
      rider[index].phone.must_equal each_driver[2].to_s
      index += 1
    end
  end
end
