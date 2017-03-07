require_relative './spec_helper'



describe "initialize" do
  before do
    driver_hash = {
      id: 88,
      name: "Scylla Bankroll",
      vin: "1G1H34JZ889X9LT46",
    }
    @driver = Driver.new(driver_hash)
  end

  it "has required attributes" do
    @driver.name.must_equal "Scylla Bankroll"
    @driver.id.must_equal 88
    @driver.vin.must_equal "1G1H34JZ889X9LT46"
  end
end

describe "self.all" do
  before do
    @all_drivers = Driver.all
  end

  it "creates an array of new Driver instances from a CSV file" do
    @all_drivers.must_be_instance_of Array
    @all_drivers.first.must_be_instance_of Driver
    @all_drivers.last.must_be_instance_of Driver
  end

  it "creates new Drivers that match the name and ID of first/last lines in file" do
    @all_drivers.first.id.must_equal 1
    @all_drivers.first.name.must_equal "Bernardo Prosacco"
    @all_drivers.last.id.must_equal 100
    @all_drivers.last.name.must_equal "Minnie Dach"
  end

end

xdescribe "get_trips" do
  it "retrieves a list of trip instances with this driver's id" do
    trip_list = @driver.get_trips
    sample_trip = trip_list.first
    sample_trip.must_be_instance_of Trip
    sa
  end



end
