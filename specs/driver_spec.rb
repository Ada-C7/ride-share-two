require_relative 'spec_helper'

describe "Driver class" do
  let(:driver)  {RideShare::Driver.new(31, "Sheila VonRueden", "KPH9RLSZ9YKNVMGH2")}
  describe "#initialize method" do
    it "Initializes a new driver instance from the parameter" do
      driver.must_be_instance_of RideShare::Driver
      driver.must_respond_to :id
      driver.id.must_equal driver_hash[:id]
      driver.must_respond_to :name
      driver.name.must_equal driver_hash[:name]
      driver.must_respond_to :vin
      driver.vin.must_equal driver_hash[:vin]
    end

    it "raises an argument error if Driver's ID or name are invalid" do
      proc {
        RideShare::Driver.new("1q", "Sheila VonRueden", "KPH9RLSZ9YKNVMGH2")
      }.must_raise ArgumentError
      proc {
        RideShare::Driver.new(31, 57448888, "KPH9RLSZ9YKNVMGH2")}.must_raise ArgumentError
      end

      it "raises an invalid vin error if VIN is invalid or it's length is not 17" do
        proc {
          RideShare::Driver.new(31, "Sheila VonRueden", 12345678912345678)
        }.must_raise InvalidVinError
        proc {
          RideShare::Driver.new(31, "Sheila VonRueden", "AAKPH9RLSZ9YKNVMGH2")
        }.must_raise InvalidVinError
      end
    end
  end
