require_relative 'spec_helper'

describe "Driver tests" do
  let(:driver) { RideShare::Driver.new({ id: 4, name: "Ada", vin: "1XKAD49X2DJ395724" }) }
  let(:drivers_array) { RideShare::Driver.all }
  let(:csv_info) { CSV.read('support/drivers.csv')[1..-1] }

  describe "Driver#initialize" do
    it "Takes an ID, name, and VIN" do
      driver.must_respond_to :id
      driver.id.must_equal 4

      driver.must_respond_to :name
      driver.name.must_equal "Ada"

      driver.must_respond_to :vin
      driver.vin.must_equal "1XKAD49X2DJ395724"
    end

    it "Only accepts non-negative integer IDs" do
      driver_hash1 = { id: "id", name: "Ada", vin: "1XKAD49X2DJ395724" }
      driver_hash2 = { id: -5, name: "Ada", vin: "1XKAD49X2DJ395724" }

      proc { RideShare::Driver.new(driver_hash1) }.must_raise ArgumentError
      proc { RideShare::Driver.new(driver_hash2) }.must_raise ArgumentError
    end

    it "Only accepts non-empty strings for name and VIN" do
      driver_hash1 = { id: 4, name: "", vin: "1XKAD49X2DJ395724" }
      driver_hash2 = { id: 4, name: 45, vin: "1XKAD49X2DJ395724" }

      proc { RideShare::Driver.new(driver_hash1) }.must_raise ArgumentError
      proc { RideShare::Driver.new(driver_hash2) }.must_raise ArgumentError

      driver_hash3 = { id: 4, name: "Ada", vin: "" }
      driver_hash4 = { id: 4, name: "Ada", vin: [] }

      proc { RideShare::Driver.new(driver_hash3) }.must_raise ArgumentError
      proc { RideShare::Driver.new(driver_hash4) }.must_raise ArgumentError
    end

    it "All fields are required" do
      driver_hash1 = { name: "Ada", vin: "1XKAD49X2DJ395724" }
      driver_hash2 = { id: 4, vin: "1XKAD49X2DJ395724" }
      driver_hash3 = { name: "Ada", id: 4}

      proc { RideShare::Driver.new(driver_hash1) }.must_raise ArgumentError
      proc { RideShare::Driver.new(driver_hash2) }.must_raise ArgumentError
      proc { RideShare::Driver.new(driver_hash3) }.must_raise ArgumentError
    end
  end

  describe "Driver.all" do
    it "Driver.all returns an array" do
      drivers_array.must_be_instance_of Array
    end

    it "First and last element in array is a Driver" do
      drivers_array[0].must_be_instance_of RideShare::Driver
      drivers_array[-1].must_be_instance_of RideShare::Driver
    end

    it "The number of drivers is correct" do
      drivers_array.length.must_equal csv_info.count
    end

    it "The information for the first & last driver is correct" do
      drivers_array[0].id.must_equal csv_info[0][0].to_i
      drivers_array[0].name.must_equal csv_info[0][1]
      drivers_array[0].vin.must_equal csv_info[0][2]

      drivers_array[-1].id.must_equal csv_info[-1][0].to_i
      drivers_array[-1].name.must_equal csv_info[-1][1]
      drivers_array[-1].vin.must_equal csv_info[-1][2]
    end
  end

  describe "Driver.find" do
    it "Returns a driver that exists" do
      RideShare::Driver.find(64).must_be_instance_of RideShare::Driver
      RideShare::Driver.find(64).vin.must_equal "SUA9K8KA35CZ8X2FT"
    end

    it "Can find the first driver from the CSV" do
      RideShare::Driver.find(csv_info[0][0].to_i).must_be_instance_of RideShare::Driver
      RideShare::Driver.find(csv_info[0][0].to_i).name.must_equal csv_info[0][1]
    end

    it "Can find the last driver from the CSV" do
      RideShare::Driver.find(csv_info[-1][0].to_i).must_be_instance_of RideShare::Driver
      RideShare::Driver.find(csv_info[-1][0].to_i).vin.must_equal csv_info[-1][2]
    end

    it "Raises an error for a driver that doesn't exist" do
      proc { RideShare::Driver.find(789078) }.must_raise NoDriverError
    end
  end
end
