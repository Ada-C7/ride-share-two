# require 'minitest/autorun'
# require 'minitest/reporters'
# require 'minitest/skip_dsl'
# require_relative '../lib/'
# require 'csv'
# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require 'csv'
require_relative 'spec_helper'

describe "rider class" do

  it "requires three parameters for an instance of the rider class" do
    rider_id = 540
    name = "Bugs Bunny"
    phone_num = "206-230-9140"

    new_rider = RideShare::Rider.new(rider_id, name, phone_num)

    new_rider.must_respond_to :rider_id
    new_rider.rider_id.must_equal rider_id

    new_rider.must_respond_to :name
    new_rider.name.must_equal name

    new_rider.must_respond_to :phone_num
    new_rider.phone_num.must_equal phone_num
  end

  #for the self.all_rider_info method
  it "returns an array or all rider info" do
    # a_ride = RideShare::Rider.new(913, "Harry Potter", "509-979-7638")
    test_class = RideShare::Rider.all_rider_info
    test_class.must_be_instance_of Array
  end

  #for self.find_rider(rider_info)

  it "returns a rider account that exists" do
    test_class = RideShare::Rider.find_rider(1)
    test_class.rider_id.must_equal 1
    test_class.name.must_equal "Nina Hintz Sr."
    test_class.phone_num.must_equal "560.815.3059"
  end

  it "can find the last rider that exists" do
    test_class = RideShare::Rider.find_rider(300)
      test_class.must_be_instance_of RideShare::Rider
     test_class.rider_id.must_equal 300
     test_class.name.must_equal "Miss Isom Gleason"
     test_class.phone_num.must_equal "791-114-8423 x70188"
  end

it "raises an argument error if the driver doesn't exist" do
  proc { RideShare::Rider.find_rider(90493928) }.must_raise ArgumentError
end



end
