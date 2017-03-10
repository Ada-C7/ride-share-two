require_relative 'spec_helper'

describe "RideShare: Drivers" do
  let(:drivers) {RideShare::Driver.all}

  describe "Drivers#initialize" do
    #   # it "contains individual hashes of ID, Name, VIN" do
    #   #   ada_drivers = RideShare::Drivers.new
    #   #   ada_drivers[0].must_be_kind_of Hash
    #   #   ada_drivers[0].key.must_equal
    #   # end

    # it "raises argument error when vin length is not 17-digits" do
    #   # drivers
    #
    # end
  end

  describe "Drivers.read_csv" do
    it "returns an array of drivers" do
      drivers
      drivers.must_be_kind_of Array
    end

    it "returns an array of driver objects" do
      drivers
      drivers[0].must_be_instance_of RideShare::Driver
    end
  end

  describe "Drivers.all" do
    it "returns an array of 100 driver objects" do
      RideShare::Driver.all.length.must_equal 100
    end
  end

  describe "Drivers.find_trips" do

  end

  describe "Driver.avg_ratings" do

  end

  describe "Driver.find(id)" do
    it "returns a driver object" do
      drivers
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
