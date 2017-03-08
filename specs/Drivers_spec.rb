
require_relative 'spec_helper'


describe "Driver" do

  # before do
  #   @name
  #   @id
  #   @vehichle_id
  # end

  describe "self.all" do

    it "returns an array" do
      all_drivers = Driver.all
      all_drivers.must_be_instance_of Array

    end
    it "all elements of array should be drivers" do
      all_drivers = Driver.all
      all_drivers.each do |line|
        driver.must_be_instance_of Driver
      end
    end
    it "includes first data line" do
      all_drivers = Driver.all
      first_driver = all_drivers.first
      first_driver.name.must_equal "Bernardo Prosacco"

    end
    it "includes last data line" do
      all_drivers = Driver.all
      last_driver = all_drivers.last
      last_driver.name.must_equal "Minnie Dach"


    end
    it "includes line 50 of array" do
      all_drivers = Driver.all
      fifty_driver = all_drivers[49]
      fifty_driver.name.must_equal "Maye Bauch"
      fifty_driver.id.must_equal 50
    end
  end


  describe "self.find" do
    it "Should return an instance of driver" do
      my_driver = Driver.find(1)
      my_driver.must_be_instance_of Driver
    end
  end

  it "Raises ArgumentError if id is not found." do
    proc { Driver.find(300) }.must_raise ArgumentError
  end
end

  describe "driver_trips(trips)" do

  it "returns an array" do
  end
  it "all elements of array should be trip instances" do
  end
  it "each trip should have an driver_ID that matches the driver_ID that i'm in. " do
  end
end


describe "driver_rating" do

  it "Should return an integer" do

  end

  it "Driver ratings should correspond to trips taken by that driver" do
    #driver ID should match trip/riderID, see driver trips
  end


end





# my_driver = Driver.new( {name: "Olivia", id: 1, vehicle_id: "7GD5"} )
