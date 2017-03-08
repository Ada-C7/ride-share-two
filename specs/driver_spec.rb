# TODO: Make sure array is picking values correctly.

require_relative 'spec_helper.rb'

describe "retrieve an array from self.all" do
  before do
    # TODO: update to let()
    @driver = RideShare::Driver.all
  end
  it "retrieves an array" do
    @driver.must_be_instance_of Array
  end

  it "retrieves an id, name, and vin number" do
    CSV.read('support/drivers.csv') do |line|
      counter = 0
      @driver[counter][0].driver_id.must_equal line[counter][0].to_i #equal to? @driver[counter].driver_id.must_equal line[counter][0].to_i
      @driver[counter][1].name.must_equal line[counter][1].to_s #.name
      @driver[counter][2].vin.must_equal vin[counter][2].to_s #.vin
    end
  end

  it "verifies vin length" do
    CSV.read('support/drivers.csv') do |line|
      counter = 0
      @driver[counter][2].length.must_equal 17
      counter += 1
    end
  end

  # TODO: Edgecase and 'middle' case test
end
