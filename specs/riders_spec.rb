require_relative 'spec_helper'

describe "Rider class" do
  let(:rider) {RideShare::Rider.new({name: "Ron Weasley", rider_id: 2, phone_num: "2062424564"})}
  it "initializes with id, name, and phone number" do
    # skip
    rider.must_respond_to :id
    rider.id.must_equal 2

    rider.must_respond_to :name
    rider.name.must_equal "Ron Weasley"

    rider.must_respond_to :phone_num
    rider.phone_num.must_equal "2062424564"
  end

  it "returns a list of riders of the correct length when you call .all" do
    # skip
    RideShare::Rider.all.length == CSV.read("./support/riders.csv").length - 1
  end

  it "can find the first rider in the csv" do
    # skip
    RideShare::Rider.find(1).name.must_equal "Nina Hintz Sr."
  end

  it "can find the last rider in the csv" do
    # skip
    RideShare::Rider.find(300).id.must_equal 300
  end

  it "can find the trips a rider has taken" do
    # skip
    rider.all_trips(rider.id).must_be_kind_of Array
    rider.all_trips(rider.id).length.must_equal 1
  end

  it "raises an ArgumentError if id is not a rider number in CSV" do
    proc {
      rider.all_trips(301)
    }.must_raise ArgumentError
  end

  it "rejects silly input" do
    proc {
      rider.all_trips("bad string of stuff")
    }.must_raise ArgumentError

    proc {
      rider.all_trips("#s32l")
    }.must_raise ArgumentError
  end
  it "can find the drivers a rider has ridden with" do
    # skip
    rider.all_drivers(rider.id).must_be_kind_of Array
    rider.all_drivers(rider.id).length.must_equal 1
  end
end
