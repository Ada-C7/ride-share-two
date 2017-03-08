require_relative 'spec_helper'


describe "Driver" do
  let(:drivers) { RideShare::Driver.all }

  describe "Driver#initialize" do
    let(:vindiesel) { RideShare::Driver.new(777, "Vin Diesel", "FASTNFURIOUS00007") }

    it "Driver has a name, ID, and VIN" do
      vindiesel.id.must_equal 777
      vindiesel.name.must_equal "Vin Diesel"
      vindiesel.vin.must_equal "FASTNFURIOUS00007"
    end

    it "raises error if Driver's ID or name are invalid input" do
      proc {
        RideShare::Driver.new("VD", "Vin Diesel", "fastnfurious00007")
      }.must_raise ArgumentError
      proc {
        RideShare::Driver.new(777, ["Vin Diesel"], "FASTNFURIOUS00007")
      }.must_raise ArgumentError
    end

    it "raises error if VIN has invalid characters or wrong length" do
      proc {
        RideShare::Driver.new(777, "Vin Diesel", "FASTNFURIOUS@@!!7")
      }.must_raise InvalidVinError
      proc {
        RideShare::Driver.new(777, "Vin Diesel", "FASTNFURIOUS007")
      }.must_raise InvalidVinError
    end

    it "accepts lowercase letters in VIN" do
      vindiesel = RideShare::Driver.new(777, "Vin Diesel", "fastnfurious00007")
      vindiesel.vin.must_equal "FASTNFURIOUS00007"
    end

  end


  describe "Driver#all" do

    it "returns an array of Driver instances" do
      drivers.must_be_kind_of Array
      drivers.all? do | driver |
        driver.must_be_instance_of RideShare::Driver
      end
    end

    it "returns array with the correct number of Drivers from csv" do
      drivers.length.must_equal 100
    end

    it "Driver instances match what's in the csv file" do
      index = 0
      CSV.read("support/drivers.csv", headers: true) do |line|
        drivers[index].id.must_equal line[0].to_i
        drivers[index].name.must_equal line[1]
        drivers[index].vin.must_equal line[2]
        index += 1
      end
    end

  end


  describe "Driver#find" do

    it "raises an error if a non-integer is provided" do
      proc {
        RideShare::Driver.find("first driver")
      }.must_raise ArgumentError
    end

    it "returns an instance of Driver with matching driver ID" do
      RideShare::Driver.find(1).must_be_instance_of RideShare::Driver
    end

    it "can find any driver based on a randomly generated " do
      test_id = rand(1..100)
      driver_check = drivers[test_id - 1].id
      driver = RideShare::Driver.find(test_id)
      10.times { expect(driver.id).must_equal driver_check }
    end

    it "returns nil if account doesn't exist" do
      RideShare::Driver.find(383).must_be_nil
    end

  end


  describe "Driver#trips and #ratings" do
    let(:shakira) { RideShare::Driver.new(16, "Shakira Stamm", "SALUVSAL3WA67SBPZ") }

    it "returns an array whose length matches the number of Driver's trips" do
      shakira.trips.must_be_kind_of Array
      shakira.trips.length.must_equal RideShare::Trip.find_by_driver(16).length
    end

    it "returns an array of all Trip instances" do
      shakira.trips.all? do | trip |
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "returns correct average rating for a Driver" do
      # (2 + 5 + 1 + 2 + 4 + 1) / 6
      shakira.average_rating.must_equal 2.5
    end

  end

end
