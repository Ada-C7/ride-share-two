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

    it "takes 1 argument: a driver info hash" do
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

      @bad_data = {
                    bad_id: [['2', 'Emory Rosenbaum', '1B9WEX2R92R12900E'], ['ten', 'name', 'WBWSS52P9NEYLVDE9']],
                    bad_vin: [['10', 'name', 'WBWSS52P9NE']],
                    empty_array: [],
                    empty_nested_arrays: [[],[],[]],
                    missing_part: [['10', 'name']],
                    bad_name: [['3', 'a', 'WBWSS52P9NEYLVDE9']]
                   }
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
      proc { RideShare::Driver.all(@bad_data[:bad_id]) }.must_raise ArgumentError
    end

    it "raises an error if given bad data for vin " do
      err = proc {
                   RideShare::Driver.all(@bad_data[:bad_vin])
                 }.must_raise ArgumentError
      err.message.must_equal "Vin must be 17 characters"
    end

    it "raises an error if given a info missing parts" do
      err = proc {
                   RideShare::Driver.all(@bad_data[:missing_part])
                 }.must_raise ArgumentError
      err.message.must_equal "Driver info must have 3 parts"
    end

    it "raises an error if given an empty array" do
      err = proc {
                   RideShare::Driver.all(@bad_data[:empty_array])
                 }.must_raise ArgumentError
      err.message.must_equal "Data is empty array"
    end

    it "raises an error if given empty nested arrays" do
      err = proc {
                   RideShare::Driver.all(@bad_data[:empty_nested_arrays])
                 }.must_raise ArgumentError
      err.message.must_equal "Driver info must have 3 parts"
    end

    it "raises an error if given improper name" do
      err = proc {
                   RideShare::Driver.all(@bad_data[:bad_name])
                 }.must_raise ArgumentError
      err.message.must_equal "Name length is under 3"
    end
  end

  describe "Driver#find" do

    it "requires one argument" do
      proc {
        RideShare::Driver.find()
      }.must_raise ArgumentError
    end

    it "returns a driver instance when passed a valid id" do
      RideShare::Driver.find(7).must_be_instance_of RideShare::Driver
    end

    it "returns nil when given a driver id that does not exists" do
      RideShare::Driver.find(900).must_be_nil
    end

    it "can find the first driver from the CSV" do
      first_driver_in_array = RideShare::Driver.find(1)
      first_driver_in_array.name.must_equal "Bernardo Prosacco"
      first_driver_in_array.id.must_equal 1
      # first_driver_in_array.vin.must_equal
    end

    it "cant find the last driver from the CSV" do
      last_driver = RideShare::Driver.find(100)
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
    @driver_id = 21
  end

  let(:driver) { RideShare::Driver.find(@driver_id) }

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

    # before do
    #   trips_data = [
    #                 ['900', '175', '920', '1-2-17','3'],
    #                 ['902', '175', '921', '1-3-17','4'],
    #                 ['903', '175', '922', '1-4-17','5'],
    #                 ['904', '175', '923', '1-5-17','3'],
    #                 ['905', '175', '924', '1-6-17','3'],
    #                 ['906', '175', '925', '1-7-17','4']
    #                ]
    #   @trips = RideShare::Trip.all(trips_data)
    #
    #   @driver_info = {
    #     id: 175,
    #     name: 'Cynthia',
    #     vin: 'WBWSS52P9NEYLVDE9'
    #   }
    # end
    #
    # let(:driver2) {RideShare::Driver.new(@driver_info)}

    it "returns an number between 1 and 5" do
      # trips = driver.get_trips
      # driver.calculate_average_rating(trips).must_be :>=, 1
      # driver.calculate_average_rating(trips).must_be :<=, 5
      # driver.calculate_average_rating(trips).must_be_instance_of Float

      # trips = driver.get_trips
      driver.calculate_average_rating.must_be :>=, 1
      driver.calculate_average_rating.must_be :<=, 5
      driver.calculate_average_rating.must_be_instance_of Float
    end

    # This spec is by passing the get_trips method
    # and is providing the trip instances array to calculate the average from ...
    it "calculates the correct average" do
      driver.calculate_average_rating.must_equal 30.0 / 11
      # driver2.calculate_average_rating(@trips).must_equal ((3 + 4 + 5 + 3 + 3 + 4) / 6.0)
    end
  end
end
