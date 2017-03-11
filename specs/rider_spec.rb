require_relative 'spec_helper'

describe RideShare::Rider do
  describe "#initialize" do
    it "Initializes a rider when given valid parameters" do
      alix = RideShare::Rider.new(id: 6, name: "Alix", phone_number: "123-4567")

      alix.must_be_instance_of RideShare::Rider
      alix.name.must_equal "Alix"
    end

    it "Doesn't create a rider without an id" do
      proc {
        RideShare::Rider.new(name: "Alix", phone_number: "123-4567")
      }.must_raise ArgumentError
    end

    it "Doesn't create a rider without a name" do
      proc {
        RideShare::Rider.new(id: 4, phone_number: "123-4567")
      }.must_raise ArgumentError
    end

    it "Doesn't create a rider without a phone number" do
      proc {
        RideShare::Rider.new(id: 4, name: "Alix")
      }.must_raise ArgumentError
    end

    it "Doesn't create a rider when parameters are set to nil" do
      proc {
        RideShare::Rider.new(id: nil, name: "Alix", phone_number: "123-4567")
      }.must_raise ArgumentError
    end

    it "Doesn't create a rider when parameters are set to empty objects" do
      proc {
        RideShare::Rider.new(id: 5, name: "", phone_number: "123-4567")
      }.must_raise ArgumentError
    end
  end

  describe "self.all" do
    let(:all) { RideShare::Rider.all }

    it "Creates an array of all rider from the csv file" do
      all.must_be_instance_of Array
      all.first.must_be_instance_of RideShare::Rider
    end

    it "Includes the first rider in the csv file" do
      all.first.name.must_equal "Nina Hintz Sr."
    end

    it "Includes the last rider in the csv file" do
      all.last.name.must_equal "Miss Isom Gleason"
    end
  end

  describe "self.find" do
    it "Returns a rider object when given a valid rider ID" do
      rider = RideShare::Rider.find(139)

      rider.must_be_instance_of RideShare::Rider
      rider.name.must_equal "Adah Miller"
    end

    it "Returns nil when given an invalid rider ID" do
      RideShare::Rider.find("TRICKERY!").must_be_nil
    end
  end

  describe "Instance Methods" do
    let(:rider) { RideShare::Rider.new(
      id: 3333,
      name: "Hamlet Hamilton",
      phone_number: "123-4567",
      trips: [
        RideShare::Trip.new(
          id: 1, rider_id: 3333, driver_id: 4, date: "1-2-2017",
          rating: 4, distance: 5, duration: 5, fare: 5
        ),
        RideShare::Trip.new(
          id: 2, rider_id: 3333, driver_id: 5, date: "1-2-2017",
          rating: 3, distance: 5, duration: 5, fare: 5
        ),
        RideShare::Trip.new(
          id: 3, rider_id: 3333, driver_id: 3, date: "1-2-2017",
          rating: 2, distance: 5, duration: 5, fare: 5
        )
      ])
    }

    let(:real_rider) { RideShare::Rider.new(
      id: 3, name: "Marcellus Hoeger", phone_number: "(222) 926-0138"
    )}

    let(:inexperienced_rider) { RideShare::Rider.new(
      id: 4444, name: "Alix Hamilton", phone_number: "(123) 456-7890"
    )}

    describe "#trips" do
      it "Returns an array of trips for a given rider" do
        rider.trips.must_be_instance_of Array
        rider.trips.first.must_be_instance_of RideShare::Trip
      end

      it "Sets trips to empty array for a rider w/o trips" do
        inexperienced_rider.trips.must_equal []
      end
    end

    describe "#drivers" do
      it "Returns an array of past drivers for a given rider" do
        drivers = rider.drivers

        drivers.all? { |driver| driver.class == RideShare::Driver }.must_equal true
        drivers.map { |driver| driver.id }.must_equal [4, 5, 3]
      end

      it "Returns a unique array of drivers" do
        rider_with_duplicate_drivers = RideShare::Rider.find(41)
        number_of_drivers = rider_with_duplicate_drivers.drivers.length
        number_of_unique_drivers = rider_with_duplicate_drivers.drivers.uniq.length

        number_of_drivers.must_equal number_of_unique_drivers
      end

      it "Returns empty array if a rider has no trips" do
        inexperienced_rider.drivers.must_be :empty?
      end
    end

    describe "#cumulative_spending" do
      it "Calculates the total spending for a given rider" do
        rider.cumulative_spending.must_equal 15
      end

      it "Returns 0 for a rider without any spending" do
        inexperienced_rider.cumulative_spending.must_equal 0
      end
    end

    describe "#cumulative_time" do
      it "Calculates the total time spend for a given rider" do
        rider.cumulative_time.must_equal 15
      end

      it "Returns 0 for a rider without any trips" do
        inexperienced_rider.cumulative_time.must_equal 0
      end
    end

  end
end
