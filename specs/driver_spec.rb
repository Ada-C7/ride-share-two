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
    # DONE: Fix object calling issue. Test passing but not correct.

    CSV.read('support/drivers.csv') do |line|
      counter = 0
      @driver[counter].driver_id.must_equal line[counter][0].to_i
      @driver[counter].name.must_equal line[counter][1].to_s
      @driver[counter].vin.must_equal vin[counter][2].to_s

      counter += 1
    end
  end

  it "retrieves the first and last driver_id and name" do
    # skip
    # DONE: Fix object calling issue.

    @driver[0].driver_id.must_equal "1"
    @driver[0].name.must_equal "Bernardo Prosacco"

    @driver[99].driver_id.must_equal "100"
    @driver[99].name.must_equal "Minnie Dach"
  end

  it "retrieves random driver_id and name" do
    # skip
    @driver[61].driver_id.must_equal "62"
    @driver[61].name.must_equal "Jimmie Boehm"
  end

  it "verifies all vin length" do
    # skip
    CSV.read('support/drivers.csv') do |line|
      counter = 0
      @driver[counter][2].length.must_equal 17
      counter += 1
    end
  end

    it "retrieves first and last vin length" do
      # skip
      @driver[0].vin.must_equal "WBWSS52P9NEYLVDE9"
      @driver[99].vin.must_equal "XF9Z0ST7X18WD41HT"
    end

    it "retrieves random vin length" do
      @driver[61].vin.must_equal "WD251GUW8HGMJ0ZNZ"
    end
  # TODO: Edgecase and 'middle' case test
end

describe "driver: self.find" do
  # before do
  #   # TODO: update to let()
  #   @driver = RideShare::Driver.find
  # end

  it "retrieves first driver using driver_id" do
    @driver = RideShare::Driver.find("1")

    @driver.must_equal "Bernardo Prosacco"
  end

  it "retrieves last driver using driver_id" do
    @driver = RideShare::Driver.find("100")

    @driver.must_equal "Minnie Dach"
  end

  it "retrieves random driver using driver_id" do
    # skip
    @driver = RideShare::Driver.find("66")

    @driver.must_equal "Carey Christiansen I"
  end
end

describe "driver: trips" do
  before do
    # TODO: update to let()
    @driver = RideShare::Driver.new("", "", "")
  end

  it "finds first and last driver instances for first driver" do
    # skip
    instances = @driver.trips("1")
    array_1 = ["1", "1", "54", "2016-04-05", "3"]
    array_2 = ["553", "1", "266", "2016-12-16", "3"]

    instances[0].must_equal array_1
    instances[-1].must_equal array_2
  end

  it "finds driver instances for last driver" do
    instance = @driver.trips("100")
    array_1 = nil

    instance[0].must_equal array_1
  end

  it "finds first and last driver instances for random driver" do
    instances = @driver.trips("60")
    array_1 = ["81", "60", "241", "2016-05-22", "2"]
    array_2 = ["513", "60", "55", "2016-05-09", "5"]

    instances[0].must_equal array_1
    instances[-1].must_equal array_2
  end
end

describe "driver: avg_rating" do
  before do
    # TODO: update to let()
    @driver = RideShare::Driver.new("", "", "")
  end
  it "finds average rating for first driver" do
    avg_rating = @driver.avg_rating("1")

    avg_rating.must_equal 2
  end
  it "finds average rating for second-to-last driver" do
    avg_rating = @driver.avg_rating("99")

    avg_rating.must_equal 2
  end

  it "finds average rating for random driver" do
    avg_rating = @driver.avg_rating("13")

    avg_rating.must_equal 4
  end
end
