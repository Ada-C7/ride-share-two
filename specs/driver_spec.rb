require_relative './spec_helper'


describe "Driver initialize" do
  before do
    @driver_hash = {
      id: 88,
      name: "Scylla Bankroll",
      vin: "1G1H34JZ889X9LT46",
    }

    @bad_vin_hash = {
      id: 88,
      name: "Scylla Bankroll",
      vin: "1G1H3",
    }
  end

  let(:driver) { RideShare::Driver.new(@driver_hash) }


  it "has required attributes" do
    driver.name.must_equal "Scylla Bankroll"
    driver.id.must_equal 88
    driver.vin.must_equal "1G1H34JZ889X9LT46"
  end

  it "raises an error if VIN does not have seventeen digits" do
    proc {
      RideShare::Driver.new(@bad_vin_hash)
    }.must_raise InvalidVINError
  end
end

describe "self.all" do
  let(:all_drivers) { RideShare::Driver.all }

  it "creates an array of new Driver instances from a CSV file" do
    all_drivers.must_be_instance_of Array
    all_drivers.first.must_be_instance_of RideShare::Driver
    all_drivers.last.must_be_instance_of RideShare::Driver
  end

  it "creates new Drivers that match the name and ID of first/last lines in file" do
    all_drivers.first.id.must_equal 1
    all_drivers.first.name.must_equal "Bernardo Prosacco"
    all_drivers.last.id.must_equal 100
    all_drivers.last.name.must_equal "Minnie Dach"
  end

  # it "handles a bad VIN by skipping that line in the CSV data" do
  #   test_drivers = RideShare::Driver.all('specs/test_driver.csv')
  #   test_drivers.last.name.must_equal "Lizeth Dickens"
  # end
end

describe "self.find" do

  it "returns a driver that exists" do
    RideShare::Driver.find(24).wont_be_nil

  end

  it "can find a selection of drivers from the CSV" do
    RideShare::Driver.find(25).name.must_equal "Briana Braun"
    RideShare::Driver.find(92).name.must_equal "Oceane O'Kon"

  end

  it "raises an error for an account that doesn't exist" do
    proc { RideShare::Driver.find(104)}.must_raise ArgumentError
  end

end




xdescribe "get_trips" do
  it "retrieves a list of trip instances with this driver's id" do
    trip_list = driver.get_trips
    sample_trip = trip_list.first
    sample_trip.must_be_instance_of RideShare::Trip
    sa
  end



end
