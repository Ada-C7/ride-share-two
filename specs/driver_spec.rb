require_relative 'spec_helper'

describe "RideShare: Driver" do
  let(:drivers) {RideShare::Driver.getAll}

  describe "Driver#initialize" do
    #   # it "contains individual hashes of ID, Name, VIN" do
    #   #   ada_drivers = RideShare::Driver.new
    #   #   ada_drivers[0].must_be_kind_of Hash
    #   #   ada_drivers[0].key.must_equal
    #   # end

    # it "raises argument error when vin length is not 17-digits" do
    #   # drivers
    #
    # end
  end

  describe "Driver.readCSV" do
    it "returns an array of driver objects" do
      drivers
      drivers.must_be_kind_of Array
      drivers[0].must_be_instance_of RideShare::Driver
    end
  end

  describe "Driver.getAll" do
    it "returns an array of 100 driver objects" do
      drivers
      drivers.length.must_equal 100
    end

    it "returns correct instances of driver objects" do
      drivers
      drivers[6].id.must_equal 7
      drivers[6].name.must_equal "Lizeth Dickens"
      drivers[6].vin.must_equal "W09XNTZR9KTFK10WW"
    end
  end

  describe "Driver.findTrips" do
    it "returns an array of trip objects" do
      drivers
      driver = drivers[0]
      #is this really the best way to reference a driver? Could I do it without a loop to find the id of a specific driver?
      driver.findTrips.must_be_kind_of Array
      driver.findTrips[0].must_be_instance_of RideShare::Trip
    end
  end

  describe "Driver.avg_ratings" do
    it "calculates the correct average as a float" do
      drivers
      driver = RideShare::Driver.find(90)
      driver.avgRating.must_equal 3.29
    end
  end

  describe "Driver.find(id)" do
    it "returns a driver object" do
      drivers
      ## TW: Why does the below work in pry even if I haven't "loaded" the array with getAll?
      driver = RideShare::Driver.find(99)
      driver.must_be_instance_of RideShare::Driver
    end

    it "returns correct driver details" do
      drivers
      driver = RideShare::Driver.find(99)
      driver.id.must_equal 99
      driver.name.must_equal "Jayden Ledner"
      driver.vin.must_equal "RF4AT3WL6JJXPFUJL"
    end
  end
end
