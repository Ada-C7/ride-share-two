require_relative 'spec_helper'

describe "Driver Class" do

  let(:ada) { RideShare::Driver.new(name: 'Ada', driver_id: 2, vin: 12345338303493234 )}

  describe "initialize method" do

    it "Instantiates a new instance of Driver class" do
      ada.must_be_instance_of RideShare::Driver
    end

    it "Stored data must match what was passed as an argument" do
      ada.name.must_equal "Ada"
      ada.driver_id.must_equal 2
      ada.vin.must_equal 12345338303493234
    end
  end #end of initialze method


  describe "self.all method" do

    let(:my_drivers) {RideShare::Driver::all}

    it "Driver.all returns array" do

      my_drivers.class.must_equal Array
    end

    it "First and Last drivers are instansces of Driver Class" do

      my_drivers.first.must_be_instance_of RideShare::Driver
      my_drivers.last.must_be_instance_of RideShare::Driver
    end

    it "The number of drivers is correct" do
      my_drivers.length.must_equal CSV.read("support/drivers.csv").count
    end

    it "The Id, name and vin number matches the first account " do

      index = 1

      my_drivers[index].driver_id.must_equal 1
      my_drivers[index].name.must_equal "Bernardo Prosacco"
      my_drivers[index].vin.must_equal "WBWSS52P9NEYLVDE9"
    end

    it "The Id, name and vin number matched the last account" do

      my_drivers.last.driver_id.must_equal 100
      my_drivers.last.name.must_equal "Minnie Dach"
      my_drivers.last.vin.must_equal "XF9Z0ST7X18WD41HT"
    end

  end #end of self.all

describe "self.find(id)" do

let(:my_drivers) {RideShare::Driver::all}

it "Returns a driver that exists" do

my_driver = RideShare::Driver::find(5)

my_driver.driver_id.must_equal 5
#my_driver.id.must_equal CSV.read("support/drivers.csv")[6][2]
# my_driver.name.must_equal "Verla Marquardt"
# my_driver.vin.must_equal "TAMLE35L3MAYRV1JD"


end


end #end of self.find




  xdescribe "trips_taken" do

    it "Trips taken must be an array" do
      ada.trips_taken.must_be_instance_of Array
    end

  end #end of trips taken
end
