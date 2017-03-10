require_relative 'spec_helper'

xdescribe "Driver Class" do

  let(:ada) { Carmmunity::Driver.new(name: 'Ada', driver_id: 2, vin: 12345338303493234 )}

  describe "Instance Methods" do
    xdescribe "initialize method" do

      it "Instantiates a new instance of Driver class" do
        ada.must_be_instance_of Carmmunity::Driver
      end

      it "Stored data must match what was passed as an argument" do
        ada.name.must_equal "Ada"
        ada.driver_id.must_equal 2
        ada.vin.must_equal 12345338303493234
      end
    end #end of initialze method


    describe "trips_taken" do

      let(:driver) {Carmmunity::Driver::find(12)}
      let(:trips) {driver.trips_taken}

      it "Trips taken must be an array" do

        driver.trips_taken.must_be_instance_of Array
      end

      it "returns more than one trip instance" do
        trips.length.must_be :>, 1
      end

      it "The driver id number matches the trip's driver id " do

        trips.map{|trip| trip.driver_id}.must_include  driver.driver_id

      end

      it "Returns the correct number of trips taken " do
        skip
        trips.length.must_equal 8
      end

      it "Returns the correct trip infromation" do
        trip = trips.first
        trip.driver_id.must_equal     12
        trip.rating.must_equal        1
        trip.rider_id.must_equal      237
        trip.trip_id.must_equal       12
        trip.date.must_equal          "2016-08-21"
      end
    end #end of trips taken

    describe "average_rating method" do

      let(:driver) {Carmmunity::Driver::find(12)}

      it " Returns an integer " do
        driver.average_rating.must_be_instance_of Integer
      end

      it "returns the correct average_rating" do
        driver.average_rating.must_equal 2
      end

    end #end of average_rating
  end #end of instance methods


  xdescribe " Class Methods " do

    let(:my_drivers) {Carmmunity::Driver::all}

    let(:file_row) {CSV.read("support/drivers.csv")}


    describe " self.all method " do


      it " Driver.all returns array " do

        my_drivers.class.must_equal Array
      end

      it " First and Last drivers are instansces of Driver Class " do

        my_drivers.first.must_be_instance_of Carmmunity::Driver
        my_drivers.last.must_be_instance_of Carmmunity::Driver
      end

      it " The number of drivers is correct " do

        my_drivers.length.must_equal CSV.read("support/drivers.csv").count
      end

      it " The Id, name and vin number matches the first account " do

        index = 1
        #add loop
        my_drivers[index].driver_id.must_equal 1
        my_drivers[index].name.must_equal "Bernardo Prosacco"
        my_drivers[index].vin.must_equal "WBWSS52P9NEYLVDE9"
      end

      it " The Id, name and vin number matches the last account " do

        my_drivers.last.driver_id.must_equal 100
        my_drivers.last.name.must_equal "Minnie Dach"
        my_drivers.last.vin.must_equal "XF9Z0ST7X18WD41HT"
      end
    end #end of self.all


    describe " self.find(id) " do


      it " Returns a driver that exists " do

        my_driver = Carmmunity::Driver::find(5)

        my_driver.name.must_equal my_drivers[5].name

        my_driver.driver_id.must_equal 5

        my_driver.vin.must_equal file_row[5][2]

        my_driver.vin.must_equal "TAMLE35L3MAYRV1JD"
      end


      it " Can find the last driver in the CSV file " do

        my_driver = Carmmunity::Driver::find(100)

        my_driver.name.must_equal my_drivers.last.name

        my_driver.driver_id.must_equal my_drivers.last.driver_id
      end

      it " Can find the First driver in the CSV file " do

        my_driver = Carmmunity::Driver::find(1)

        my_driver.name.must_equal my_drivers[1].name

        my_driver.driver_id.must_equal my_drivers[1].driver_id
      end

      it " Only accepts integers in seatch criteria " do
        skip
      end

      it " Outputs message if Driver could not be found " do
        skip
      end
    end #end of self.find

  end #end of class methods
end
