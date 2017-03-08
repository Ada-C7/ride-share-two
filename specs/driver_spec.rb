require_relative 'spec_helper'

describe "Driver class" do

  it "is an instance of Driver" do
    test_driver = Driver.new({id: 1, name: "George", vehicle_id: 3313})
    test_driver.must_be_kind_of Driver
  end

  describe "get_trips method" do
    before do
      @driver = Driver.new({id: 1, name: "Bernardo Prosacco", vehicle_id: "WBWSS52P9NEYLVDE9"})
      @trips = Trip.all_with_driver(@driver.id)
    end
    it "returns an array" do
      @trips.must_be_kind_of Array
    end
    it "all elements are Trip instances" do
      @trips.each do |trip|
        trip.must_be_kind_of Trip
      end
    end
    it "all Trips in array have same driver_id as id passed in" do
      this_id = @driver.id
      @trips.each do |trip|
        trip.driver_id.must_equal this_id
      end
    end
  end

  describe "average_rating method" do
    before do
      @driver = Driver.new({id: 54, name: "Rogers Bartell IV", vehicle_id: "1C9EVBRM0YBC564DZ"})
    end
    it "returns a float" do
      @driver.average_rating.must_be_kind_of Float
    end
    it "float is >= 1.0" do
      average = @driver.average_rating
      average.must_be :>=, 1.0
    end
    it "float is <= 5.0" do
      average = @driver.average_rating
      average.must_be :<=, 5.0
    end
  end

  describe "self.all method" do
    let(:all_drivers) {Driver.all("support/drivers.csv")}
    it "returns an array" do
      all_drivers.must_be_kind_of Array
    end
    it "all elements are Driver instances" do
      all_drivers.each do |driver|
        driver.must_be_kind_of Driver
      end
    end
    it "grabs first line of data from csv" do
      test_driver = nil
      test_driver = all_drivers.find {|driver| driver.id == 1}
      test_driver.must_be_kind_of Driver
    end
    it "grabs last line of data from csv" do
      test_driver = nil
      test_driver = all_drivers.find {|driver| driver.id == 100}
      test_driver.name.must_equal "Minnie Dach"
    end
    it "grabs random middle line of data from csv" do
      test_driver = nil
      test_driver = all_drivers.find {|driver| driver.id == 60}
      test_driver.vehicle_id.must_equal "TAMCBRPM7EN5GD88L"
    end
    it "raises no data error if no drivers in csv" do
      proc {Driver.all("support/empty.csv")}.must_raise NoDataError
    end
  end

  describe "self.find(id) method" do
    it "returns a Driver instance" do
      Driver.find(1).must_be_kind_of Driver
    end
    it "Driver's id matches the id passed in" do
      id = 1
      driver = Driver.find(id)
      driver.id.must_equal id
    end
    it "raises an error if no Driver returned" do
      proc {Driver.find(101)}.must_raise ArgumentError
    end

  end

end
