require_relative 'spec_helper'

describe "Driver" do
  let(:my_driver) {RideShare::Driver.new(1, 2, "XF9HHMKS402GD41NF")}

  describe "Diver#initialize" do
    it "takes an ID, Name, and VIN to initialize" do
      my_driver.must_respond_to :id
      my_driver.must_respond_to :name
      my_driver.must_respond_to :vin
    end

    it "VIN numbers should be 17 characters" do
      proc {RideShare::Driver.new(1, 2, "3")}.must_raise InvalidVinError
    end
  end

end
