require_relative 'spec_helper'

describe "Driver Class" do

  describe "Initialize Method" do

    it "Initializes an object" do
      driver = RideShare::Driver.new({})
      driver.must_be_instance_of RideShare::Driver
    end

    it "Initializes with an ID, name, and VIN" do
      driver = RideShare::Driver.new({
        :id => 1,
        :name => "Bob McBob",
        :vin => 12345
        })
      driver.must_respond_to :id
      driver.must_respond_to :name
      driver.must_respond_to :vin
    end

  end

end
