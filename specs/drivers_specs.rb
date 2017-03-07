
require_relative 'spec_helper'

describe "Driver initialize" do
  it "Takes an ID, name, and vin" do
    id = 1
    name = "Bernardo Prosacco"
    vin = "WBWSS52P9NEYLVDE9"
    driver = RideShare::Driver.new(id, name, vin)

    driver.must_respond_to :id
    driver.id.must_equal id

    driver.must_respond_to :name
    driver.name.must_equal name

    driver.must_respond_to :vin
    driver.vin.must_equal vin
  end
end

describe "Driver.all" do

  before do
    @driver_array = RideShare::Driver.all
  end

  it "Returns an array of all accounts" do
    @driver_array.must_be_instance_of Array
  end
end
