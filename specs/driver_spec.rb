require_relative 'spec_helper'

describe "RideShare: Driver" do
  let(:drivers) {RideShare::Driver.getAll}

  describe "Driver#initialize" do
    it "creates the instance of a Driver" do
      driver = RideShare::Driver.new({id: 1234, name: "Ada", vin: "33333333333333333"})
      driver.must_be_instance_of RideShare::Driver
      driver.id.must_equal 1234
      driver.name.must_equal "Ada"
      driver.vin.must_equal "33333333333333333"
    end

    it "raises argument error when vin length is not 17-digits" do
      proc { RideShare::Driver.new(
        {id: 1234, name: "Ting", vin: 12345})
      }.must_raise NoMethodError
    end
  end

  describe "Driver.readCSV" do
    it "returns an array of driver objects" do
      drivers
      drivers.must_be_kind_of Array
      drivers[0].must_be_instance_of RideShare::Driver
    end
  end

  describe "Driver.find(id)" do
    it "returns a driver object" do
      driver = RideShare::Driver.find(99)
      driver.must_be_instance_of RideShare::Driver
      driver.name.must_equal "Jayden Ledner"
      driver.vin.must_equal "RF4AT3WL6JJXPFUJL"
    end
  end

  describe "Driver.getAll" do
    it "returns an array of 100 driver objects" do
      drivers
      drivers.length.must_equal 100
    end

    it "returns correct instances of driver objects" do
      driver = RideShare::Driver.find(7)
      driver.id.must_equal 7
      driver.name.must_equal "Lizeth Dickens"
      driver.vin.must_equal "W09XNTZR9KTFK10WW"
    end
  end

  describe "Driver.findTrips" do
    it "returns an array of trip objects" do
      driver = RideShare::Driver.find(7)
      driver.findTrips.must_be_kind_of Array
      driver.findTrips[0].must_be_instance_of RideShare::Trip
    end
  end

  describe "Driver.avgRatings" do
    it "calculates the correct average as a float" do
      driver = RideShare::Driver.find(90)
      driver.avgRating.must_equal 3.29
    end
  end
end
