require 'csv'
require_relative 'spec_helper'

describe "driver class" do
#tests the initalize method
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

# #TODO test def driver_trip_instances
it "returns an array of all driver info" do
  driver_trips = RideShare::Driver.new(1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE9")
  driver_trips.driver_trip_instances.must_be_instance_of Array
end

# it "returns the correct instance of driver_id"
#   driver_trips = RideShare::Driver.new(1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE9")
# end



#tests def average_rating
it "returns an integer" do
  #do I have to test it here or in the trips
  avg_driver_rating = RideShare::Driver.new(1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE9" )
  avg_driver_rating.average_rating.must_be_instance_of Integer
end

it "the integer is between 1 and 5" do
  avg_driver_rating = avg_driver_rating = RideShare::Driver.new(1, "Bernardo Prosacco", "WBWSS52P9NEYLVDE9" )
  avg_driver_rating.average_rating.must_equal 2
end

it "the integer is between 1 and 5" do
  avg_driver_rating = RideShare::Driver.new(5, "hello", "WBWSS52P9NEYXVDE9" )
  avg_driver_rating.average_rating.must_equal 3
end

#tests self.all_driver_info
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
    info[index].driver_id.must_equal line[2].to_i
    index += 1
    end
  end

# self.find_drivers(driver_id) 7,Lizeth Dickens,W09XNTZR9KTFK10WW
  it "returns an account that exists" do
    search = RideShare::Driver.find_driver(7)
    search.must_be_instance_of RideShare::Driver
    search.driver_id.must_equal 7
    search.name.must_equal "Lizeth Dickens"
    search.vin.must_equal "W09XNTZR9KTFK10WW"
  end

  it "can find the first driver from the csv" do
    search = RideShare::Driver.find_driver(1)
    search.must_be_instance_of RideShare::Driver
    search.driver_id.must_equal 1
    search.name.must_equal "Bernardo Prosacco"
    search.vin.must_equal "WBWSS52P9NEYLVDE9"
  end

  it "can find the last driver from the csv" do
    search = RideShare::Driver.find_driver(100)
    search.must_be_instance_of RideShare::Driver
    search.driver_id.must_equal 100
    search.name.must_equal "Minnie Dach"
    search.vin.must_equal "XF9Z0ST7X18WD41HT"
  end

  it "raises an argument error if the driver doesn't exist" do
    proc { RideShare::Driver.find_driver(32222221)  }.must_raise ArgumentError
  end

end
