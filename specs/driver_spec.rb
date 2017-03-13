require_relative 'spec_helper'

describe "Driver" do
  describe "constructor" do
    before do
      @name = 'Ada'
      @id = 68
      @vin = '123456789abcdefeg'
    end

    it "can be instantiated" do
      driver = RideShare::Driver.new(name: @name, id: @id, vin: @vin)
      driver.must_be_instance_of RideShare::Driver
    end

    it "takes a name, VIN, and ID" do
      driver = RideShare::Driver.new(name: @name, id: @id, vin: @vin)

      driver.must_respond_to :name
      driver.name.must_equal @name

      driver.must_respond_to :id
      driver.id.must_equal @id

      driver.must_respond_to :vin
      driver.vin.must_equal @vin
    end

    it "raises an argument error if the VIN is not a string" do
      proc {
        RideShare::Driver.new(vin: 23456789064234576)
      }.must_raise ArgumentError
    end

    it "raises an invalid VIN error if the VIN is not 17 characters long" do
      invalid_vin = '123456dfsd'

      proc {
        RideShare::Driver.new(vin: invalid_vin)
      }.must_raise RideShare::InvalidVinError
    end

    it "raises an invalid VIN error if the VIN has a character other than a letter or number" do
      invalid_vin = '12345!!#2345ddegd'

      proc {
        RideShare::Driver.new(vin: invalid_vin)
      }.must_raise RideShare::InvalidVinError
    end
  end

  # As this method simply calls the Trip.find_all_for_driver method,
  # extensive testing was not done.
  describe "trips" do
    it "returns only Trips that match this driver's id" do
      driver_77 = RideShare::Driver.new(id: 77)
      driver_77.trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
        trip.driver_id.must_equal driver_77.id
      end
    end

    it "returns an empty array if driver id is undefined" do
      driver = RideShare::Driver.new(vin: '123456789abcdefeg')
      driver.trips.must_be_empty
    end
  end

  describe "avg_rating" do
    let (:avg_rating_for_driver_44) {RideShare::Driver.new(id:44).avg_rating}
    # ratings_for_driver_44 = [5, 4, 4, 2, 4, 5, 3, 1]

    it "returns a float to 1 decimal point" do
      avg_rating_for_driver_44.must_be_instance_of Float
      avg_rating_for_driver_44.to_s.length.must_equal 3
    end

    it "returns the overall avg_rating for a driver" do
      avg_rating_for_driver_44.must_equal 3.5
    end

    it "returns nil if a Driver has no ratings and/or trips" do
      driver_with_no_trips = RideShare::Driver.new(id:100)
      driver_with_no_trips.avg_rating.must_be_nil
    end
  end

  describe "Driver.all" do
    let (:drivers) {RideShare::Driver.all}
    let (:driver_csv_info) {CSV.read("support/drivers.csv")[1 .. -1]} # ignore headers

    it "returns an array" do
      drivers.must_be_instance_of Array
    end

    it "contains only Driver elements in the returned array" do
      drivers.each { |driver| driver.must_be_instance_of RideShare::Driver }
    end

    it "returns the correct number of drivers" do
      expected_num_of_drivers = driver_csv_info.size
      num_of_drivers = drivers.length

      num_of_drivers.must_equal expected_num_of_drivers
    end

    it "initializes a first Driver with the CSV's first listed id, name, and vin" do
      first_driver_id = driver_csv_info.first[0].to_i
      first_driver_name = driver_csv_info.first[1]
      first_driver_vin = driver_csv_info.first[2]

      drivers.first.id.must_equal first_driver_id
      drivers.first.name.must_equal first_driver_name
      drivers.first.vin.must_equal first_driver_vin
    end

    it "initializes a last Driver with the CSV's last listed name, id, and vin" do
      last_driver_id = driver_csv_info.last[0].to_i
      last_driver_name = driver_csv_info.last[1]
      last_driver_vin = driver_csv_info.last[2]

      drivers.last.id.must_equal last_driver_id
      drivers.last.name.must_equal last_driver_name
      drivers.last.vin.must_equal last_driver_vin
    end
  end

  describe "Driver.find" do
    let (:driver_csv_info) {CSV.read("support/drivers.csv")[1 .. -1]} # ignore headers

    it "returns a Driver that exists" do
      third_driver_id = driver_csv_info[2][0].to_i
      find_and_verify_driver(third_driver_id)
    end

    it "can find the first Driver from the CSV file" do
      first_driver_id = driver_csv_info.first[0].to_i
      find_and_verify_driver(first_driver_id)
    end

    it "can find the last Driver from the CSV file" do
      last_driver_id = driver_csv_info.last[0].to_i
      find_and_verify_driver(last_driver_id)
    end

    it "returns nil if no driver_id is found" do
      fake_driver_id = 108
      RideShare::Driver.find(fake_driver_id).must_be_nil
    end

    private

    def find_and_verify_driver(driver_id)
      driver = RideShare::Driver.find(driver_id)
      driver.must_be_instance_of RideShare::Driver
      driver.id.must_equal driver_id
    end
  end
end
