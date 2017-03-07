require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Driver" do

  describe "Driver#initialize" do
    before do
      driver_info = {
        id: 1,
        name: 'Bernardo Prosacco',
        vin: 'WBWSS52P9NEYLVDE9'
      }
      @new_driver = RideShare::Driver.new(driver_info)
    end

    it "initializes with 1 argument: a driver info hash" do
      @new_driver.must_be_instance_of RideShare::Driver
    end

    it "assigns instance variables: id, name, and vin" do
      @new_driver.id.must_equal 1
      @new_driver.name.must_equal 'Bernardo Prosacco'
      @new_driver.vin.must_equal 'WBWSS52P9NEYLVDE9'
    end
  end

  describe "Driver#all" do

    # lets work with let instead of before do - end
    let(:drivers) { RideShare::Driver.all('./support/drivers.csv') }

    # before do
    #   file = './support/drivers.csv'
    #   @drivers = RideShare::Driver.all(file)
    # end

    # honestly don't know what this error is but do know it's the built in error
    # ruby spits out if you try don't pass a file to CSV.read
    it "requires one argument: a csv file of driver info" do
      proc {
        RideShare::Driver.all("random text")
      }.must_raise Errno::ENOENT
    end

    it "returns an array" do
      drivers.must_be_instance_of Array
    end

    it "has instances of drivers in the array" do
      drivers.each { |driver| driver.must_be_instance_of RideShare::Driver }
    end

    it "has the same number of driver instances as the csv file" do
      drivers.length.must_equal 100
    end
  end

  describe "Driver#find" do

    before do
      @csv_file = './support/drivers.csv'
    end

    it "requires argument(s)" do
      proc {
        RideShare::Driver.find()
      }.must_raise ArgumentError
    end

    it "returns a driver instance when passed a valid id" do
      RideShare::Driver.find(7, @csv_file).must_be_instance_of RideShare::Driver
    end

    it "returns nil when given a driver id that does not exists" do
      RideShare::Driver.find(900, @csv_file).must_be_nil
    end

    it "can find the first driver from the CSV" do
      first_driver_in_array = RideShare::Driver.find(1, @csv_file)
      first_driver_in_array.name.must_equal "Bernardo Prosacco"
      first_driver_in_array.id.must_equal 1
      # first_driver_in_array.vin.must_equal
    end

    it "cant find the last driver from the CSV" do
      last_driver = RideShare::Driver.find(100, @csv_file)
      last_driver.name.must_equal "Minnie Dach"
      last_driver.id.must_equal 100
      # last_driver.vin.must_equal
    end
  end
end
