require_relative 'spec_helper'

describe "Driver class" do
  let(:driver) { RideShare::Driver.new({name: "Ron Weasley", id: 1})}
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
    RideShare::Driver.all.length == CSV.read("./support/drivers.csv").length - 1
    puts CSV.read("./support/drivers.csv").length - 1
  end

  it "can return the first driver from the CSV" do
    # skip
    RideShare::Driver.find(1).must_equal ["Bernardo Prosacco", 1]
  end

  it " can return the last driver from the CSV" do
    # skip
    RideShare::Driver.find(100).must_equal ["Minnie Dach", 100]
  end

  it "can find all a single driver's trips" do
    skip

  end

  it "can find  a single driver's average rating" do
    skip

  end
end
