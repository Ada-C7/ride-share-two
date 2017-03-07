require_relative 'spec_helper'

describe "RideShare::Driver" do

  describe "RideShare::Driver#iniitalize" do

    it "A new driver can be initialized with a name, ID, and vin" do
      new_driver = RideShare::Driver.new("Kelsey", 1234, 234235234345)
      new_driver.must_be_instance_of RideShare::Driver
    end

  end

  describe "RideShare::Driver#valid_vin?" do
  end

  describe "RideShare::Driver#trips" do
  end

  describe "RideShare::Driver#avg_rating" do
  end

  describe "RideShare::Driver#self.all" do
  end

  describe "RideShare::Driver#self.find" do
  end

end
