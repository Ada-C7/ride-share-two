# TODO: Make sure array is picking values correctly.

require_relative 'spec_helper.rb'

describe "driver: self.all" do
  before do
    # TODO: update to let()
    @driver = RideShare::Driver.all
  end

  it "retrieves an array" do
    @driver.must_be_instance_of Array
  end

  it "retrieves an id, name, and vin number" do
    # TODO: Fix object calling issue. Test passing but not correct.

    CSV.read('support/drivers.csv') do |line|
      counter = 0
      @driver[counter].driver_id.must_equal line[counter][0].to_i
      @driver[counter].name.must_equal line[counter][1].to_s
      @driver[counter].vin.must_equal vin[counter][2].to_s

      counter += 1
    end
  end

  it "retrieves the first and last driver_id" do
    # skip
    # FIXME: Fix object calling issue.

    @driver[0].driver_id.must_equal "1"
    @driver[99].driver_id.must_equal "100"
  end

  # TODO: Edgecase and 'middle' case test


  it "verifies all vin length" do
    # skip
    CSV.read('support/drivers.csv') do |line|
      counter = 0
      @driver[counter][2].length.must_equal 17
      counter += 1
    end
  end
  # TODO: Edgecase and 'middle' case test
end

describe "driver: self.find" do

end
