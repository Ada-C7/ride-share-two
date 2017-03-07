require_relative 'spec_helper'
require 'csv'
require_relative '../lib/driver.rb'

# Try to use let! :) instead of before
describe "Driver class" do
  let(:testing) { RideShare::Driver.new(id: 1337, name: "testing", vin: "L1CKRVH55W8S6S9T1") }

  describe "Driver#initialize" do
    it "It takes a driver_id, name, and vin" do

    end

  end

  describe "Driver.all" do
    before do
      @driver = RideShare::Driver.all
    end

    it "Returns an array with all the drivers info" do
      @driver.class.must_equal Array
    end

    it "Everything in the array is an Driver" do
      first_driver = @driver[0]
      first_driver.class.must_equal RideShare::Driver
    end

    it "The ID, name, and vin of the first and last driver" do
    end
  end

  describe "Driver.find" do
    it "" do

    end

    it "" do

    end
  end

  describe "Driver#trips" do
    # Driver can talk to trips and this class will return a list of its trips based on the drivers id
    it "" do

    end

    it "" do

    end
  end

end

#include exception handling for all specs...
