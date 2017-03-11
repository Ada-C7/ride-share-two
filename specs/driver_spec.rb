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

  describe "Driver.read_csv" do
    it "returns an array of driver objects" do
      drivers
      drivers.must_be_kind_of Array
      drivers[0].must_be_instance_of RideShare::Driver
    end
  end

  describe "Driver.getAll" do
    it "returns an array of 100 driver objects" do
      RideShare::Driver.getAll.length.must_equal 100
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
      RideShare::Trip.getAll
      drivers
      driver = drivers[0]
      #Is this how you test? By just selecting the first one? Seems off as I'm not citing id, and the first one might look good, but maybe not the last one?
      driver.findTrips.must_be_kind_of Array
      driver.findTrips[0].must_be_instance_of RideShare::Trip

    end
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
