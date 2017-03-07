require_relative "spec_helper"
require_relative "../lib/driver"

describe "class Driver" do

  it "Driver#initialize: Takes an id, name and vehicle number" do
    id = "007"
    name = "James Bond"
    vin = "WBWSS52P9NEYLVDE9"
    driver1 = RideSharing::Driver.new(id, name, vin)

    driver1.must_respond_to :id
    driver1.id.must_equal id

    driver1.must_respond_to :name
    driver1.name.must_equal name

    driver1.must_respond_to :vin
    driver1.vin.must_equal vin
  end

  it "Driver#self.all: Returns an array." do
    path = "./support/drivers_spec1.csv"
    all_drivers = RideSharing::Driver.all(path)
    all_drivers.must_be_kind_of Array
  end

  it "Driver#self.all: The elements in the returned array must be RideSharing::Driver instances " do
    path = "./support/drivers_spec1.csv"
    all_drivers = RideSharing::Driver.all(path)
    all_drivers.each do |obj|
      obj.must_be_kind_of RideSharing::Driver
    end
    all_drivers.length.must_equal 3
  end

  it "Driver#self.all: Does not initialize driver if vin is not valid" do
    path = "./support/drivers_spec2.csv"
    all_drivers = RideSharing::Driver.all(path)
    all_drivers.length.must_equal 2
    all_drivers[0].name.must_equal "Bernardo Prosacco"
    all_drivers[1].name.wont_equal "Emory Rosenbaum"
  end

  it "Driver#self.all: drivers.csv should return 100 drivers" do
    all_drivers = RideSharing::Driver.all
    all_drivers.length.must_equal 100
  end




end # End of describe "class Driver"
