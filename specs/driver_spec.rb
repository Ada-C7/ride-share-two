require_relative 'spec_helper'
require_relative '../lib/driver'

describe "Driver class" do
  before do
    @driver_hash = {id: 6, name: "Mr. Hyman Wolf", vin: "L1CXMYNZ3MMGTTYWU" }
    @driver = Driver.new(driver_hash)
  end

  describe "#initialize method" do
    it "Initializes a new driver instance from the parameter" do
      @driver.must_be_instance_of Driver
      @driver.must_respond_to :id
      @driver.id.must_equal @driver_hash[:id]
      @driver.must_respond_to :name
      @driver.name.must_equal @driver_hash[:name]
      @driver.must_respond_to :vin
      @driver.vin.must_equal @driver_hash[:vin]
    end

    it "Raises an argument error if the vin number is invalid: must have length 17" do
      proc {
        driver = Driver.new({ id: 6, name: "Mr. Hyman Wolf", vin: "L1CXMYNZ3MMGTTYWUXXX" })
      }.must_raise ArgumentError
    end

    it "Raises an argument error if the hash is incomplete" do
      proc {
        driver = Driver.new({})
      }.must_raise ArgumentError

      proc {
        driver = Driver.new({ name: "Mr. Hyman Wolf", vin: "L1CXMYNZ3MMGTTYWU" })
      }.must_raise ArgumentError

      proc {
        driver = Driver.new({ vin: "L1CXMYNZ3MMGTTYWU" })
      }.must_raise ArgumentError
    end

    it "Raises an argument error if the parameter is not hash" do
      proc {
        driver = Driver.new()
      }.must_raise ArgumentError

      proc {
        driver = Driver.new("6, Mr. Hyman Wolf, L1CXMYNZ3MMGTTYWU")
      }.must_raise ArgumentError
    end
  end

  describe "#trips method" do
    it "Retrieve the list of trip instances that only this driver has taken" do

    end

    it "" do

    end
  end

  describe "#avg_rating method" do
    it "Retrieve an average rating for that driver based on all trips taken" do

    end

  end

  describe "#self.all method" do
    it "Retrieve all drivers from the CSV file" do

    end
  end

  describe "#self.find method" do
    it "Find a specific driver using their numeric ID" do

    end
  end
end
