
require_relative '../specs/spec_helper.rb'

describe "Driver" do

  describe "Driver#initialize" do

    let(:new_driver) do
      RideShare::Driver.new(1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE9")
    end

    it "Should create an instance of Driver" do
      new_driver.must_be_instance_of RideShare::Driver
    end

    it "Should be associated with :id, ;name, and :vin" do
      new_driver.must_respond_to(:id)
      new_driver.must_respond_to(:name)
      new_driver.must_respond_to(:vin)
    end
  end

  describe "Invalid Vin" do

    let(:new_driver) do
      RideShare::Driver.new(1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE")
    end

    it "The Vin must be 17 characters, an error will be raised if the vin length is invalid" do
      proc { new_driver }.must_raise(InvalidVinError)
    end
  end

  describe "Driver#all" do

    let (:drivers) do
      RideShare::Driver.all
    end

    it "Should create instances of drivers and their associated data" do
      drivers.must_be_kind_of Array
      drivers.length.must_equal 100
      drivers.each { |object| object.must_be_instance_of RideShare::Driver }
    end
  end

  describe "Driver#find" do
    let(:bernardo) { RideShare::Driver.find(1)}
    let(:verla) { RideShare::Driver.find(5)}
    let(:minnie) { RideShare::Driver.find(100)}
    let(:invalid_driver) { RideShare::Driver.find(101)}

    it "Returns the first account from the CSV file" do
      bernardo.id.must_equal(1)
      bernardo.name.must_equal("Bernardo Prosacco")
      bernardo.vin.must_equal("WBWSS52P9NEYLVDE9")
    end

    it "Returns an account that exists" do
      verla.id.must_equal(5)
      verla.name.must_equal("Verla Marquardt")
      verla.vin.must_equal("TAMLE35L3MAYRV1JD")
    end

    it "Can find the last account of the CSV file" do
      minnie.id.must_equal(100)
      minnie.name.must_equal("Minnie Dach")
      minnie.vin.must_equal("XF9Z0ST7X18WD41HT")
    end

    it "Raises an error when the account does not exist" do
      proc { invalid_driver }.must_raise(InvalidFileError)
    end
  end

  describe "#get_trips" do

    let(:new_driver) do
      RideShare::Driver.new(1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE9")
    end

    let(:minnie) do
      RideShare::Driver.new(100, "Minnie Dach", "XF9Z0ST7X18WD41HT")
    end

    it "Should return all trips taken by driver_id" do
      new_driver.get_trips.length.must_equal 9
      new_driver.get_trips.each do |object| object.must_be_instance_of(RideShare::Trip)
      end
    end

    it "Returns no trip when driver has not taken any trips" do
      # binding.pry
      minnie.get_trips.must_be_empty
      minnie.get_trips.must_be_kind_of Array
    end
  end

  describe "avg_rating" do

    let(:new_driver) do
      RideShare::Driver.new(1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE9")
    end

    it "Should return the average trip rating for the driver" do
      average = new_driver.avg_rating
      average.must_be_within_delta(2.33, 0.01)
    end
  end
end
