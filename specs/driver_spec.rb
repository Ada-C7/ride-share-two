require_relative 'spec_helper'
require_relative '../lib/driver'

describe RideShare::Driver do
  describe "#initialize" do
    it "Doesn't create a driver with missing parameters" do
      proc {
        RideShare::Driver.new
      }.must_raise ArgumentError
    end

    it "Doesn't allow a driver to be created with an invalid VIN" do
      proc {
        RideShare::Driver.new(id: 1234, name: "Bad Guy", vin: "NOTAVIN")
      }.must_raise ArgumentError
    end
  end

  describe "self.all" do
    before do
      @all = RideShare::Driver.all
    end

    it "Creates an array of all drivers from the csv file" do
      @all.must_be_instance_of Array
      @all.first.must_be_instance_of RideShare::Driver
    end

    it "Includes the first driver in the csv file" do
      @all.first.name.must_equal "Bernardo Prosacco"
    end

    it "Includes the last driver in the csv file" do
      @all.last.name.must_equal "Minnie Dach"
    end
  end

  describe "Instance Methods" do
    before do
      @driver = RideShare::Driver.new(id: 200, name: "Alix Hamilton", vin: "WBWSS52SALMONVDE9")
    end

  end
end
