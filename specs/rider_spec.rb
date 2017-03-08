require_relative 'spec_helper'

describe "RideShare Module" do
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

    describe "Rider#self.find_rider" do
      it "Returns the correct 's information" do
        rider.find_rider(300).name_r.must_equal last_rider.name_r
        rider.find_rider(1).id_r.must_equal first_rider.id_r
        rider.find_rider(169).phone_number.must_equal random_rider.phone_number
      end
      # it "return an object of String class" do
      #   rider.find_rider(1).must_be_instance_of String
      # end
      #
      # it "Returns rider's name" do
      #   rider.find_rider(1).must_equal 'Nina Hintz Sr.'
      #   rider.find_rider(300).must_equal 'Miss Isom Gleason'
      #   rider.find_rider(169).must_equal 'Jaclyn Upton'
      # end
    end#end of self.find_rider method

    describe "Rider#find_riders_trips" do
      it "return an Array" do
        first_rider.find_riders_trips.must_be_instance_of Array
      end

      it "return an Array filled with objects from Trip class" do
        first_rider.find_riders_trips.first.must_be_instance_of RideShare::Trip
        random_rider.find_riders_trips.last.must_be_instance_of RideShare::Trip
      end
    end#end of find_riders_trips method

    describe "Rider#riders_drivers" do
      it "returns an Array filled with Driver instances" do
        first_rider.rider_drivers.must_be_instance_of Array
        first_rider.rider_drivers[0].must_be_instance_of RideShare::Driver
        # random_rider.rider_drivers.last.must_be_instance_of String
      end

      it "In the returned array there is/are the names of the drivers" do
        first_rider.rider_drivers[0].name_d.must_equal 'Ms. Winston Emard'
        first_rider.rider_drivers[1].name_d.must_equal 'Federico Bins V'
        random_rider.rider_drivers.first.name_d.must_equal 'Dr. Kenton Berge'
      end
    end
  end#end of the Rider class
end#end of the Module RideShare
