require_relative '../specs/spec_helper.rb'

describe "Trip" do

  describe "Trip#initialize" do
    let(:my_trip) {RideShare::Trip.new(1, 1, 54, "2016-04-05", 3)}

    it "Should create a new instance of trip" do
      my_trip.must_be_instance_of RideShare::Trip
    end

    it "Should be associated with :trip_id, :driver_id, :rider_id, :date, and :rating" do
      my_trip.must_respond_to(:trip_id)
      my_trip.must_respond_to :driver_id
      my_trip.must_respond_to :rider_id
      my_trip.must_respond_to :date
      my_trip.must_respond_to :rating
    end
    end

  describe "Trip#all" do
    it "Should create instances of trips and their associated data" do
      RideShare::Trip.all.must_be_kind_of Array
    end
  end

  describe "Trip#find" do
    it "Should return the first account from the CSV file" do
      RideShare::Trip.find(1).trip_id.must_equal(1)
      RideShare::Trip.find(1).driver_id.must_equal(1)
      RideShare::Trip.find(1).rider_id.must_equal(54)
      RideShare::Trip.find(1).date.must_equal("2016-04-05")
      RideShare::Trip.find(1).rating.must_equal(3)
    end
# 30,28,230,2016-10-12,5
    it "Should return an existing account from the CSV file" do
      RideShare::Trip.find(30).trip_id.must_equal(30)
      RideShare::Trip.find(30).driver_id.must_equal(28)
      RideShare::Trip.find(30).rider_id.must_equal(230)
      RideShare::Trip.find(30).date.must_equal("2016-10-12")
      RideShare::Trip.find(30).rating.must_equal(5)
    end

    it "Should return the last account from the CSV file" do
      RideShare::Trip.find(600).trip_id.must_equal(600)
      RideShare::Trip.find(600).driver_id.must_equal(61)
      RideShare::Trip.find(600).rider_id.must_equal(168)
      RideShare::Trip.find(600).date.must_equal("2016-04-25")
      RideShare::Trip.find(600).rating.must_equal(3)
    end

    it "Should Raise an error when the account does not exist" do
      proc { RideShare::Trip.find(700)}.must_raise ArgumentError
    end
end
end
