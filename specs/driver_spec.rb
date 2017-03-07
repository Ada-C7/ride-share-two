require_relative 'spec_helper'
# describe Driver do
#   before do
#     @test_driver = Driver.new
#   end
# end

describe "ALL_DRIVERS" do
  let(:all_drivers) {Rideshare::Driver::ALL_DRIVERS}

  it "contains the right number of rows" do
    all_drivers.length.must_equal 100
  end

  it "has a driver_id, vin, and name" do
    all_drivers.headers.wont_be_empty
    all_drivers.headers.must_include "driver_id"
    all_drivers.headers.must_include "vin"
    all_drivers.headers.must_include "name"
  end

  it "has the right kind of data for each element" do
    all_drivers[:driver_id].all?.must_be_kind_of Integer
    # driver[:vin].must_be_kind_of String
    # driver[:name].must_be_kind_of String
  end
end
end



describe initialize do
  it 'reads in the csv file correctly' do
    # each has an id
    # each has a name
    # each has a vehicle id number
    # it raises an error if the vehicle id number is an invaliod length
  end
end

describe "get_driver_rating" do
  it "retrieves an average rating for that driver based on all trips taken" do
  end
end

describe "subset_driver" do
  it "retrieves all the trip instances that the driver has taken" do
  end
end

describe "find_driver" do
  it "finds a specific driver using their numeric ID" do
  end
end
