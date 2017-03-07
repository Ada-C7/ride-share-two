require_relative 'spec_helper.rb'

describe "RideShare::Driver" do
  before do
    #9,Simone Hackett,4RA34A5K3YPN8H5P4
    @driver = RideShare::Driver.new({id: "9", name: "Simone Hackett", vin: "4RA34A5K3YPN8H5P4"})
  end

  describe "Driver#initialize" do
    it "creates a new instance of trip" do
      @driver.must_be_instance_of RideShare::Driver
    end
    it "passes in the driver id" do
      @driver.id.must_equal "9"
    end
    it "passes in the driver name" do
      @driver.name.must_equal "Simone Hackett"
    end
    it "passes in the vin" do
      @driver.vin.must_equal "4RA34A5K3YPN8H5P4"
    end
    it "can create a new driver with a missing vin" do
      no_vin = RideShare::Driver.new({id: "87", name: "Tamiko Terada"})
      no_vin.vin.must_equal nil
    end
  end

  describe "Driver#all" do
    before do
      @drivers = RideShare::Driver.all
    end

    it "returns an array" do
      @drivers.must_be_kind_of Array
    end
    it "each returned element is a Driver instances" do
      @drivers.each do |object|
        object.must_be_instance_of RideShare::Driver
      end
    end
    it "returns the correct number of elements" do
      @drivers.length.must_equal 100 # rows in CSV file
    end
    it "correctly reads in the first row of the CSV file" do
      # last row of data: 1,Bernardo Prosacco,WBWSS52P9NEYLVDE9
      @drivers[0].id.must_equal "1"
      @drivers[0].name.must_equal "Bernardo Prosacco"
      @drivers[0].vin.must_equal "WBWSS52P9NEYLVDE9"
    end
    it "correctly reads in the last row of the CSV file" do
      # last row of data: 100,Minnie Dach,XF9Z0ST7X18WD41HT
      @drivers[-1].id.must_equal "100"
      @drivers[-1].name.must_equal "Minnie Dach"
      @drivers[-1].vin.must_equal "XF9Z0ST7X18WD41HT"
    end
  end

  describe "Driver#find" do
    before do
      # 31,Sheila VonRueden,KPH9RLSZ9YKNVMGH2
      @drivers = RideShare::Driver.all
      @driver_found = RideShare::Driver.find("31")
    end
    it "return value is a Driver instance" do
      @driver_found.must_be_instance_of RideShare::Driver
    end
    # it "displays a message if the Driver is not found" do
    #   @no_driver = RideShare::Driver.find("9999")
    # end
    it "finds the correct instance of Driver" do
      @driver_found.id.must_equal "31"
      @driver_found.name.must_equal "Sheila VonRueden"
      @driver_found.vin.must_equal "KPH9RLSZ9YKNVMGH2"
    end
  end

  describe "Driver#Trips" do
    it "returns value an an Array" do
      RideShare::Trip.all
      driver = RideShare::Driver.new({id: "9", name: "Simone Hackett", vin: "4RA34A5K3YPN8H5P4"})
      driver.trips.must_be_kind_of Array
    end
    it "first element is an instance of Trip" do
      RideShare::Trip.all
      driver = RideShare::Driver.new({id: "9", name: "Simone Hackett", vin: "4RA34A5K3YPN8H5P4"})
      driver.trips[0].must_be_instance_of RideShare::Trip
    end
    it "last element is a Trip associated with the expected driver" do
      RideShare::Trip.all
      driver = RideShare::Driver.new({id: "9", name: "Simone Hackett", vin: "4RA34A5K3YPN8H5P4"})
      driver.trips[-1].driver_id.must_equal "9"
    end
  end

  describe "Driver#avg_rating" do
    it "returns value as a Float" do
      RideShare::Trip.all
      driver = RideShare::Driver.new({id: "9", name: "Simone Hackett", vin: "4RA34A5K3YPN8H5P4"})
      driver.avg_rating.must_be_kind_of Float
    end
    it "return value is min 0, max 5" do
      RideShare::Trip.all
      driver = RideShare::Driver.new({id: "9", name: "Simone Hackett", vin: "4RA34A5K3YPN8H5P4"})
      rider.avg_rating.must_be :<= 5
      rider.avg_rating.must_be :>= 0
    end
    # it "last Driver is associated with the Rider through a Trip" do
    # skip
    #   RideShare::Trip.all
    #   driver = RideShare::Driver.new({id: "9", name: "Simone Hackett", vin: "4RA34A5K3YPN8H5P4"})
    #   # find out how to test this
    # end
  end
end
