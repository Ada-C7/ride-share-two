require_relative 'spec_helper'

describe "RideShare::Driver" do

  let(:new_driver) { RideShare::Driver.new("Kelsey", 1234, "234235234345") }
  let(:new_driver2) { RideShare::Driver.new("Kelsey", 1234, "E98731") }


  describe "RideShare::Driver#iniitalize" do

    it "A new driver can be initialized with a name, ID, and vin" do
      new_driver.must_be_instance_of RideShare::Driver
    end

    it "If driver has invalid vin, will default to '00000000000000000'" do
      new_driver2.vin.must_equal "00000000000000000"
    end

  end


  describe "RideShare::Driver#trips" do

    let (:list_trips) { RideShare::Driver.find(17).trips }

    it "Returns an array" do
      list_trips.must_be_instance_of Array
    end

    it "All objects in the array are RideShare::Trip" do
      list_trips.each do | trip |
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "The driver_id of each trip matches the given argument" do
      list_trips.each do | trip |
        trip.driver_id.must_equal 17
      end
    end

  end


  describe "RideShare::Driver#avg_rating" do

    # let (:avg) { RideShare::Driver.find(17).avg_rating}
    #
    # it "Returns an integer" do
    #    avg.must_be_kind_of Integer
    # end

  end


  describe "RideShare::Driver#self.all" do

    let (:first_driver) { RideShare::Driver.all.first }
    let (:last_driver) { RideShare::Driver.all.last }
    let (:random_driver) { RideShare::Driver.all[36] }

    it "Initializes first line from drivers.csv as a new RideShare::Driver instance" do
      first_driver.id.must_equal 0
      first_driver.name.must_equal "name"
      first_driver.vin.must_equal "00000000000000000"
    end

    it "Ititializes last line from drivers.csv as a new RideShare::Driver instance" do
      last_driver.id.must_equal 100
      last_driver.name.must_equal "Minnie Dach"
      last_driver.vin.must_equal "XF9Z0ST7X18WD41HT"
    end

    it "Ititializes random line from drivers.csv as a new RideShare::Driver instance" do
      random_driver.id.must_equal 36
      random_driver.name.must_equal "Mr. Marcelina Jenkins"
      random_driver.vin.must_equal "WD3VLLK2X04HF50PL"
    end

  end


  describe "RideShare::Driver#self.find" do

    let (:found_driver) { RideShare::Driver.find(17) }

    it "Returns a RideShare::Driver" do
      found_driver.must_be_instance_of RideShare::Driver
    end

    it "Is able to find random driver using the driver's ID" do
      found_driver.name.must_equal "Federico Bins V"
    end

    it "Will raise an argument error if Driver ID is not found" do
      proc { RideShare::Driver.find(105) }.must_raise ArgumentError
    end

  end

end
