require_relative 'spec_helper'

describe "Driver class" do
  let(:driver_hash){{driver_id: 2, name: "Natalia", vin: "FNF18997344900008"}}
  let(:driver){RideShare::Driver.new(driver_hash)}
  let (:all_drivers) {RideShare::Driver.all}
  let(:driver1) {all_drivers[3]}

  describe "Driver#initialize" do
    it "Creates new instance of Driver class"do
      driver.class.must_equal RideShare::Driver
    end
    it "Raise ArgumentError if passing parameter is not a hash" do
      proc {
        RideShare::Driver.new([1,2,3,4,5])
      }.must_raise ArgumentError
    end
    it "Has driver_id, license, name as initial values" do
      driver.must_respond_to :driver_id
      driver.must_respond_to :vin
      driver.must_respond_to :name
    end
    it "Raise ArgumentError if VIN number is not 17-char length long" do
      proc {
        driver_hash = {driver_id: 2, name: "Natalia", vin: "73449"}
        RideShare::Driver.new(driver_hash)
      }.must_raise ArgumentError
    end

    it "Raise ArgumentError if passing name contains not letter or . or '  " do
      proc {
        hash = {driver_id: 32, name: "Na434talia", vin:  "1425394958"}
        RideShare::Driver.new(hash)
      }.must_raise ArgumentError
    end
    it "Raise ArgumentError if passing driver id is not an integer " do
      proc {
        hash = {driver_id: "32", name: "Natalia", vin:  "1425394958"}
        RideShare::Driver.new(hash)
      }.must_raise ArgumentError
    end
    it "Raise ArgumentError if passing driver id is <= 0 " do
      proc {
        hash = {driver_id: -32, name: "Natalia", vin:  "1425394958"}
        RideShare::Driver.new(hash)
      }.must_raise ArgumentError
    end
    it "Raise ArgumentError if passing VIN is not an string" do
      proc {
        hash = {driver_id: 32, name: "Natalia", vin:  1425394958}
        RideShare::Driver.new(hash)
      }.must_raise ArgumentError
    end
  end # end of initialize method test

  describe "Driver#all_driver_trips" do
    it "Return an array"do
      driver1.all_driver_trips.class.must_equal Array
    end
    it "Returned array must contain object(s) of class Trip" do
      driver1.all_driver_trips.each do |trip|
        trip.class.must_equal RideShare::Trip
      end
    end
    it "Returned empty array if there is no trip associated
    with this driver id" do
      driver_hash = {driver_id: 9000,name: "Natalia", vin: "12218997344900008"}
      driver = RideShare::Driver.new(driver_hash)
      driver.all_driver_trips.must_be_empty
    end
  end # end of all_driver_trips ,ethod

  describe "Driver#all" do
    it "Driver.all returns an array" do
      all_drivers.must_be_kind_of Array
    end
    it "Everything in the array is an Driver class" do
      all_drivers.each do |driver|
        driver.must_be_kind_of RideShare::Driver
      end
    end
    it " The number of drivers is correct" do
      all_drivers.length.must_equal 100
    end
    it " - The ID, vin and name of the first and last
          drivers match what's in the CSV file" do
      csv = CSV.read("support/drivers.csv", 'r')
      expected_id_first = csv[1][0].to_i
      expected_name_first = csv[1][1]
      expected_vin_first = csv[1][2]
      expected_id_last = csv[100][0].to_i
      expected_name_last = csv[100][1]
      expected_vin_last = csv[100][2]
      all_drivers = RideShare::Driver.all
      all_drivers[0].driver_id.must_equal expected_id_first
      all_drivers[0].name.must_equal expected_name_first
      all_drivers[0].vin.must_equal expected_vin_first
      all_drivers[99].driver_id.must_equal expected_id_last
      all_drivers[99].name.must_equal expected_name_last
      all_drivers[99].vin.must_equal expected_vin_last
    end
  end # end of all method

  describe "Driver.find" do
    it "Returns an driver that exists" do
      result = RideShare::Driver.find(16)
      result.must_be_kind_of RideShare::Driver
    end
    it "Can find the first driver from the CSV" do
      csv = CSV.read("support/drivers.csv", 'r')
      result = RideShare::Driver.find(csv[1][0].to_i)
      result.driver_id.must_equal RideShare::Driver.all[0].driver_id
      result.name.must_equal RideShare::Driver.all[0].name
      result.vin.must_equal RideShare::Driver.all[0].vin
    end
    it "Can find the last driver from the CSV" do
      csv = CSV.read("support/drivers.csv", 'r')
      result = RideShare::Driver.find(csv[100][0].to_i)
      result.driver_id.must_equal RideShare::Driver.all[99].driver_id
      result.name.must_equal RideShare::Driver.all[99].name
      result.vin.must_equal RideShare::Driver.all[99].vin
    end
    it "Raises an error for a driver that doesn't exist or
      if passing parameter is not positive integer" do
      proc {
        RideShare::Driver.find(3000)
      }.must_raise ArgumentError
      proc {
        RideShare::Driver.find(-3)
      }.must_raise ArgumentError
    end
  end # end of find method

end # end of class
