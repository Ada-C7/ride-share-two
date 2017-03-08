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
      it "return an object of Driver class" do
        driver.find_driver(1).must_be_instance_of RideShare::Driver
      end

      it "Returns the correct driver's information" do
        driver.find_driver(100).name_d.must_equal last_driver.name_d
        driver.find_driver(1).id_d.must_equal first_driver.id_d
        driver.find_driver(56).vin.must_equal random_driver.vin
      end
    end#end of self.find_driver method

    describe "Driver#self.find_drivers_trips" do
      it "return an Array" do
        driver.find_drivers_trips(1).must_be_instance_of Array
      end

      it "return an Array filled with objects from Trip class" do
        driver.find_drivers_trips(1)[0].must_be_instance_of RideShare::Trip
        driver.find_drivers_trips(1).last.must_be_instance_of RideShare::Trip
      end
    end#end of find_drivers_trips class method

    describe "Driver#drivers_rating" do
      it "Returns an float" do
        first_driver.drivers_rating(1).must_be_instance_of Float
        random_driver.drivers_rating(56).must_be_instance_of Float
      end
    end
  end#end of Driver class

  describe "Rider class" do
    let(:first_rider) {RideShare::Rider.new(1, 'Nina Hintz Sr.', '560.815.3059')}
    let(:last_rider) {RideShare::Rider.new(300, 'Miss Isom Gleason', '791-114-8423 x70188')}
    let(:random_rider) {RideShare::Rider.new(169, 'Jaclyn Upton', '458-797-3216')}
    let(:rider) {RideShare::Rider}

    describe "Rider#initialize" do
      it "Takes an ID, name, and a phone_number" do
        id_r = 17
        name_r = "laura"
        phone_number = '87913209234'
        rider_ins = rider.new(id_r, name_r, phone_number)

        rider_ins.must_respond_to :id_r
        rider_ins.id_r.must_equal id_r

        rider_ins.must_respond_to :name_r
        rider_ins.name_r.must_equal name_r

        rider_ins.must_respond_to :phone_number
        rider_ins.phone_number.must_equal phone_number
      end
      it "Creater a new instance of Rider class" do
        random_rider.class.must_equal RideShare::Rider
      end

      it "Raises ArgumentError if id is not an integer" do
        proc {
          rider.new("1", "Laura", "213981238jkds")
        }.must_raise ArgumentError
      end

      it "Raises ArgumentError if name is not a string" do
        proc {
          rider.new(43, 42, "RF5D1APK7B8SDK1HR")
        }.must_raise ArgumentError
      end

      it "Raises ArgumentError if phone_number is not a string" do
        proc {
          rider.new(68, "Laura", 20626599263)
        }.must_raise ArgumentError
      end
    end#end of Rider#initialize

    describe "Rider#self.all" do
      it "returns an array" do
        rider.all.must_be_instance_of Array
      end

      it "Contain the first and last rider nformation" do
        rider.all[0].id_r.must_equal first_rider.id_r
        rider.all[0].name_r.must_equal first_rider.name_r
        rider.all[0].phone_number.must_equal first_rider.phone_number
        rider.all[299].id_r.must_equal last_rider.id_r
        rider.all[299].name_r.must_equal last_rider.name_r
        rider.all[299].phone_number.must_equal last_rider.phone_number
      end

      it "Contain a random rider nformation" do
        rider.all[168].id_r.must_equal random_rider.id_r
        rider.all[168].name_r.must_equal random_rider.name_r
        rider.all[168].phone_number.must_equal random_rider.phone_number
      end
    end#end of method all

  end#end of the Rider class
end#end of the Module RideShare
