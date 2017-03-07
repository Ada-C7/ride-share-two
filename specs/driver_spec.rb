require_relative 'spec_helper'

describe "Driver" do
  describe "constructor" do
    let (:driver) {RideShare::Driver.new}

    it "can be instantiated" do
      driver.must_be_instance_of RideShare::Driver
    end
  end
end
