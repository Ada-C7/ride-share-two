require_relative 'spec_helper'

describe "Driver class" do
  let(:drivers) { RideShare::Driver.all }
  let(:driver)  {RideShare::Driver.new(31, "Sheila VonRueden", "KPH9RLSZ9YKNVMGH2")}

  describe "#initialize method" do
    it "Initializes a new driver instance from the parameter" do
      driver.must_be_instance_of RideShare::Driver
      driver.must_respond_to :driver_id
      driver.driver_id.must_equal 31
      driver.must_respond_to :name
      driver.name.must_equal "Sheila VonRueden"
      driver.must_respond_to :vin
      driver.vin.must_equal "KPH9RLSZ9YKNVMGH2"
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

    describe "self.all method" do
      it "Retrieve all drivers from the CSV file" do
        drivers.must_be_instance_of Array
        drivers.each { |driver| driver.must_be_instance_of RideShare::Driver }
        drivers.length.must_equal 100
      end

      it "Include first instance of driver in the csv file" do
        drivers.first.driver_id.must_equal 1
        drivers.first.name.must_equal "Bernardo Prosacco"
        drivers.first.vin.must_equal "WBWSS52P9NEYLVDE9"
      end

      it "Include last instance of driver in the csv file" do
        drivers.last.driver_id.must_equal 100
        drivers.last.name.must_equal "Minnie Dach"
        drivers.last.vin.must_equal "XF9Z0ST7X18WD41HT"
      end
    end

    describe "self.find method" do
      it "find a specific driver using their numeric ID" do
        RideShare::Driver.find(4).must_be_instance_of RideShare::Driver
        RideShare::Driver.find(4).driver_id.must_equal 4
        RideShare::Driver.find(4).name.must_equal "Jeromy O'Keefe DVM"
        RideShare::Driver.find(4).vin.must_equal "L1CKRVH55W8S6S9T1"
      end

      it "Returns nil if given invalid id or id doesn't exist in file" do
        RideShare::Driver.find("abc").must_be_nil
        RideShare::Driver.find(1234).must_be_nil
      end
    end

    describe "trips method" do
      it "retrieve the list of trip instances that only this driver has taken
  " do
  driver.trips.must_be_instance_of Array
    end
  end
  
  describe "average_rating method" do
    it "retrieve an average rating for that driver based on all trips taken" do
RideShare::Driver.all[0].average_rating.must_equal 2.33
    end
  end
end
