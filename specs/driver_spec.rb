require_relative './spec_helper'


describe "Driver" do
  before do
    @driver_hash = {
      id: 99,
      name: "Jayden Ledner",
      vin: "RF4AT3WL6JJXPFUJL"
    }

    @bad_vin_hash = {
      id: 99,
      name: "Jayden Ledner",
      vin: "RF4AT3WL6"
    }

    @no_trips_hash = {
      id: 100,
      name: "Minnie Dach",
      vin: "XF9Z0ST7X18WD41HT"
    }
  end

  let(:driver) { RideShare::Driver.new(@driver_hash) }

  describe "Driver initialize" do
    it "has required attributes" do
      driver.name.must_equal "Jayden Ledner"
      driver.id.must_equal 99
      driver.vin.must_equal "RF4AT3WL6JJXPFUJL"
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

    it "returns nil for a driver_id that doesn't exist" do
      RideShare::Driver.find(104).must_be_nil
    end
  end


  describe "get_trips" do
    it "retrieves a list of trip instances with this driver's id" do
      sample_trip = driver.get_trips.first
      sample_trip.must_be_instance_of RideShare::Trip
      sample_trip.driver_id.must_equal driver.id
    end
  end

  describe "avg_rating" do
    it "correctly calculates the average rating for a given driver's trips" do
      driver.avg_rating.must_be_close_to (17.0/6), 0.01
    end

    it "successfully copes with a driver that has no trips" do
      lazy_driver = RideShare::Driver.new(@no_trips_hash)
      lazy_driver.avg_rating.must_be_nil
    end
  end

end
