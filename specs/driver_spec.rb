require_relative 'spec_helper'

describe "RideShare::Driver" do
  let(:all_trips) { RideShare::Trip.all }
  let(:all_riders) { RideShare::Rider.all }
  let(:all_drivers) { RideShare::Driver.all }

  before do
    all_trips
    all_riders
    all_drivers
  end

  describe "Driver#initialize" do
    let(:driver9) { RideShare::Driver.new(id: "9", name: "Simone Hackett", vin: "4RA34A5K3YPN8H5P4") }
    let(:no_vin) { RideShare::Driver.new(id: "87", name: "Tamiko Terada") }

    it "creates a new instance of trip" do
      driver9.must_be_instance_of RideShare::Driver
    end

    it "passes in driver data correctly" do
      #9,Simone Hackett,4RA34A5K3YPN8H5P4
      driver9.id.must_equal 9
      driver9.name.must_equal "Simone Hackett"
      driver9.vin.must_equal "4RA34A5K3YPN8H5P4"
    end

    it "throws an ArgumentError if the vin is invalid" do
      proc {
        RideShare::Driver.new(id: "9", name: "Simone Hackett", vin: "4RA34A5K3YPN8H5P40000000")
      }.must_raise ArgumentError
    end

    it "can create a new driver with a missing vin" do
      no_vin.vin.must_equal nil
    end
  end

  describe "Driver#all" do

    it "returns an array" do
      all_drivers.must_be_kind_of Array
    end

    it "each returned element is a Driver instances" do
      all_drivers.each do |each_driver|
        each_driver.must_be_instance_of RideShare::Driver
      end
    end

    it "returns the correct number of elements" do
      all_drivers.length.must_equal 100 # rows in CSV file
    end

    it "correctly reads in the first row of the CSV file" do
      # last row of data: 1,Bernardo Prosacco,WBWSS52P9NEYLVDE9
      all_drivers[0].id.must_equal 1
      all_drivers[0].name.must_equal "Bernardo Prosacco"
      all_drivers[0].vin.must_equal "WBWSS52P9NEYLVDE9"
    end

    it "correctly reads in the last row of the CSV file" do
      # last row of data: 100,Minnie Dach,XF9Z0ST7X18WD41HT
      all_drivers[-1].id.must_equal 100
      all_drivers[-1].name.must_equal "Minnie Dach"
      all_drivers[-1].vin.must_equal "XF9Z0ST7X18WD41HT"
    end
  end

  describe "Driver#find" do
    let(:driver_found) { RideShare::Driver.find(31) }

    it "return value is a Driver instance" do
      driver_found.must_be_instance_of RideShare::Driver
    end

    it "finds the correct instance of Driver" do
      driver_found.id.must_equal 31
      driver_found.name.must_equal "Sheila VonRueden"
      driver_found.vin.must_equal "KPH9RLSZ9YKNVMGH2"
    end

    it "will not find a nonexistent Driver" do
      RideShare::Driver.find(999)
    end
  end

  describe "Driver#Trips" do
    let (:driver9_trips) { RideShare::Driver.new({id: "9"}).trips }

    it "returns value as an Array" do
      driver9_trips.must_be_kind_of Array
    end

    it "first element is an instance of Trip" do
      driver9_trips[0].must_be_instance_of RideShare::Trip
    end

    it "last element is a Trip associated with the expected driver" do
      driver9_trips[-1].driver_id.must_equal 9
    end
  end

  describe "Driver#avg_rating" do
    let (:driver9_avg) { RideShare::Driver.new(id: "9").avg_rating }

    it "returns value as a Float" do
      driver9_avg.must_be_kind_of Float
    end

    it "return value is min 0, max 5" do
      driver9_avg.must_be :<=, 5
      driver9_avg.must_be :>=, 0
    end
  end
end
