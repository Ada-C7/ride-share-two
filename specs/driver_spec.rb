require_relative 'spec_helper'

describe RideShare::Driver do
  describe "#initialize" do
    it "Initializes a driver when given valid parameters" do
      alix = RideShare::Driver.new(id: 6, name: "Alix", vin: "12345678911234567")

      alix.must_be_instance_of RideShare::Driver
      alix.name.must_equal "Alix"
    end

    it "Doesn't create a driver with a missing ID" do
      proc {
        RideShare::Driver.new(name: "Alix", vin: "12345678911234567")
      }.must_raise ArgumentError
    end

    it "Doesn't create a driver with a missing name" do
      proc {
        RideShare::Driver.new(id: 4444, vin: "12345678911234567")
      }.must_raise ArgumentError
    end

    it "Doesn't create a driver with a missing VIN" do
      proc {
        RideShare::Driver.new(id: 4444, name: "Alix")
      }.must_raise ArgumentError
    end

    it "Doesn't allow a driver to be created with an invalid VIN" do
      proc {
        RideShare::Driver.new(id: 1234, name: "Bad Guy", vin: "NOTAVIN")
      }.must_raise ArgumentError
    end

    it "Doesn't create a driver when parameters are set to nil" do
      proc {
        RideShare::Driver.new(id: nil, name: "Alix", vin: "12345678911234567")
      }.must_raise ArgumentError
    end

    it "Doesn't create a driver when parameters are set to empty objects" do
      proc {
        RideShare::Driver.new(id: 5, name: "", vin: "12345678911234567")
      }.must_raise ArgumentError
    end
  end

  describe "self.all" do
    let(:all) { RideShare::Driver.all }

    it "Creates an array of all drivers from the csv file" do
      all.must_be_instance_of Array
      all.first.must_be_instance_of RideShare::Driver
    end

    it "Includes the first driver in the csv file" do
      all.first.name.must_equal "Bernardo Prosacco"
    end

    it "Includes the last driver in the csv file" do
      all.last.name.must_equal "Minnie Dach"
    end
  end

  describe "self.find" do
    it "Returns a driver object when given a valid driver ID" do
      driver = RideShare::Driver.find(94)

      driver.must_be_instance_of RideShare::Driver
      driver.name.must_equal "Arlo Douglas"
    end

    it "Returns nil when given an invalid driver ID" do
      RideShare::Driver.find("TRICKERY!").must_be_nil
    end
  end

  describe "Instance Methods" do
    let(:driver) { RideShare::Driver.new(
      id: 3333,
      name: "Hamlet Hamilton",
      vin: "IAMACAT1233400349",
      trips: [
        RideShare::Trip.new(
          id: 1, driver_id: 3333, rider_id: 1111, date: "1-2-2017",
          rating: 4, distance: 5, duration: 5, fare: 5
        ),
        RideShare::Trip.new(
          id: 2, driver_id: 3333, rider_id: 1111, date: "1-2-2017",
          rating: 5, distance: 5, duration: 5, fare: 5
        ),
        RideShare::Trip.new(
          id: 3, driver_id: 3333, rider_id: 1111, date: "1-2-2017",
          rating: 3, distance: 5, duration: 5, fare: 5
        )
      ])
    }

    let(:real_driver) { RideShare::Driver.new(
      id: 3, name: "Daryl Nitzsche", vin: "SAL6P2M2XNHC5Y656"
    )}

    let(:inexperienced_driver) { RideShare::Driver.new(
      id: 4444, name: "Alix Hamilton", vin: "SALMON12345678901"
    )}

    describe "#trips" do
      it "Returns an array of trips for a given driver" do
        real_driver.trips.must_be_instance_of Array
        real_driver.trips.first.must_be_instance_of RideShare::Trip
      end

      it "Sets trips to empty array for a driver w/o trips" do
        inexperienced_driver.trips.must_equal []
      end
    end

    describe "#average_rating" do
      it "Returns an average rating for a given driver" do
        driver.average_rating.must_equal 4
      end

      it "Returns nil for a driver without ratings" do
        inexperienced_driver.average_rating.must_be_nil
      end

      it "Returns an average rating within the expected range" do
        real_driver.average_rating.must_be :<=, 5
        real_driver.average_rating.must_be :>=, 1
      end
    end

  end
end
