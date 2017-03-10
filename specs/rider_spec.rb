require_relative 'spec_helper'

xdescribe "Rider Class" do

  describe "Instance Methods" do

    xdescribe "initialize method" do

      let(:driver_test) { Carmmunity::Rider.new(
                name:   'Ada',
            rider_id:   22,
        phone_number:   '909-555-1234' )}

      it "Instantiates a new instance of Rider class" do
        driver_test.must_be_instance_of     Carmmunity::Rider
      end

      it "Rider data matches " do

        driver_test.name.must_equal             "Ada"
        driver_test.rider_id.must_equal         22
        driver_test.phone_number.must_equal     '909-555-1234'
      end
    end #end of initialze method


    describe "trips_taken" do

      let(:rider) {Carmmunity::Rider::find(5)}
      let(:trips) {rider.trips_taken}

      it "Trips taken must be an array" do
        rider.trips_taken.must_be_instance_of Array
      end

      it "The rider id number matches the rider id in the trip information" do

        trips.map{|trip| trip.rider_id}.must_include  rider.rider_id

      end

      it "Returns the correct number of trips taken " do
        skip
        trips.length.must_equal 1
      end

      it "Returns correct trip infromation" do

      trip = trips.first

      trip.driver_id.must_equal     12
      trip.rating.must_equal        1
      trip.rider_id.must_equal      5
      trip.trip_id.must_equal       551
      trip.date.must_equal          "2016-12-09"
      end

      it "returns more than one trip" do
        rider_test = Carmmunity::Rider.find(41)

        rider_test.trips_taken.length.must_be :>, 1
      end

      it "returns message if no trips can be found" do
        skip
      end


    end #end of trips taken

    xdescribe "previous_drivers method" do
      let(:rider) {Carmmunity::Rider::find(41)}

      it " Returns an array " do
        rider.previous_drivers.must_be_instance_of Array
      end

      it "returns a previous_driver" do

        driver = rider.previous_drivers.first
        driver.driver_id.must_equal 94
      end

      it "returns more than one driver" do
        rider.previous_drivers.length.must_be :>, 1
      end

      it "returns a the correct number of drivers" do

        rider.previous_drivers.length.must_equal 3
      end

      it "returns message if no trips have been taken" do
        skip
      end

    end #end of previous_riders
  end #end of instance methods


  xdescribe " Class Methods " do

    let(:my_riders) {Carmmunity::Rider::all}

    let(:rider_data) {CSV.read("support/riders.csv")}


    describe " self.all method " do


      it " Rider.all returns array " do

        my_riders.class.must_equal Array
      end

      it " First and Last riders are instansces of Rider Class " do

        my_riders.first.must_be_instance_of Carmmunity::Rider
        my_riders.last.must_be_instance_of Carmmunity::Rider
      end

      it " The number of riders is correct " do

        my_riders.length.must_equal CSV.read("support/riders.csv").count
      end

      it " The Id, name and phone number matches the first account " do

        index = 1
        id = 1
        name = "Nina Hintz Sr."
        phone_num = "560.815.3059"

        #add loop
        my_riders[index].rider_id.must_equal id
        my_riders[index].name.must_equal name
        my_riders[index].phone_number.must_equal phone_num
      end

      it " The Id, name and phone_number number matches the last account " do

        id = 300
        name = "Miss Isom Gleason"
        phone_num = "791-114-8423 x70188"

        my_riders.last.rider_id.must_equal id
        my_riders.last.name.must_equal name
        my_riders.last.phone_number.must_equal phone_num
      end
    end #end of self.all


    describe " self.find(id) " do


      it " Returns a rider that exists " do
        #trying to figure out which format is less dependent than that other
        my_rider = Carmmunity::Rider::find(5)

        id = 5
        #name = "Elmore Heller MD"
        phone_num = "1-297-522-2558 x431"


        my_rider.name.must_equal my_riders[5].name
        my_rider.rider_id.must_equal id
        my_rider.phone_number.must_equal rider_data[5][2]
        my_rider.phone_number.must_equal phone_num
      end


      it " Can find the last rider in the CSV file " do

        my_rider = Carmmunity::Rider::find(300)

        my_rider.name.must_equal my_riders.last.name

        my_rider.rider_id.must_equal my_riders.last.rider_id
      end

      it " Can find the First rider in the CSV file " do

        my_rider = Carmmunity::Rider::find(1)

        my_rider.name.must_equal my_riders[1].name

        my_rider.rider_id.must_equal my_riders[1].rider_id
      end

      it " Only accepts integers in seatch criteria " do
        skip
      end

      it " Outputs message if Rider could not be found " do
        skip
      end
    end #end of self.find

  end #end of class methods
end
