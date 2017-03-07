require_relative 'spec_helper'
require_relative '../lib/driver.rb'


describe "Driver" do
    describe "initialize method" do
        it "Driver.new must be an instance of a driver" do
            @my_driver = RideShare::Driver.new(16, "Travis Bickle", 123456)
            @my_driver.must_be_instance_of RideShare::Driver
        end
    end
end
