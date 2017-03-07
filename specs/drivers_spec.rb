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
    driver.all_trips(driver.id).must_be_kind_of Array
    driver.all_trips(driver.id).length.must_equal 9
  end

  it "raises an ArgumentError if id is not a driver number in CSV" do
      proc {
        driver.all_trips(101)
      }.must_raise ArgumentError
  end

  it "rejects completely invalid input" do
    proc {
      driver.all_trips("bad string of input")
    }.must_raise ArgumentError

    proc {
      driver.all_trips("#{$12}")
    }.must_raise ArgumentError
  end

  it "can find  a single driver's average rating" do
    ron = driver.average_rating(driver.id)
    ron.must_be_kind_of Float
    ron.must_equal 2.33

  end
end
