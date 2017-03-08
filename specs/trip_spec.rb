require_relative 'spec_helper'

describe "Trip" do
  let(:trips) { RideShare::Trip.all }

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
      drivers.must_be_kind_of Array
      drivers.each { |trip| driver.must_be_instance_of RideShare::Trip }
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


  describe "Trip#find" do

    it "raises an error if a non-integer is provided" do
      proc {
        RideShare::Trip.find("that one trip")
      }.must_raise ArgumentError
    end

    it "returns an instance of Trip with matching driver ID" do
      RideShare::Trip.find(1).must_be_instance_of RideShare::Trip
    end

    it "can find any driver based on a randomly generated " do
      test_id = rand(1..100)
      driver_check = drivers[test_id - 1].id
      driver = RideShare::Trip.find(test_id)
      10.times { expect(driver.id).must_equal driver_check }
    end

    it "returns nil if account doesn't exist" do
      RideShare::Trip.find(383).must_be_nil
    end

  end


  # retrieve the list of trip instances that only this driver has taken
  describe "Trip#trips and #ratings" do
    let(:shakira) { RideShare::Trip.new(16, "Shakira Stamm", "SALUVSAL3WA67SBPZ") }

    it "returns an array whose length matches the number of Trip's trips" do
      shakira.trips.must_be_kind_of Array
      shakira.trips.length.must_equal RideShare::Trip.find_drivers(16).length
    end

    it "returns an array of all Trip instances" do
      shakira.trips.all? do | trip |
        trip.must_be_instance_of RideShare::Trip
      end
    end


    it "returns correct average rating for a Trip" do
      # (2 + 5 + 1 + 2 + 4 + 1) / 6
      shakira.average_rating.must_equal 2.5
    end

  end

end


# Each trip should:
# have an ID
# have a rider ID
# have a driver ID
# have a date
# have a rating
# Each rating should be within an acceptable range (1-5)
# use InvalidRatingError

# Given a trip object, you should be able to:
# retrieve the associated driver instance through the driver ID
# retrieve the associated rider instance through the rider ID

# You should be able to:
# find all trip instances for a given driver ID
# find all trip instances for a given rider ID
# retrieve all trips from the CSV file
