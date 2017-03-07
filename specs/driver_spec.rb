# #require relative spec_helper
# # require 'minitest'
# require 'minitest/autorun'
# require 'minitest/reporters'
# require 'minitest/skip_dsl'
# require_relative '../lib/driver'
require 'csv'
require_relative 'spec_helper'
# # add simplecov
# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "driver class" do

  it "requires 3 parameters for driver" do
    driver_id = 3099
    name = "Katie Nichols"
    vin = "BWSS52P9NEYLVDE90"

    driver = RideShare::Driver.new(driver_id, name, vin)

    driver.must_respond_to :driver_id
    driver.driver_id.must_equal driver_id

    driver.must_respond_to :name
    driver.name.must_equal name

    driver.must_respond_to :vin
    driver.vin.must_equal vin
  end
#potentially need to test for name and vin being a
# it "converts name to a string" do
#   driver_id = 3099
#   name = "Katie"
#   vin = "BWSS52P9NEYLVDE90"
#
#   driver = RideShare::Driver.new(driver_id, name, vin)
#   driver.name.must_be_instance_of String end

  it "raises an ArgumentError if vin is less than 17 characters" do
  proc {
    RideShare::Driver.new(133720003, "allison", "379")
  }.must_raise ArgumentError
  end

  it "raises an ArgumentError if vin is more than 17 characters" do
  proc {
    RideShare::Driver.new(133720003, "allison", "37909903w9405920182049505840022")
  }.must_raise ArgumentError
  end

  it "returns an array of all driver info" do
    info = RideShare::Driver.all_driver_info
    info.must_be_instance_of Array
  end

  it "Everything in the array is an instance of Driver" do
    info = RideShare::Driver.all_driver_info
    info.each do |object|
      object.must_be_instance_of RideShare::Driver
    end
  end

  it "The driver_id, name and vin must match" do
    info = RideShare::Driver.all_driver_info
    info.first.driver_id.must_equal 1
    info.first.name.must_equal "Bernardo Prosacco"
    info.first.vin.must_equal "WBWSS52P9NEYLVDE9"
  end

  it "the elements match what's in the file" do
    info = RideShare::Driver.all_driver_info
    index = 0
    CSV.read('support/drivers.csv') do |line|
    info[index].driver_id.must_equal line[0].to_i
    info[index].driver_id.must_equal line[1].to_i
    info[index].driver_id.must_equal line[2]
    index += 1
    end
  end 

end
