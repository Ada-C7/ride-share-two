require_relative 'spec_helper'

describe "Driver class" do
  let(:driver) { RideShare::Driver.new({name: "Ron Weasley", driver_id: 1})}
  it "exists" do
    driver.class.must_be_kind_of Class
  end

  it "initializes with an ID and name" do
    # skip
    driver.must_respond_to :id
    driver.id.must_equal 1

    driver.must_respond_to :name
    driver.name.must_equal "Ron Weasley"
  end

  it "returns a list of drivers and IDs of the correct length when you call .all" do
    # skip
    RideShare::Driver.all.length == CSV.read("./support/drivers.csv").length
  end

  it "can return the first driver from the CSV" do
    # skip
    RideShare::Driver.find(1).must_equal [1, "Bernardo Prosacco"]
  end

  it " can return the last driver from the CSV" do
    # skip
    RideShare::Driver.find(100).must_equal [100, "Minnie Dach"]
  end

  it "can find all a single driver's trips" do
    skip

  end

  it "can find  a single driver's average rating" do
    skip

  end
end
