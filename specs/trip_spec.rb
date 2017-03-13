
require_relative 'spec_helper.rb'

describe "retrieve an array from self.all" do
  before do
    @trip = RideShare::Trip.all
  end

  it "retrieve an array" do
    # skip
    @trip.must_be_instance_of Array
  end

  it "retrieves trip_id" do
    # skip
    CSV.read('support/drivers.csv') do |line|
      counter = 0
      @trip[counter].trip_id.must_equal line[counter][0].to_i
      puts @trip[counter]
      counter += 1
    end
  end

  it "finds the first trip instance (trip_id, driver_id, and rider_id)" do
    # skip
    @trip[0].trip_id.must_equal "1"
    @trip[0].driver_id.must_equal "1"
    @trip[0].rider_id.must_equal "54"
  end

  it "finds the last trip instance (trip_id, driver_id, and rider_id)" do
    # skip
    @trip[-1].trip_id.must_equal "600"
    @trip[-1].driver_id.must_equal "61"
    @trip[-1].rider_id.must_equal "168"
  end
end

describe "trip: find_all_driver_instances" do
  before do
    @trip = RideShare::Trip.new("", "", "", "", "")
  end

  it "find first and last driver instance from first driver_id" do
    # skip
    instances = @trip.find_all_driver_instances("1")

    array_1 = ["1", "1", "54", "2016-04-05", "3"]
    array_2 = ["553", "1", "266", "2016-12-16", "3"]

    instances[0].must_equal array_1
    instances[-1].must_equal array_2
  end

  it "find driver instance from last driver_id" do
    # skip
    instance = @trip.find_all_driver_instances("100")

    array_1 = nil

    instance[0].must_equal array_1
  end

  it "find first and last instance from random driver_id" do
    # skip
    instances = @trip.find_all_driver_instances("45")

    array_1 = ["29", "45", "127", "2016-02-02", "3"]
    array_2 = ["580", "45", "137", "2016-11-27", "2"]

    instances[0].must_equal array_1
    instances[-1].must_equal array_2
  end
end

describe "trip: find_all_rider_instances" do
  before do
    @trip = RideShare::Trip.new("", "", "", "", "")
  end

  it "find first and last rider instance from first rider_id" do
    # skip
    instances = @trip.find_all_rider_instances("1")

    array_1 = ["46", "98", "1", "2016-06-28", "2"]
    array_2 = ["272", "17", "1", "2015-09-14", "4"]

    instances[0].must_equal array_1
    instances[-1].must_equal array_2
  end

  it "find rider instance from last rider_id" do
    instance = @trip.find_all_rider_instances("600")

    array_1 = nil

    instance[0].must_equal array_1
  end

  it "find first and last rider instance from random rider_id" do
    # skip
    instances = @trip.find_all_rider_instances("89")

    array_1 = ["212", "28", "89", "2015-06-03", "1"]
    array_2 = ["306", "49", "89", "2017-02-03", "1"]

    instances[0].must_equal array_1
    instances[-1].must_equal array_2
  end
end
