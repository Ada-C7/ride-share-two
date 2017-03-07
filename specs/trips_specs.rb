require_relative 'spec_helper'

describe "Trip initialize" do
  it "Takes trip_id, driver_id, rider_id, date, rating" do

    trip_id = 1
    driver_id = 1
    rider_id = 54
    date = 2016-04-05
    rating = 3
    trip = RideShare::Trip.new(trip_id, driver_id, rider_id, date, rating)

    trip.must_respond_to :trip_id
    trip.trip_id.must_equal trip_id

    trip.must_respond_to :driver_id
    trip.driver_id.must_equal driver_id

    trip.must_respond_to :rider_id
    trip.rider_id.must_equal rider_id

    trip.must_respond_to :date
    trip.date.must_equal date

    trip.must_respond_to :rating
    trip.rating.must_equal rating
  end
end

describe "Trip.all" do

  before do
    @trip_array = RideShare::Trip.all
  end

  it "Returns an array of all accounts" do
    @trip_array.must_be_instance_of Array
  end


  #   - The number of trips is correct
  it "The number of trips is correct" do
    @trip_array.length.must_equal CSV.read("support/trips.csv").length - 1
  end
  #   - trip_array is an Array
  it "trip_array is an Array" do
    @trip_array.class.must_equal Array
  end

  #    - Everything in the array is a Trip
  it "Everything in the array is a trip" do
    @trip_array.each {|trip| trip.class.must_equal RideShare::Trip}
  end

  #   - The info of the first and last
  #       trips match what's in the CSV file
  it "trips match what's in the CSV file" do
    index = 0
    CSV.read("support/trips.csv", {:headers => true}).each do |line|
      @trip_array[index].trip_id.must_equal line[0]
      @trip_array[index].driver_id.must_equal line[1]
      @trip_array[index].rider_id.must_equal line[2]
      @trip_array[index].date.must_equal line[3]
      @trip_array[index].rating.must_equal line[4]
      index += 1
    end
  end

  it "The info of the first and last match csv" do
    @trip_array.first.trip_id.must_equal "1"
    @trip_array.first.driver_id.must_equal "1"
    @trip_array.first.rider_id.must_equal "54"
    @trip_array.first.date.must_equal "2016-04-05"
    @trip_array.first.rating.must_equal "3"
    @trip_array.last.trip_id.must_equal "600"
    @trip_array.last.driver_id.must_equal "61"
    @trip_array.last.rider_id.must_equal "168"
    @trip_array.last.date.must_equal "2016-04-25"
    @trip_array.last.rating.must_equal "3"
  end
end

describe "Trip.find" do
  before do
    @test_array = RideShare::Trip.all
  end
  # self.find(id) - returns an instance of a Trip
  # where the value of the trip_id field in the CSV matches
  # the passed parameter.
  it "Returns a Trip that exists" do
    test_variable = RideShare::Trip.find("2")
    test_variable.must_be_instance_of RideShare::Trip
    test_variable.trip_id.must_equal "2"
  end

  it "Can find the first account from the CSV" do
    RideShare::Trip.find(@test_array[0].trip_id).trip_id.must_equal "1"
  end

  it "Can find the last account from the CSV" do
    RideShare::Trip.find(@test_array[-1].trip_id).trip_id.must_equal "600"
  end
end
