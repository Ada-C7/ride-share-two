require_relative 'spec_helper'

describe "RideShare: Trip" do
  let(:trips) {RideShare::Trip.getAll}

  describe "Trip#initialize" do
    #   # it "contains individual hashes of ID, Name, VIN" do
    #   #   ada_drivers = RideShare::Drivers.new
    #   #   ada_drivers[0].must_be_kind_of Hash
    #   #   ada_drivers[0].key.must_equal
    #   # end
  end

  describe "Trip.read_csv" do
    it "returns an array of trip objects" do
      trips
      trips.must_be_kind_of Array
      trips[0].must_be_instance_of RideShare::Trip
    end
  end

  describe "Trips.getAll" do
    it "returns an array of 600 driver objects" do
      trips
      trips.length.must_equal 600
    end

    it "returns the correct details of a chosen driver object" do
      trips
      trips[6].id.must_equal 7
      trips[6].driver_id.must_equal 84
      trips[6].rider_id.must_equal 236
      trips[6].date.must_equal "2015-05-20"
      trips[6].rating.must_equal 4.0
    end
  end
  # #
  # # describe "Drivers.find_trips" do
  # #
  # # end
  # #
  # # describe "Driver.avg_ratings" do
  # #
  # # end
  # #
  describe "Trip.getDriver(id)" do
    it "returns the correct driver object" do
      trips
      driver = RideShare::Trip.getDriver(67)
      driver.must_be_instance_of RideShare::Driver
      driver.id.must_equal 9
      driver.name.must_equal "Simone Hackett"
      driver.vin.must_equal "4RA34A5K3YPN8H5P4"
    end
  end

  describe "Trip.getRider(id)" do
    it "returns the correct rider object" do
      trips
      rider = RideShare::Trip.getRider(13)
      rider.must_be_instance_of RideShare::Rider
      rider.id.must_equal 298
      rider.name.must_equal "Maybelle Wilkinson"
      rider.phone_num.must_equal "569.532.1204"
    end
  end

  describe "Trips#getTripsByDriver(driver_id)" do
    it "returns an array of trip objects" do
      trips
      driver_trips = RideShare::Trip.getTripsByDriver(26)
      driver_trips.must_be_kind_of Array
      driver_trips[0].must_be_instance_of RideShare::Trip
    end

    it "returns the correct number of trips" do
      trips
      driver_trips = RideShare::Trip.getTripsByDriver(26)
      driver_trips.length.must_equal 8
    end
  end

  describe "Trips#getTripsByRider(rider)" do
    it "returns an array of trip objects" do
      trips
      rider_trips = RideShare::Trip.getTripsByRider(137)
      rider_trips.must_be_kind_of Array
      rider_trips[0].must_be_instance_of RideShare::Trip
    end

    it "returns the correct number of trips" do
      trips
      rider_trips = RideShare::Trip.getTripsByRider(137)
      rider_trips.length.must_equal 6
    end
  end
end
# end
