require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/driver'

describe "RideShare::Driver" do
  before do
    #9,Simone Hackett,4RA34A5K3YPN8H5P4
    @driver = RideShare::Driver.new({id: "9", name: "Simone Hackett", vin: "4RA34A5K3YPN8H5P4"})
  end

  describe "Driver#initialize" do
    it "creates a new instance of trip" do
      @driver.must_be_instance_of RideShare::Driver
    end
    it "passes in the driver id" do
      @driver.id.must_equal "9"
    end
    it "passes in the driver name" do
      @driver.name.must_equal "Simone Hackett"
    end
    it "passes in the vin" do
      @driver.vin.must_equal "4RA34A5K3YPN8H5P4"
    end
    it "can create a new driver with a missing vin" do
      no_vin = RideShare::Driver.new({id: "87", name: "Tamiko Terada"})
      no_vin.vin.must_equal nil
    end
  end

  describe "Driver#all" do
    before do
      @drivers = RideShare::Driver.all
    end

    it "returns an array" do
      @drivers.must_be_kind_of Array
    end
    it "each returned element is a Driver instances" do
      @drivers.each do |object|
        object.must_be_instance_of RideShare::Driver
      end
    end
    it "returns the correct number of elements" do
      @drivers.length.must_equal 100 # rows in CSV file
    end
    it "correctly reads in the first row of the CSV file" do
      # last row of data: 1,Bernardo Prosacco,WBWSS52P9NEYLVDE9
      @drivers[0].id.must_equal "1"
      @drivers[0].name.must_equal "Bernardo Prosacco"
      @drivers[0].vin.must_equal "WBWSS52P9NEYLVDE9"
    end
    it "correctly reads in the last row of the CSV file" do
      # last row of data: 100,Minnie Dach,XF9Z0ST7X18WD41HT
      @drivers[-1].id.must_equal "100"
      @drivers[-1].name.must_equal "Minnie Dach"
      @drivers[-1].vin.must_equal "XF9Z0ST7X18WD41HT"
    end
  end
end
