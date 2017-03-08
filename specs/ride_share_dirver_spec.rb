require_relative './spec_helper'

describe "Driver#initialize" do
  it "Creates a Driver class" do
    args = {id: 1, name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9"}
    driver = Rideshare::Driver.new(args)
    driver.must_be_kind_of Rideshare::Driver
  end

  it "Raise an argument error if vin number is longer than 17" do
    args = {id: 1, name: "Bernardo Prosacco", vin: "WBWSS5245P9NEYLVDE29"}
    proc {Rideshare::Driver.new(args)}.must_raise ArgumentError
  end
end

describe "Driver.all" do
  it "Retrieve all drivers from the CSV file" do
    Rideshare::Driver.all.length.must_equal 100
  end

  it "Retrieve all drivers from the CSV file" do
    all = Rideshare::Driver.all
    expected = {id: 100, name: "Minnie Dach", vin: "XF9Z0ST7X18WD41HT"}
    all.last.must_equal expected
  end
end

describe "Driver.find" do
  it "Find a specific driver using their numeric ID" do
    found = Rideshare::Driver.find(3)
    expected = {id: 3, name: "Daryl Nitzsche", vin: "SAL6P2M2XNHC5Y656"}
    found.must_equal expected
  end

  it "There's no driver info available, it tells so" do
    found = Rideshare::Driver.find(200)
    expected = "No match"
    found.must_equal expected
  end
end

describe "Driver#all_trips" do
  it "Retrieve the list of trip instances that only this driver has taken" do
    args = {id: 1, name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9"}
    driver = Rideshare::Driver.new(args)
    expected = [
      {:trip_id=>1, :driver_id=>1, :rider_id=>54, :date=>"2016-04-05", :rating=>3},
      {:trip_id=>122, :driver_id=>1, :rider_id=>247, :date=>"2015-12-24", :rating=>5},
      {:trip_id=>124, :driver_id=>1, :rider_id=>26, :date=>"2016-10-16", :rating=>4},
      {:trip_id=>216, :driver_id=>1, :rider_id=>201, :date=>"2015-03-24", :rating=>1},
      {:trip_id=>417, :driver_id=>1, :rider_id=>129, :date=>"2015-03-29", :rating=>1},
      {:trip_id=>434, :driver_id=>1, :rider_id=>112, :date=>"2015-06-07", :rating=>2},
      {:trip_id=>439, :driver_id=>1, :rider_id=>146, :date=>"2015-09-23", :rating=>1},
      {:trip_id=>530, :driver_id=>1, :rider_id=>196, :date=>"2016-04-04", :rating=>1},
      {:trip_id=>553, :driver_id=>1, :rider_id=>266, :date=>"2016-12-16", :rating=>3}
    ]
    driver.all_trips.must_equal expected
  end

  it "Retrieve the list of trip instances that only this driver has taken" do
    args = {id: 100, name: "Minnie Dach", vin: "XF9Z0ST7X18WD41HT"}
    driver = Rideshare::Driver.new(args)
    expected = "No history of trips"
    driver.all_trips.must_equal expected
  end
end

describe "Driver#average_rating" do
  it "Retrieve an average rating for that driver based on all trips taken" do
    args = {id: 1, name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9"}
    driver = Rideshare::Driver.new(args)
    driver.average_rating.must_equal 2.33
  end

  it "In case there's no average rating for driver, it tells so." do
    args = {id: 100, name: "Minnie Dach", vin: "XF9Z0ST7X18WD41HT"}
    driver = Rideshare::Driver.new(args)
    expected = "Average rating doesn't exit for this driver"
    driver.average_rating.must_equal expected
  end
end
