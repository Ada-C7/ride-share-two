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

  it "doesn't let you initialize an id that's a string or 0" do
    proc {
      driver = RideShare::Driver.new({name: "Ron Weasley", driver_id: "stuff and things"})
    }.must_raise ArgumentError
  end

  it "returns an array of driver objects when you call .all" do
    # skip
      RideShare::Driver.all.must_be_kind_of Array
      RideShare::Driver.all[0].id.must_equal 1
  end

  it "can return the first driver from the CSV" do
    # skip
    RideShare::Driver.find(1).name.must_equal "Bernardo Prosacco"
  end

  it " can return the last driver from the CSV" do
    # skip
    RideShare::Driver.find(100).id.must_equal 100
  end

  it "won't return a driver that doesn't exist" do
    proc {
      RideShare::Driver.find(1000).id
    }.must_raise NoMethodError
  end

  it "can find all a single driver's trips" do
    driver.all_trips.must_be_kind_of Array
    driver.all_trips.length.must_equal 9
  end

  it "returns a message if id has no trips" do
    driver = RideShare::Driver.new({name: "Ron Weasley", driver_id: 101})
      proc {
        driver.all_trips
      }.must_raise ArgumentError
  end

  it "can find a single driver's average rating" do
    ron = driver.average_rating
    ron.must_be_kind_of Float
    ron.must_equal 2.33
  end

  it "will return a message if a driver has no ratings yet" do
    driver = RideShare::Driver.new({name: "Ron Weasley", driver_id: 101})
    proc {
      driver.average_rating
    }.must_raise ArgumentError
  end

  it "can find the total time a driver has spent driving" do
    driver.total_time.must_be_kind_of Integer
    driver.total_time.must_equal 342
  end

  it "can calculate the total revenue a driver has received" do
    driver.total_revenue.must_be_kind_of Float
    driver.total_revenue.must_equal 223.32
  end

  it "raises an error if a driver has no money" do
    driver = RideShare::Driver.new({name: "Ron Weasley", driver_id: 101})
    proc {
      driver.total_revenue
    }.must_raise ArgumentError
  end

end
