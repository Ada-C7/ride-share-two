require_relative 'spec_helper'
require_relative '../lib/driver'

describe "Driver class" do
  let (:driver_hash) { { id: 6, name: "Mr. Hyman Wolf", vin: "L1CXMYNZ3MMGTTYWU" } }
  let (:driver)  { RideShare::Driver.new(driver_hash) }

  describe "#initialize method" do
    it "Initializes a new driver instance from the parameter" do
      driver.must_be_instance_of RideShare::Driver
      driver.must_respond_to :id
      driver.id.must_equal driver_hash[:id]
      driver.must_respond_to :name
      driver.name.must_equal driver_hash[:name]
      driver.must_respond_to :vin
      driver.vin.must_equal driver_hash[:vin]
    end

    it "Raises an argument error if the vin number is invalid: must have length 17" do
      proc {
        RideShare::Driver.new({ id: 6, name: "Mr. Hyman Wolf", vin: "L1CXMYNZ3MMGTTYWUXXX" })
      }.must_raise ArgumentError
    end

    it "Raises an argument error if the driver_hash parameter is incomplete" do
      proc {
        RideShare::Driver.new({})
      }.must_raise ArgumentError

      proc {
        RideShare::Driver.new({ name: "Mr. Hyman Wolf", vin: "L1CXMYNZ3MMGTTYWU" })
      }.must_raise ArgumentError

      proc {
        RideShare::Driver.new({ nick_name: "Betsy", vin: "L1CXMYNZ3MMGTTYWU" })
      }.must_raise ArgumentError
    end

    it "Raises an argument error if the parameter is not hash" do
      proc {
        RideShare::Driver.new()
      }.must_raise ArgumentError

      proc {
        RideShare::Driver.new("6, Mr. Hyman Wolf, L1CXMYNZ3MMGTTYWU")
      }.must_raise ArgumentError
    end
  end

  describe "#trips method" do
    let (:trips_by_driver) { driver.trips }

    it "Retrieve the list of trip instances that only this driver has taken" do
      trips_by_driver.must_be_instance_of Array
      trips_by_driver.length.must_equal 3
      trips_by_driver.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    it "First element inside the returned array matches the CSV file" do
        trip = trips_by_driver.first
        trip.id.must_equal 162
        trip.driver_id.must_equal 6
        trip.rider_id.must_equal 93
        trip.date.must_equal "2015-03-09"
        trip.rating.must_equal 4
    end

    it "The last element inside the returned array matches the CSV file" do
      trip = trips_by_driver.last
      if trip != nil
        trip.id.must_equal 295
        trip.driver_id.must_equal 6
        trip.rider_id.must_equal 87
        trip.date.must_equal "2015-08-14"
        trip.rating.must_equal 1
      end
    end
  end

  describe "#avg_rating method" do
    it "Retrieve an average rating for that driver based on all trips taken" do
      average = driver.avg_rating
      average.must_be_instance_of Float
      average.must_equal 3.0
    end

    it "Returned value is in the range 1 - 5" do
      average = RideShare::Driver.new({ id: 23,	name: "Bo Stroman DVM", vin: "1F8C93JX5D62SYRYY" }).avg_rating
      average.must_be :>, 0
      average.must_be :<, 5
    end
  end

  let (:all_drivers_array) { RideShare::Driver.all }

  describe "#self.all method" do
    it "Retrieve all drivers from the CSV file" do
      all_drivers_array.must_be_instance_of Array
      all_drivers_array.length.must_equal 100
      all_drivers_array.each { |driver| driver.must_be_instance_of RideShare::Driver }
    end

    it "First element inside the returned array matches the CSV file" do
      driver = all_drivers_array.first
      driver.id.must_equal 1
      driver.name.must_equal "Bernardo Prosacco"
      driver.vin.must_equal "WBWSS52P9NEYLVDE9"
    end

    it "Last element inside the returned array matches the CSV file" do
      driver = all_drivers_array.last
      driver.id.must_equal 100
      driver.name.must_equal "Minnie Dach"
      driver.vin.must_equal "XF9Z0ST7X18WD41HT"
    end
  end

  describe "#self.find method" do
    it "Find a specific driver using their numeric ID" do
      driver = RideShare::Driver.find(6)
      driver.must_be_instance_of RideShare::Driver
      driver.id.must_equal 6
      driver.name.must_equal "Mr. Hyman Wolf"
      driver.vin.must_equal "L1CXMYNZ3MMGTTYWU"
    end
    it "Raises an argument error when invalid driver id is passed" do
      proc{
        RideShare::Driver.find("six")
      }.must_raise ArgumentError
    end

    it "Raises an argument error if the driver id does not have a match in the driver.csv" do
      proc{
        RideShare::Driver.find(123456789)
      }.must_raise ArgumentError
    end
  end
end
