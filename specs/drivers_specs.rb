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
    @driver_array.length.must_equal CSV.read("support/drivers.csv").length - 1
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
    CSV.read("support/drivers.csv", {:headers => true}).each do |line|
      @driver_array[index].id.must_equal line[0]
      @driver_array[index].name.must_equal line[1]
      @driver_array[index].vin.must_equal line[2]
      index += 1
    end
  end

  it "The info of the first and last match csv" do
    @driver_array.first.id.must_equal "1"
    @driver_array.first.name.must_equal "Bernardo Prosacco"
    @driver_array.first.vin.must_equal "WBWSS52P9NEYLVDE9"
    @driver_array.last.id.must_equal "100"
    @driver_array.last.name.must_equal "Minnie Dach"
    @driver_array.last.vin.must_equal "XF9Z0ST7X18WD41HT"
  end
end

describe "Driver.find" do
  before do
    @test_array = RideShare::Driver.all
  end
  # self.find(id) - returns an instance of a Driver
  # where the value of the id field in the CSV matches
  # the passed parameter.
  it "Returns a driver that exists" do
    test_variable = RideShare::Driver.find("2")
    test_variable.must_be_instance_of RideShare::Driver
    test_variable.id.must_equal "2"
  end

  it "Can find the first account from the CSV" do
    RideShare::Driver.find(@test_array[0].id).id.must_equal "1"
  end

  it "Can find the last account from the CSV" do
    RideShare::Driver.find(@test_array[-1].id).id.must_equal "100"
  end


  # it "Raises an error for an account that doesn't exist" do
  #   proc {
  #     RideShare::Driver.find("0000")
  #   }.must_raise ArgumentError
  # end
end

# describe "driver.trips" do
#
#   before do
#     @test_driver = Driver.new("7", "Kelly", "WBWSS52P9NEYLVDE9")
#   end
#
#   it "Returns an array of all drivers" do
#     @driver_array.must_be_instance_of Array
#   end
# end
