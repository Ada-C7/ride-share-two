require_relative 'spec_helper'

describe "Trip Class" do

  let(:trip_test) { Carmmunity::Trip.new(
    trip_id: 999,
    rider_id: 2323,
    driver_id: 55555,
    rating: 5,
    date: '03-08-17')}

  describe "Instance Methods" do
    describe "initialize method" do

      it "Instantiates a new instance of Trip class" do
        trip_test.must_be_instance_of Carmmunity::Trip
      end

      it "Stored data must match what was passed as an argument" do

        trip_test.trip_id.must_equal 999
        trip_test.rider_id.must_equal 2323
        trip_test.driver_id.must_equal 55555
        trip_test.rating.must_equal 5
        trip_test.date.must_equal '03-08-17'
      end
    end #end of initialze method


  end #end of instance methods


  xdescribe " Class Methods " do

    let(:my_riders) {Carmmunity::Trip::all}

    let(:rider_data) {CSV.read("support/riders.csv")}


    describe " self.all method " do


      it " Trip.all returns array " do

        my_riders.class.must_equal Array
      end

      it " First and Last riders are instansces of Trip Class " do

        my_riders.first.must_be_instance_of Carmmunity::Trip
        my_riders.last.must_be_instance_of Carmmunity::Trip
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


    describe " self.find_rider(id) " do


      it " Returns a rider that exists " do
        #trying to figure out which format is less dependent than that other
        my_rider = Carmmunity::Trip::find(5)

        id = 5
        #name = "Elmore Heller MD"
        phone_num = "1-297-522-2558 x431"


        my_rider.name.must_equal my_riders[5].name
        my_rider.rider_id.must_equal id
        my_rider.phone_number.must_equal rider_data[5][2]
        my_rider.phone_number.must_equal phone_num
      end


      it " Can find the last driver in the CSV file " do

        my_rider = Carmmunity::Trip::find(300)

        my_rider.name.must_equal my_riders.last.name

        my_rider.rider_id.must_equal my_riders.last.rider_id
      end

      it " Can find the First driver in the CSV file " do

        my_rider = Carmmunity::Trip::find(1)

        my_rider.name.must_equal my_riders[1].name

        my_rider.rider_id.must_equal my_riders[1].rider_id
      end

      it " Only accepts integers in seatch criteria " do
        skip
      end

      it " Outputs message if Trip could not be found " do
        skip
      end
    end #end of self.find_rider

    describe " self.find_driver(id) " do


      it " Returns a rider that exists " do
        #trying to figure out which format is less dependent than that other
        my_rider = Carmmunity::Trip::find(5)

        id = 5
        #name = "Elmore Heller MD"
        phone_num = "1-297-522-2558 x431"


        my_rider.name.must_equal my_riders[5].name
        my_rider.rider_id.must_equal id
        my_rider.phone_number.must_equal rider_data[5][2]
        my_rider.phone_number.must_equal phone_num
      end


      it " Can find the last driver in the CSV file " do

        my_rider = Carmmunity::Trip::find(300)

        my_rider.name.must_equal my_riders.last.name

        my_rider.rider_id.must_equal my_riders.last.rider_id
      end

      it " Can find the First driver in the CSV file " do

        my_rider = Carmmunity::Trip::find(1)

        my_rider.name.must_equal my_riders[1].name

        my_rider.rider_id.must_equal my_riders[1].rider_id
      end

      it " Only accepts integers in seatch criteria " do
        skip
      end

      it " Outputs message if Trip could not be found " do
        skip
      end
    end #end self.find_driver

  end #end of class methods
end
