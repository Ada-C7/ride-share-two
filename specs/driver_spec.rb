require_relative 'spec_helper'

describe "RideShare Module" do

  describe "Driver class" do
    let(:first_driver) {RideShare::Driver.new(1, 'Bernardo Prosacco', 'WBWSS52P9NEYLVDE9')}
    let(:last_driver) {RideShare::Driver.new(100, 'Minnie Dach', 'XF9Z0ST7X18WD41HT')}
    let(:random_driver) {RideShare::Driver.new(56, 'Adriel Swift', 'RF5D1APK7B8SDK1HR')}
    let(:driver) {RideShare::Driver}

    describe "Driver#initialize" do
      it "Takes an ID, name, and a vin" do
        id_d = 17
        name_d = "laura"
        vin = "RF5D1APK7B8SDK1HR"
        driver_ins = driver.new(id_d, name_d, vin)

        driver_ins.must_respond_to :id_d
        driver_ins.id_d.must_equal id_d

        driver_ins.must_respond_to :name_d
        driver_ins.name_d.must_equal name_d

        driver_ins.must_respond_to :vin
        driver_ins.vin.must_equal vin
      end

      it "Creater a new instance of Driver class" do
        random_driver.class.must_equal RideShare::Driver
      end

      it "Raises ArgumentError if id is not an integer" do
        proc {
          driver.new("1", "Laura", "213981238jkds")
        }.must_raise ArgumentError
      end

      it "Raises ArgumentError if name is not a string" do
        proc {
          driver.new(43, 42, "RF5D1APK7B8SDK1HR")
        }.must_raise ArgumentError
      end

      it "Raises ArgumentError if vin does not have 17 characters" do
        proc {
          driver.new(68, "Laura", "213981238jkds")
        }.must_raise ArgumentError
      end
    end#end of Driver#initialize

    describe "Driver#all" do
      it "returns an array" do
        driver.all.must_be_instance_of Array
      end

      it "Contain the first and last driver nformation" do
        driver.all[0].id_d.must_equal first_driver.id_d
        driver.all[0].name_d.must_equal first_driver.name_d
        driver.all[0].vin.must_equal first_driver.vin
        driver.all[99].id_d.must_equal last_driver.id_d
        driver.all[99].name_d.must_equal last_driver.name_d
        driver.all[99].vin.must_equal last_driver.vin
      end

      it "Contain a random driver nformation" do
        driver.all[55].id_d.must_equal random_driver.id_d
        driver.all[55].name_d.must_equal random_driver.name_d
        driver.all[55].vin.must_equal random_driver.vin
      end
    end#end of method all

    describe "Driver#self.find_driver" do
      # it "return an object of String class" do
      #   driver.find_driver(1).must_be_instance_of String
      # end
      #
      # it "Returns driver's name" do
      #   driver.find_driver(1).must_equal 'Bernardo Prosacco'
      #   driver.find_driver(100).must_equal 'Minnie Dach'
      #   driver.find_driver(56).must_equal 'Adriel Swift'
      # end

      it "Returns the correct driver's information" do
        driver.find_driver(100).name_d.must_equal last_driver.name_d
        driver.find_driver(1).id_d.must_equal first_driver.id_d
        driver.find_driver(56).vin.must_equal random_driver.vin
      end
    end#end of self.find_driver method

    describe "Driver#find_drivers_trips" do
      it "return an Array" do
        first_driver.find_drivers_trips.must_be_instance_of Array
      end

      it "return an Array filled with objects from Trip class" do
        first_driver.find_drivers_trips.first.must_be_instance_of RideShare::Trip
        random_driver.find_drivers_trips.last.must_be_instance_of RideShare::Trip
      end
    end#end of find_drivers_trips class method

    describe "Driver#drivers_rating" do
      it "Returns an float" do
        first_driver.drivers_rating(1).must_be_instance_of Float
        random_driver.drivers_rating(56).must_be_instance_of Float
      end

      it "returns the right average" do
        first_driver.drivers_rating(1).must_equal 2.3
      end
      # let(:first_driver) {RideShare::Driver.new(1, 'Bernardo Prosacco', 'WBWSS52P9NEYLVDE9')}
      # let(:last_driver) {RideShare::Driver.new(100, 'Minnie Dach', 'XF9Z0ST7X18WD41HT')}
      # let(:random_driver) {RideShare::Driver.new(56, 'Adriel Swift', 'RF5D1APK7B8SDK1HR')}
      # let(:driver) {RideShare::Driver}


    end
  end#end of Driver class
end#end of the Module RideShare
