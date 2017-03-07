require_relative 'spec_helper'


describe "Driver initialize" do
  it "Takes an ID, name, and vin" do
    id = "1"
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

  it "Returns an array of all drivers" do
    @driver_array.must_be_instance_of Array
  end

  #   - The number of accounts is correct
it "The number of accounts is correct" do
  @driver_array.length.must_equal CSV.read("support/drivers.csv").length
end
#   - account is an Array
it "account is an Array" do
  @driver_array.class.must_equal Array
end

#    - Everything in the array is a Driver
it "Everything in the array is a Driver" do
  @driver_array.each {|account| account.class.must_equal RideShare::Driver}
end

#   - The ID and balance of the first and last
  #       drivers match what's in the CSV file
  it " drivers match what's in the CSV file" do
    index = 0
    CSV.read("support/drivers.csv") do |line|
      drivers[index].id.must_equal line[0]
      drivers[index].id.must_equal line[1]
      drivers[index].id.must_equal line[2]
      index += 1
    end
  end

  it "The info of the first and last match csv" do
    @driver_array[1].id.must_equal "1"
    @driver_array[1].name.must_equal "Bernardo Prosacco"
    @driver_array[1].vin.must_equal "WBWSS52P9NEYLVDE9"
    @driver_array[-1].id.must_equal "100"
    @driver_array[-1].name.must_equal "Minnie Dach"
    @driver_array[-1].vin.must_equal "XF9Z0ST7X18WD41HT"
    end
end
