require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/rider'
Minitest::Reporters.use!

describe "Rider class" do
  describe "Rider#initialize" do
    it "Creates new instance of Rider class"do
    rider_hash = {rider_id: 32, name: "Natalia", phone:  "1425394958"}
    RideShare::Rider.new(rider_hash).class.must_equal RideShare::Rider
    end
    it "Raise ArgumentError if passing parameter is not a hash" do
      proc {
        RideShare::Rider.new([1,2,3,4,5])
      }.must_raise ArgumentError
    end
    it "Has rider id, name and phone as initial values" do
      rider_hash = {rider_id: 32, name: "Natalia", phone:  "1425394958"}
      rider = RideShare::Rider.new(rider_hash)
      rider.must_respond_to :rider_id
      rider.must_respond_to :name
      rider.must_respond_to :phone
    end
  end # end of initialize method test



end # end of class
