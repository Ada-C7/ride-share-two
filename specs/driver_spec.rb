require_relative 'spec_helper'

describe "Driver Class" do

  let(:ada) { Driver.new(name: 'Ada', id: 2, vin: 12345338303493234 )}

  describe "initialize method" do

    it "Instantiates a new instance of Driver class" do
      ada.must_be_instance_of Driver
    end

    it "Stored data must match what was passed as an argument" do
      ada.name.must_equal "Ada"
      ada.id.must_equal 2
      ada.vin.must_equal 12345338303493234
    end
  end #end of initialze method

  describe "self.all method" do

    let(:drivers) {Driver::all}

    it "Driver.all returns array" do
      drivers.class.must_equal Array
    end

    it "Each driver info is stored in a hash" do
      skip
      drivers.first.must_be_instance_of Hash
      drivers.last.must_be_instance_of Hash
    end

    it "The number of drivers is correct" do
      skip
      drivers.length.must_equal CSV.read(support/drivers.csv).count
    end

    it "The Id, name and vin number matches the first account " do
      skip
      drivers.first.id.must_equal
      drivers.first.name.must_equal
      drivers.first.vin.must_equal
    end

    it "the Id, name and vin number matched the last account" do
      skip
      drivers.last.id.must_equal
      drivers.last.name.must_equal
      drivers.last.vin.must_equal
    end

  end #end of self.all
end
