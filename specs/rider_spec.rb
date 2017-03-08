require_relative 'spec_helper'

describe "Rider Class" do

  let(:ada) { Carmmunity::Rider.new(name: 'Ada', rider_id: 2, phone_number: "909-555-1234" )}

  describe "Instance Methods" do
    describe "initialize method" do

      it "Instantiates a new instance of Rider class" do
        ada.must_be_instance_of Carmmunity::Rider
      end

      it "Stored data must match what was passed as an argument" do

        ada.name.must_equal "Ada"
        ada.rider_id.must_equal 2
        ada.phone_number.must_equal '909-555-1234'
      end
    end #end of initialze method


    xdescribe "trips_taken" do

      it "Trips taken must be an array" do
        skip
        ada.trips_taken.must_be_instance_of Array
      end

      it "The driver id number matches the driver id in the trip information" do
        skip
      end

      it "Returns the correct number of trips taken " do
        skip
      end

      it "Returns the correct trip infromation" do
        skip
      end


    end #end of trips taken

    xdescribe "previous_drivers method" do


      it " Returns an array " do
        skip
      end

      it "returns a previous_driver" do
        skip
      end

      it "returns a the correct number of drivers" do
        skip
      end

      it "returns message if no trips have been taken" do
        skip
      end

    end #end of previous_drivers
  end #end of instance methods


  describe " Class Methods " do

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


      it " Can find the last driver in the CSV file " do

        my_rider = Carmmunity::Rider::find(300)

        my_rider.name.must_equal my_riders.last.name

        my_rider.rider_id.must_equal my_riders.last.rider_id
      end

      it " Can find the First driver in the CSV file " do

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
