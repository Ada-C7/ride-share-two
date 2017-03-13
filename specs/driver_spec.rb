require_relative 'spec_helper.rb'

describe RideShare::Driver do
  before do
    @my_driver = RideShare::Driver.new(id = 5, name = "Verla Marquardt", vin = "TAMLE35L3MAYRV1JD")
  end
  describe "initialize" do
    it "takes an id, name, and VIN" do
      id = 5
      name = "Verla Marquardt"
      vin = "TAMLE35L3MAYRV1JD"
      @my_driver.must_be_instance_of RideShare::Driver
      @my_driver.id.must_equal id
      @my_driver.name.must_equal name
      @my_driver.vin.must_equal vin
      @my_driver.vin.length.must_equal 17
    end
  end

  describe "self.all" do
    before do
      @all_trips = RideShare::Driver.all
    end
    it "checks for an array" do
      @all_trips.must_be_instance_of Array
    end
    it "checks every array is instance of Driver" do
      @all_trips.each do |driver|
        driver.must_be_instance_of RideShare::Driver
      end
    end
    it "checks correct length of csv driver file" do
      @all_trips.length.must_equal 100
    end
  end

  describe "self.find" do
    it "checks for find method" do
      @my_driver.must_be_instance_of RideShare::Driver
    end
    it "check id is 5" do
      @my_driver.id.must_equal 5
    end
    it "check name is Verla Marquardt" do
      @my_driver.name.must_equal "Verla Marquardt"
    end
    it "check vin matches" do
      @my_driver.vin.must_equal "TAMLE35L3MAYRV1JD"
    end

    it "checks that argument error is being raised if an invalid driver id is given" do
      proc { RideShare::Driver.find(900)
      }.must_raise ArgumentError
    end
  end

  describe "trip_instances_for_driver" do
    it "checks it is of trip class" do
      @my_driver.must_be_instance_of RideShare::Driver
    end
    it "check that Array is being returned" do
      @my_driver.trip_instances_for_driver.must_be_instance_of Array
    end
    it "will raise argument error if id given doesn't match anything" do
      proc {
        RideShare::Trip.find_trips_of_driver(900)
      }.must_raise ArgumentError
    end
  end

  describe "rating" do
    it "checks integer is being returned" do
      @my_driver.rating.must_be_instance_of Integer
    end
  end

end
