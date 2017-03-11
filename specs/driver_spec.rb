
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

  describe "Driver#all" do

    it "Should create instances of drivers and their associated data" do
      RideShare::Driver.all.must_be_kind_of Array
    end
  end

  describe "Driver#find" do

    it "Returns the first account from the CSV file" do
      RideShare::Driver.find(1).id.must_equal(1)
      RideShare::Driver.find(1).name.must_equal("Bernardo Prosacco")
      RideShare::Driver.find(1).vin.must_equal("WBWSS52P9NEYLVDE9")
    end

    it "Returns an account that exists" do
      RideShare::Driver.find(5).id.must_equal(5)
      RideShare::Driver.find(5).name.must_equal("Verla Marquardt")
      RideShare::Driver.find(5).vin.must_equal("TAMLE35L3MAYRV1JD")
    end

    it "Can find the last account of the CSV file" do
      RideShare::Driver.find(100).id.must_equal(100)
      RideShare::Driver.find(100).name.must_equal("Minnie Dach")
      RideShare::Driver.find(100).vin.must_equal("XF9Z0ST7X18WD41HT")
    end

    it "Raises an error when the account does not exist" do
      proc { RideShare::Driver.find(101) }.must_raise(ArgumentError)
    end
  end

  describe "#get_trips" do

    let(:new_driver) do
      RideShare::Driver.new(1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE9")
    end


    it "Should return all trips taken by driver_id" do
      new_driver.get_trips.length.must_equal 9
      # puts new_driver.get_trips

      # binding.pry
      # .must_be_kind_of(Array)
      # binding.pry
      # new_driver.get_trips.must_be_instance_of(RideShare::Driver)
      # binding.pry
    end
  end

  describe "rating_average" do

    let(:new_driver) do
      RideShare::Driver.new(1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE9")
    end

    it "Should return the average trip rating for the driver" do

      new_driver.rating_average.must_be_kind_of(Numeric)
      average = new_driver.rating_average
      average.must_be_within_delta(3.01, 0.01)
    end

  end
end
