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
    end #end of initialize method


  end #end of instance methods


  describe " Class Methods " do

    let(:my_trips) {Carmmunity::Trip::all}

    let(:trip_data) {CSV.read("support/trips.csv")}


    describe " self.all method " do

      it " Trip.all returns array " do

        my_trips.class.must_equal Array
      end

      it " First and Last trips are instansces of Trip Class " do

        my_trips.first.must_be_instance_of Carmmunity::Trip
        my_trips.last.must_be_instance_of Carmmunity::Trip
      end

      it " The number of trips is correct " do

        my_trips.length.must_equal CSV.read("support/trips.csv").count
      end

      it " The trip id, driver id, rider id, date, and rating matches the first trip " do

        index = 1
        trip_id = 1
        driver_id = 1
        rider_id = 54
        date = "2016-04-05"
        rating = 3

        #add loop
        my_trips[index].trip_id.must_equal trip_id
        my_trips[index].rider_id.must_equal rider_id
        my_trips[index].driver_id.must_equal driver_id
        my_trips[index].date.must_equal date
        my_trips[index].rating.must_equal rating
      end

      it " The trip id, driver id, rider id, date, and rating matches the last trip " do

        trip_id = 0
        driver_id = 1
        rider_id = 2
        date = 3
        rating = 4

        my_trips.last.trip_id.must_equal trip_data.last[trip_id].to_i
        my_trips.last.driver_id.must_equal trip_data.last[driver_id].to_i
        my_trips.last.rider_id.must_equal trip_data.last[rider_id].to_i
        my_trips.last.date.must_equal trip_data.last[date]
        my_trips.last.rating.must_equal trip_data.last[rating].to_i

      end
    end #end of self.all


    xdescribe " self.find_rider(id) " do


      it " Returns a rider that exists " do
        #trying to figure out which format is less dependent than that other
        my_trip = Carmmunity::Trip::find(5)

        id = 5
        #name = "Elmore Heller MD"
        phone_num = "1-297-522-2558 x431"


        my_trip.name.must_equal my_trips[5].name
        my_trip.rider_id.must_equal id
        my_trip.phone_number.must_equal trip_data[5][2]
        my_trip.phone_number.must_equal phone_num
      end


      it " Can find the last driver in the CSV file " do

        my_trip = Carmmunity::Trip::find(300)

        my_trip.name.must_equal my_trips.last.name

        my_trip.rider_id.must_equal my_trips.last.rider_id
      end

      it " Can find the First driver in the CSV file " do

        my_trip = Carmmunity::Trip::find(1)

        my_trip.name.must_equal my_trips[1].name

        my_trip.rider_id.must_equal my_trips[1].rider_id
      end

      it " Only accepts integers in seatch criteria " do
        skip
      end

      it " Outputs message if Trip could not be found " do
        skip
      end
    end #end of self.find_rider

    xdescribe " self.find_driver(id) " do


      it " Returns a rider that exists " do
        #trying to figure out which format is less dependent than that other
        my_trip = Carmmunity::Trip::find(5)

        id = 5
        #name = "Elmore Heller MD"
        phone_num = "1-297-522-2558 x431"


        my_trip.name.must_equal my_trips[5].name
        my_trip.rider_id.must_equal id
        my_trip.phone_number.must_equal trip_data[5][2]
        my_trip.phone_number.must_equal phone_num
      end


      it " Can find the last driver in the CSV file " do

        my_trip = Carmmunity::Trip::find(300)

        my_trip.name.must_equal my_trips.last.name

        my_trip.rider_id.must_equal my_trips.last.rider_id
      end

      it " Can find the First driver in the CSV file " do

        my_trip = Carmmunity::Trip::find(1)

        my_trip.name.must_equal my_trips[1].name

        my_trip.rider_id.must_equal my_trips[1].rider_id
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
