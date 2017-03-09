require_relative 'spec_helper'

describe "Driver" do

  describe "Driver.create_all_drivers" do

    before do
      @drivers = RideShare::Driver.create_all_drivers
    end

    it "Returns an array of all accounts" do
      @drivers.must_be_instance_of Array
    end

    it "The number of drivers is correct" do
      @drivers.length.must_equal 100
    end

    it "The driver_id and vin of the first and last" do

      @drivers.first.driver_id.must_equal 1
      @drivers.first.vin.must_equal "WBWSS52P9NEYLVDE9"

      @drivers.last.driver_id.must_equal 100
      @drivers.last.vin.must_equal "XF9Z0ST7X18WD41HT"

    end

  end

  it "Raises an ArgumentError/Says something when VIN is not 17 characters" do

    proc {
      RideShare::Driver.new(driver_id: 150, name: "Kaitlin Ramirez", vin: "W09XNTZR9KT")
    }.must_raise ArgumentError

  end

end
