require_relative 'spec_helper'

describe "Driver Initialize" do

  it "Takes a Driver ID, name, vin" do
    driver_id = 54
    name = "Bob"
    vin = "4398A2039489R83Y3"
    driver = RideShareTwo::Driver.new(driver_id, name, vin)

    driver.must_respond_to :driver_id
    driver.driver_id.must_equal driver_id

    driver.must_respond_to :name
    driver.name.must_equal name

    driver.must_respond_to :vin
    driver.vin.must_equal vin
  end

  it "Raises an ArgumentError if the vin is greater than 17" do
    proc {
      RideShareTwo::Driver.new(54, "Bob", "4398A2039489R83Y3PPP", )
    }.must_raise ArgumentError
  end

  it "Raises an ArgumentError if the vin is less than 17" do
    proc {
      RideShareTwo::Driver.new(54, "Bob", "4398A2039489R", )
    }.must_raise ArgumentError
  end
end

describe "self.all_drivers" do
  let(:driver_list) {driver_list = RideShareTwo::Driver.all_drivers}

  it "Returns an array of all drivers" do
    driver_list
    driver_list.must_be_kind_of Array, "Oops - the class is not an array"
  end

  it "Everything in the array returned is a driver" do
    driver_list
    driver_list.each do |driver|
      driver.must_be_kind_of RideShareTwo::Driver, "This is not a driver."
    end
  end

  it "The number of drivers is correct" do
    driver_list
    driver_list.length.must_equal 100, "Oops you are missing a driver!"
  end

  it "The ID of the first driver match what's in the CSV file" do
    driver_list
    driver_list[0].driver_id.must_equal "1", "Oops the first id is not in the array"
  end

  it "The vin of the first driver match what's in the CSV file" do
    driver_list
    driver_list[0].vin.must_equal "WBWSS52P9NEYLVDE9", "Oops the first vin is not in the array"
  end

  it "The ID of the last driver match what's in the CSV file" do
    driver_list
    driver_list[99].driver_id.must_equal "100", "Oops the last id is not in the array"
  end

  it "The vin of the last driver match what's in the CSV file" do
    driver_list
    driver_list[99].vin.must_equal "XF9Z0ST7X18WD41HT", "Oops the last vin is not in the array"
  end

end
