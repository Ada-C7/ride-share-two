require_relative 'spec_helper'

describe "Driver" do
  let(:my_driver) {RideShare::Driver.new(77, "Mr. Shanie Gusikowski", "XF9HHMKS402GD41NF")}
  let(:trips_csv) {CSV.read("support/trips.csv")}
  let(:all_drivers) {RideShare::Driver.find_all}
  let(:drivers_csv) {CSV.read("support/drivers.csv")}

  describe "Diver#initialize" do
    it "takes an ID, Name, and VIN to initialize" do
      my_driver.must_respond_to :id
      my_driver.must_respond_to :name
      my_driver.must_respond_to :vin
    end

    it "VIN numbers should be 17 characters" do
      proc {RideShare::Driver.new(1, 2, "3")}.must_raise InvalidVinError
    end
  end

  describe "Driver#trips" do
    it "returns an array of trips that this driver has taken" do
      my_driver.trips.must_be_instance_of Array
    end

    it "each item is of class Trip" do
      my_driver.trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "trips.length matches number of trips from CSV file for that driver" do
      trips_number = my_driver.trips.length
      lines_from_csv = []
      trips_csv.each do |line|
        if line[1].to_i == my_driver.id
          lines_from_csv << line
        end
      end
      lines_from_csv.length.must_equal trips_number
    end

    it "Returns 0 if driver is not found" do
      bad_id = RideShare::Driver.new(77777, "Mr. Shanie Gusikowski", "XF9HHMKS402GD41NF")
      bad_id.trips.must_equal 0
    end
  end

  describe "Driver#averate_rating" do
    it "returns an average_rating based on all trips given" do
      my_driver.average_rating.must_be_instance_of Float
      my_driver.average_rating.must_equal 4.2
    end

    #PROBABLY SHOULD WRITE SOME MORE TESTS HERE!!
  end

  describe "find_all Driver class method" do
    it "returns an array of Driver instances" do
      all_drivers.must_be_instance_of Array
    end

    it "each item is of class Driver" do
      all_drivers.each do |driver|
        driver.must_be_instance_of RideShare::Driver
      end
    end

    it "number of drivers matches number of lines in CSV - 1 for headder line" do
      csv_length = drivers_csv.length
      all_drivers.length.must_equal(csv_length - 1)
    end

    it "id of first & last match id of first & last in CSV" do
      all_drivers[0].id.must_equal(drivers_csv[1][0].to_i)
      all_drivers[-1].id.must_equal(drivers_csv[-1][0].to_i)
    end
  end

  describe "find_driver Driver class method" do
    it "should return one Driver based on numeric ID" do
      my_driver = RideShare::Driver.find_driver(53)
      my_driver.must_be_instance_of RideShare::Driver
    end

    #possibly want to return different cases if enter in
    #a number that's not a driver ID vs a string

    it "should return 0 if no driver found by that ID" do
      bad_id = RideShare::Driver.find_driver("apple")
      bad_id.must_equal 0
    end

  end

end
