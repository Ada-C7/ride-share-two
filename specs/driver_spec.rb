require_relative 'spec_helper'

describe "Driver tests" do
  let(:driver) { Driver.new({ id: 4, name: "Ada", vin: "1XKAD49X2DJ395724" }) }

  describe "Driver#initialize" do
    it "Takes an ID, name, and VIN" do
      driver.must_respond_to :id
      driver.id.must_equal 4

      driver.must_respond_to :name
      driver.name.must_equal "Ada"

      driver.must_respond_to :vin
      driver.vin.must_equal "1XKAD49X2DJ395724"
    end

    it "only accepts integer IDs" do
      driver_hash = { id: "id", name: "Ada", vin: "1XKAD49X2DJ395724" }
      proc { Driver.new(driver_hash) }.must_raise ArgumentError
    end

    it "only accepts non-empty strings for names" do
      driver_hash1 = { id: 4, name: "", vin: "1XKAD49X2DJ395724" }
      driver_hash2 = { id: 4, name: 45, vin: "1XKAD49X2DJ395724" }

      proc { Driver.new(driver_hash1) }.must_raise ArgumentError
      proc { Driver.new(driver_hash2) }.must_raise ArgumentError
    end

    it "only accepts non-empty strings for VINs" do
      driver_hash1 = { id: 4, name: "Ada", vin: "" }
      driver_hash2 = { id: 4, name: "Ada", vin: [] }

      proc { Driver.new(driver_hash1) }.must_raise ArgumentError
      proc { Driver.new(driver_hash2) }.must_raise ArgumentError
    end
  end
end
