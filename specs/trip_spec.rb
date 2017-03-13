require_relative 'spec_helper'

describe "Trip" do
  let(:trips) { RideShare::Trip.all }
  let(:shakira_trips) { RideShare::Trip.find_by_driver(16) }
  let(:clementina_trips) { RideShare::Trip.find_by_rider(283) }
  let(:hipolito_trips) { RideShare::Trip.find_by_rider(100) }

  describe "Trip#initialize" do
    let(:joyride) { RideShare::Trip.new(9, 99, 999, "9999-99-99", 5) }

    it "Trip has an ID, driver ID, rider ID, date, and rating" do
      joyride.id.must_equal 9
      joyride.driver_id.must_equal 99
      joyride.rider_id.must_equal 999
      joyride.date.must_equal "9999-99-99"
      joyride.rating.must_equal 5
    end

    it "raises error if any of Trip's arguments are invalid" do
      proc {
        RideShare::Trip.new("Nine", 99, 999, "9999-99-99", 5)
      }.must_raise ArgumentError
      proc {
        RideShare::Trip.new(9, "Ninety-Nine", 999, "9999-99-99", 5)
      }.must_raise ArgumentError
      proc {
        RideShare::Trip.new(9, 99, [9, 9, 9], "9999-99-99", 5)
      }.must_raise ArgumentError
      proc {
        RideShare::Trip.new(9, 99, 999, { year: 1993, month: 5, date: 22 }, 5)
      }.must_raise ArgumentError
    end

    it "raises error if rating has is not an integer between 1 and 5" do
      proc {
        RideShare::Trip.new(9, 99, 999, "9999-99-99", "best ride of my life")
      }.must_raise InvalidRatingError
      proc {
        RideShare::Trip.new(9, 99, 999, "9999-99-99", -3)
      }.must_raise InvalidRatingError
      proc {
        RideShare::Trip.new(9, 99, 999, "9999-99-99", 100)
      }.must_raise InvalidRatingError
    end

  end


  describe "Trip#all" do

    it "returns an array of Trip instances" do
      trips.must_be_kind_of Array
      trips.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    it "returns array with the correct number of Trips from csv" do
      trips.length.must_equal 600
    end

    it "Trip instances match what's in the csv file" do
      index = 0
      CSV.read("support/trips.csv", headers: true) do |line|
        trips[index].id.must_equal line[0].to_i
        trips[index].driver_id.must_equal line[1].to_i
        trips[index].rider_id.must_equal line[2].to_i
        trips[index].rider_id.must_equal line[3]
        trips[index].rider_id.must_equal line[4].to_i

        index += 1
      end
    end

  end


  describe "Trip#find_by_driver and #find_by_rider" do

    it "raises an error if a non-integer is provided" do
      proc {
        RideShare::Trip.find_by_driver("Vin Diesel")
      }.must_raise ArgumentError
      proc {
        RideShare::Trip.find_by_rider("Dwayne 'The Rock' Johnson")
      }.must_raise ArgumentError
    end

    it "returns an array of Trip instances" do
      shakira_trips.must_be_kind_of Array
      shakira_trips.all? do |trip|
        trip.must_be_instance_of RideShare::Trip
      end

      hipolito_trips.must_be_kind_of Array
      hipolito_trips.all? do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "returns an array with all of the driver's Trip instances" do
      # come back to this - find_all returns array of trips! have to verify entire array, not just one trip instance in the array
      trip_ids = shakira_trips.map { |trip| trip.id }
      trip_ids.must_equal [38, 115, 302, 323, 428, 570]
    end

    it "returns an array with all of the rider's Trip instances" do
      trip_ids = clementina_trips.map { |trip| trip.id }
      trip_ids.must_equal [518]
    end

    it "returns empty array if trip doesn't exist" do
      RideShare::Trip.find_by_driver(700).must_equal []
      RideShare::Trip.find_by_rider(700).must_equal []
    end

  end

  describe "Trip#find_driver and #find_rider" do

    it "find_driver returns the right Driver" do
    my_trip = trips[3]
    my_trip.find_driver.must_be_instance_of RideShare::Driver

    my_trip.find_driver.id.must_equal trips[12].id
    end

    it "find_rider returns the right Rider" do
    my_trip = trips[5]
    my_trip.find_rider.must_be_instance_of RideShare::Rider

    my_trip.find_rider.id.must_equal trips[136].id
    end

  end

end
