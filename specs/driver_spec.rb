require_relative 'spec_helper.rb'

describe "Drivers" do
  let(:drivers) {RideShare::Driver.all }

  describe "initialize" do
    it "raises an Argument Error if ID is not an Integer" do
      bad_id_hash = { id: "65a", name: "sai", vin: "SALUVSAL3WA67SBPZ"}
      proc {
        RideShare::Driver.new(bad_id_hash)
      }.must_raise ArgumentError
    end

    it "raises an Argument Error if name is not a string" do
      bad_name_hash = { id: 35, name: 874, vin: "SALUVSAL3WA67SBPZ"}
      proc {
        RideShare::Driver.new(bad_name_hash)
      }.must_raise ArgumentError
    end

    it "raises a Bad Vin Error if vin is invalid" do
      bad_vin_hash = { id: 35, name: "sai", vin: "567G"}
      proc {
        RideShare::Driver.new(bad_vin_hash)
      }.must_raise BadVinError
    end
  end

  describe "all" do
    it "returns an Array" do
      drivers.must_be_instance_of Array
    end

    it "everything in the Array is a Driver instance" do
      drivers.each do |driver|
        driver.must_be_instance_of RideShare::Driver
      end
    end

    it "gets everything in the csv" do
      length_check = CSV.readlines("support/drivers.csv").size
       drivers.length.must_equal length_check-1 #to account for header row

    end

    it "gets the first item" do
        drivers[0].name.must_equal "Bernardo Prosacco"
    end

    it "gets the last item"  do
        last_name = drivers.last.name
        check_csv = CSV.readlines("support/drivers.csv")
        check_csv.last[1].must_equal last_name
    end


    it "rescues invalid vin & replaces with #{'0'*17}" do

      #also this happens every.single.time driver.all is called in the tests, so yay for that
      proc {
        RideShare::Driver.all
      }.must_output /.+/

      #bad vin is at driver 101
      ramona = drivers[100]
      ramona.vin.must_equal "0"*17

    end
  end

  describe "add_driver" do
    it "doesn't add a driver who is already in the file" do
      driver1 = {id: 1, name: "Bernardo Prosacco", vin: "WBWSS52P9NEYLVDE9" }
      RideShare::Driver.add_driver driver1
      drivers.last.name.wont_equal "Bernardo Prosacco"
    end
  end

    it "adds a new driver" do
      driver_new = {id: 102, name: "Ada Lovelace", vin: "XF9Z0ST7X18WD41SS" }
      RideShare::Driver.add_driver driver_new
      drivers.last.name.must_equal "Ada Lovelace"
    end

    it "raises error if you try to add bad data" do
      
    end

  describe "find" do

    it "returns an instance of Driver" do
      driver = RideShare::Driver.find 80
      driver.must_be_instance_of RideShare::Driver
      driver.id.must_equal 80
      driver.name.must_equal "Victoria Windler"
    end

    it "returns nil if Driver is not found" do
      driver = RideShare::Driver.find 450
      driver.must_be_instance_of NilClass
    end
  end

  describe "trips" do

    it "returns an Array of Trip objects" do
      driver = drivers[50]
      driver.trips.must_be_instance_of Array
      driver.trips.each do |trip|
        trip.must_be_instance_of RideShare::Trip
      end
      #all elements in Array are Trip instances
    end

    it "returns empty Array if no trips found" do
      no_driver_hash = { id: 607, name: "Ada", vin: "617546450KABGNF98"}
      driver = RideShare::Driver.new(no_driver_hash)
      driver_trips = driver.trips
      driver_trips.must_be_instance_of Array
      driver_trips.length.must_equal 0
    end

    it "finds all trips associated with the driver" do
      #all rider_ids match the rider's rider_id
      #no trips left behind
    end

  end

  describe "rating" do

    it "returns a float" do
      driver = drivers[34]
      driver.trips.length.must_equal 2
      driver.rating.must_be_instance_of Float
      driver.rating.must_be :<=, 5
      driver.rating.must_be :>=, 1
    end
  end
end
