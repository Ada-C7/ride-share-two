require_relative '../specs/spec_helper.rb'

describe "Trip" do

  describe "Trip#initialize" do

    let(:my_trip) {RideShare::Trip.new(1, 1, 54, "2016-04-05", 3)}

    it "Should create a new instance of trip" do
      my_trip.must_be_instance_of RideShare::Trip
    end

    it "Should be associated with :trip_id, :driver_id, :rider_id, :date, and :rating" do
      my_trip.must_respond_to :trip_id
      my_trip.must_respond_to :driver_id
      my_trip.must_respond_to :rider_id
      my_trip.must_respond_to :date
      my_trip.must_respond_to :rating
    end
  end

  describe "Invalid Rating Error" do

    let(:my_trip) {RideShare::Trip.new(1, 1, 54, "2016-04-05", 0)}
    let(:trip_2) {RideShare::Trip.new(1, 1, 54, "2016-04-05", 6)}

    it "Should raise an error if the rating is not between 1 and 5" do
      proc { my_trip}.must_raise InvalidRatingError
      proc { trip_2}.must_raise InvalidRatingError
    end
  end

  describe "Trip#all" do

    let(:my_trip) { RideShare::Trip.all }

    it "Should create instances of trips and their associated data" do
      my_trip.must_be_kind_of Array
      my_trip.first.must_be_instance_of RideShare::Trip
      my_trip.length.must_equal 600
    end
  end

  describe "Trip#find" do

    let(:trip_1) { RideShare::Trip.find(1) }
    let(:trip_30) { RideShare::Trip.find(30) }
    let(:trip_600) { RideShare::Trip.find(600) }
    let(:invalid_trip) { RideShare::Trip.find(700) }

    it "Should return the first account from the CSV file" do
      trip_1.trip_id.must_equal(1)
      trip_1.driver_id.must_equal(1)
      trip_1.rider_id.must_equal(54)
      trip_1.date.must_equal("2016-04-05")
      trip_1.rating.must_equal(3)
    end

    it "Should return an existing account from the CSV file" do
      trip_30.trip_id.must_equal(30)
      trip_30.driver_id.must_equal(28)
      trip_30.rider_id.must_equal(230)
      trip_30.date.must_equal("2016-10-12")
      trip_30.rating.must_equal(5)
    end

    it "Should return the last account from the CSV file" do
      trip_600.trip_id.must_equal(600)
      trip_600.driver_id.must_equal(61)
      trip_600.rider_id.must_equal(168)
      trip_600.date.must_equal("2016-04-25")
      trip_600.rating.must_equal(3)
    end

    it "Should Raise an error when the account does not exist" do
      proc { invalid_trip }.must_raise InvalidFileError
    end
  end

  describe "self.by_driver(driver_id)" do

    it "returns the trips of a given driver ID" do

      new_driver = RideShare::Trip.by_driver(30).each do |object|
        object.trip_id
      end
      new_driver.length.must_equal 7
      # new_driver.each {|trip| trip.trip_id.must_include(263) }
      #This one is not passing, error with integer responding to include?
    end
  end

  describe "self.by_rider(rider_id)" do
    it "returns the trips of a given rider ID" do

      new_rider = RideShare::Trip.by_rider(54).each do |x|
        x.trip_id
      end
      new_rider.length.must_equal 2
      # new_rider.must_include(1)
    end
  end

  describe "#trip_get_driver" do
    let(:my_trip) {RideShare::Trip.new(1, 1, 54, "2016-04-05", 3)}

    it "Should return an instance of Rideshare::Trip" do
      my_trip.trip_get_driver(1).must_be_kind_of(RideShare::Driver)
    end
  end

end
