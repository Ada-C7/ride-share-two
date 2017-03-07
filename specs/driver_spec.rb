require_relative 'spec_helper'
require_relative '../lib/driver'

describe RideShare::Driver do
  describe "#initialize" do
    it "Doesn't create a driver with missing parameters" do
      proc {
        RideShare::Driver.new
      }.must_raise ArgumentError
    end

    it "Doesn't allow a driver to be created with an invalid VIN" do
      proc {
        RideShare::Driver.new(id: 1234, name: "Bad Guy", vin: "NOTAVIN")
      }.must_raise ArgumentError
    end
  end

  describe "self.all" do
    before do
      @all = RideShare::Driver.all
    end

    it "Creates an array of all drivers from the csv file" do
      @all.must_be_instance_of Array
      @all.first.must_be_instance_of RideShare::Driver
    end

    it "Includes the first driver in the csv file" do
      @all.first.name.must_equal "Bernardo Prosacco"
    end

    it "Includes the last driver in the csv file" do
      @all.last.name.must_equal "Minnie Dach"
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
    before do
      @driver = RideShare::Driver.new(id: 18, name: "Ms. Kamille Wyman", vin: "SUA4ALKJ0YRFMASB2")
      # tr  dr  rd   date     rating
      # 228	18	19	 10/10/15	5
      # 277	18	87	 9/21/15	3
      # 425	18	257	 1/9/16	  4
      # 466	18	135	 12/17/16	4
      # 598	18	7	   9/16/15	1
    end

    describe "#trips" do
      it "Returns an array of trips for a given driver" do
        trips = @driver.trips

        trips.must_be_instance_of Array
        trips.first.must_be_instance_of RideShare::Trip
      end

      it "Returns empty array for a driver without any trips" do
        fake_driver = RideShare::Driver.new(id: 4444, name: "Alix Hamilton", vin: "SALMON12345678901")
        fake_driver.trips.must_be :empty?
      end
    end

    describe "#average_rating" do
      it "Returns an average rating for a given driver" do
        @driver.average_rating.must_equal 3.4
      end

      it "Returns nil for a driver without ratings" do
        fake_driver = RideShare::Driver.new(id: 4444, name: "Alix Hamilton", vin: "SALMON12345678901")
        fake_driver.average_rating.must_be_nil
      end
    end

  end
end
