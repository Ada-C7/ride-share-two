require_relative 'spec_helper.rb'

describe RideShare::Driver do
  describe "initialize" do
    it "takes an id, name, and VIN" do
      id = 5
      name = "Marisol Rosales"
      vin = "WBWSS52P9NEYLVDE9"
      driver = RideShare::Driver.new(id, name, vin)
      driver.must_be_instance_of RideShare::Driver
      driver.id.must_equal id
      driver.name.must_equal name
      driver.vin.must_equal vin
      driver.vin.length.must_equal 17
    end
  end
  # describe "Trip method" do
  #   before do
  #     @driver = RideShare::Driver.new(@id = 5, @name = "Marisol", @vin = "WBWSS52P9NEYLVDE9")
  #   end
  #   it "driver.trip will return array" do
  #     @driver.trip.must_be_instance_of Array
  #   end
  describe "self.all" do
    before do
      @csv_driver = RideShare::Driver.all
    end
    it "checks for an array" do
      @csv_driver.must_be_instance_of Array
    end
    it "checks every array is instance of Driver" do
      @csv_driver.each do |driver|
        driver.must_be_instance_of RideShare::Driver
      end
    end
    it "checks correct length of csv driver file" do
      @csv_driver.length.must_equal 100
    end
  end

  describe "self.find" do
    before do
      id = 5
      @sample_driver_5 = RideShare::Driver.find(id)
    end
    it "checks for find method" do
      @sample_driver_5.must_be_instance_of RideShare::Driver
    end
    it "check id is 5" do
      @sample_driver_5.id.must_equal 5
    end
    it "checks that argument error is being raised if an invalid driver id is given" do
      proc { RideShare::Driver.find(900)
      }.must_raise ArgumentError
    end
  end

  # describe "trip_instances_for_driver" do
  #   before do
  #     driver_id = 5
  #     @list_of_trips_for_driver = Trip.find_trips_of_driver(driver_id)
  #   end
  #   it "check that Array is being returned" do
  #     @list_of_trips_for_driver.must_be_instance_of Array
  #   end
  #   it "tests to make sure the only output matches id given" do
  #     proc {
  #       Trip.find_trips_of_driver(999)
  #           }.must_raise ArgumentError
  #   end
  # end

end
