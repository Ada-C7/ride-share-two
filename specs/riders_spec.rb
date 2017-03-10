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

  it "returns a list of rider objects when you call .all" do
    # skip
      RideShare::Rider.all.must_be_kind_of Array
      RideShare::Rider.all[0].id.must_equal 1
  end

  it "can find the first rider in the csv" do
    # skip
    RideShare::Rider.find(1).name.must_equal "Nina Hintz Sr."
  end

  it "can find the last rider in the csv" do
    # skip
    RideShare::Rider.find(300).id.must_equal 300
  end

  it "won't return a rider that doesn't exist" do
    proc {
      RideShare::Rider.find(0).id
    }.must_raise NoMethodError
  end

  it "can find the trips a rider has taken" do
    # skip
    rider.all_trips.must_be_kind_of Array
    rider.all_trips.length.must_equal 1
  end

  it "raises an ArgumentError when a rider exists but has no trips" do
    # skip
    rider = RideShare::Rider.new({name: "Ron Weasley", rider_id: 300, phone_num: "2062424564"})
    proc {
      rider.all_trips
    }.must_raise ArgumentError
  end

  it "can find the drivers a rider has ridden with" do
    # skip
    rider.all_drivers.must_be_kind_of Array
    rider.all_drivers.length.must_equal 1
  end

  it "can return the total money a rider has paid for any trip" do
    rider.total_cost.must_be_kind_of Integer
    rider.total_cost.must_equal 18
  end

  it "will raise an error for a rider that doesn't exist" do
    rider = RideShare::Rider.new({name: "Ron Weasley", rider_id: 30000, phone_num: "2062424564"})
    proc {
      rider.total_cost
    }.must_raise ArgumentError
  end

  it "can return the total amount of time a rider has spent on their trips" do
    rider.total_time.must_be_kind_of Integer
    rider.total_time.must_equal 56
  end

  
end
