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

    it "raises an argument error if..." do
      skip
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

    before do
      csv_file = './support/drivers.csv'
      # @trips_data = RideShare::FileData.read_csv(csv_file)
      data = FileData.new(csv_file)
      @drivers_data = data.read_csv_and_remove_headings
      @driver_bad_data_1 = [['three', '1', '54', "2016-04-05", '4']]
      @drivers_bad_data_2 = [['3', 'one', '54', "2016-04-05", '4']]
      @drivers_bad_data_3 = [['3', '1', 'fifity', "2016-04-05", '4']]
      @drivers_bad_data_4 = [['3', '1', '54', "hello", '4']]
      # four will not pass the 1-5 test so that is the argument error raised
      @drivers_bad_data_5 = [['3', '1', '54', "2016-04-05", 'four']]
      @drivers_bad_data_6 = [['3', '1', '54', "2016-04-05", '7']]
      @drivers_bad_data_7 = []
      @drivers_bad_data_8 = [[]]
    end

    let(:drivers) { RideShare::Driver.all(@drivers_data) }

    it "returns an array" do
      drivers.must_be_instance_of Array
    end

    it "has instances of drivers in the array" do
      drivers.each { |driver| driver.must_be_instance_of RideShare::Driver }
    end

    it "has the same number of driver instances as the CSV file" do
      drivers.length.must_equal 100
    end

    it "raises an arugment error if given bad data" do
      
    end
  end

  describe "Driver#find" do

    before do
      csv_file = './support/drivers.csv'
      data = FileData.new(csv_file)
      @driver_data = data.read_csv_and_remove_headings
    end

    it "requires argument(s)" do
      proc {
        RideShare::Driver.find()
      }.must_raise ArgumentError
    end

    it "returns a driver instance when passed a valid id" do
      RideShare::Driver.find(7, @driver_data).must_be_instance_of RideShare::Driver
    end

    it "returns nil when given a driver id that does not exists" do
      RideShare::Driver.find(900, @driver_data).must_be_nil
    end

    it "can find the first driver from the CSV" do
      first_driver_in_array = RideShare::Driver.find(1, @driver_data)
      first_driver_in_array.name.must_equal "Bernardo Prosacco"
      first_driver_in_array.id.must_equal 1
      # first_driver_in_array.vin.must_equal
    end

    it "cant find the last driver from the CSV" do
      last_driver = RideShare::Driver.find(100, @driver_data)
      last_driver.name.must_equal "Minnie Dach"
      last_driver.id.must_equal 100
      # last_driver.vin.must_equal
    end
  end
end
