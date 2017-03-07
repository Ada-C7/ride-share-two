require_relative 'spec_helper'

describe "Rider class" do
  it "initializes with id, name, and phone number" do
    # skip
    initialization_hash = {
      name: "Ron Weasley",
      rider_id: 2,
      phone_num: "2062424564"
    }
    rider = RideShare::Rider.new(initialization_hash)

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
    RideShare::Rider.find(1).must_equal [1, "Nina Hintz Sr.", "560.815.3059"]
  end

  it "can find the last rider in the csv" do
    # skip
    RideShare::Rider.find(300).must_equal [300, "Miss Isom Gleason", "791-114-8423 x70188"]
  end

  it "can find the trips a rider has taken" do
    skip
  end

  it "can find the drivers a rider has ridden with" do
    skip
  end
end
