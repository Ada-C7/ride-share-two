# require 'simplecov'
# SimpleCov.start
# require 'minitest/autorun'
# require 'minitest/reporters'
# require 'minitest/skip_dsl'
# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require_relative './spec_helper'
require_relative '../lib/driver'

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

    # Examples of driver data:
    # driver_id,name,vin
    # 1,Bernardo Prosacco,WBWSS52P9NEYLVDE9
    # 2,Emory Rosenbaum,1B9WEX2R92R12900E
    # 3,Daryl Nitzsche,SAL6P2M2XNHC5Y656

    before do
      csv_file = './support/drivers.csv'
      # @trips_data = RideShare::FileData.read_csv(csv_file)
      data = FileData.new(csv_file)
      @drivers_data = data.read_csv_and_remove_headings
      @drivers_bad_data_1 = [['ten', 'name', 'WBWSS52P9NEYLVDE9']]
      @drivers_bad_data_2 = [['10', 'name', 'WBWSS52P9NE']]
      @drivers_bad_data_3 = [['15', 'name', 'WBWSS52P9NE']]
      @drivers_bad_data_4 = [['10', 'name']]
      @drivers_bad_data_5 = []
      @drivers_bad_data_6 = [[],[],[]]
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

    it "raises an error if given bad data for driver_id" do
      proc { RideShare::Driver.all(@drivers_bad_data_1) }.must_raise ArgumentError
    end

    it "raises an error if given bad data for vin " do
      err = proc {
                   RideShare::Driver.all(@drivers_bad_data_2)
                 }.must_raise ArgumentError
      err.message.must_equal "vin must be 17 characters"
    end

    it "raises an error if given a info missing parts" do
      err = proc {
                   RideShare::Driver.all(@drivers_bad_data_4)
                 }.must_raise ArgumentError
      err.message.must_equal "driver info must have 3 parts"
    end

    it "raises an error if given an empty array" do
      err = proc {
                   RideShare::Driver.all(@drivers_bad_data_5)
                 }.must_raise ArgumentError
      err.message.must_equal "data is empty array"
    end

    it "raises an error if given empty nested arrays" do
      err = proc {
                   RideShare::Driver.all(@drivers_bad_data_6)
                 }.must_raise ArgumentError
      err.message.must_equal "driver info must have 3 parts"
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
#######################################################################
# randome driver to test with
# 15,Gayle Herzog,L1CDHZJ0567RJKCJ6
# or you should make up fake data so you know everything...

  before do
    csv_file_drivers = './support/drivers.csv'
    driver_data = FileData.new(csv_file_drivers)
    @drivers_data = driver_data.read_csv_and_remove_headings
    @driver_id = 15

    csv_file_trips = './support/trips.csv'
    trip_data = FileData.new(csv_file_trips)
    # trips data is the array of arrays that csv.read returns
    @trips_data = trip_data.read_csv_and_remove_headings
  end

  let(:driver) { RideShare::Driver.find(@driver_id, @drivers_data) }

  describe "Driver#get_trips" do

    it "returns an array of trip instances" do
      driver.get_trips.must_be_instance_of Array
      driver.get_trips.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    it "each trip instance has the same driver id" do
      driver.get_trips.each { |trip| trip.driver_id.must_equal @driver_id }
    end
  end

  describe "Driver#calculate_average_rating" do

    it "returns an number between 1 and 5" do
      trips = driver.get_trips
      driver.calculate_average_rating(trips).must_be :>=, 1
      driver.calculate_average_rating(trips).must_be :<=, 5
    end

  end
end
