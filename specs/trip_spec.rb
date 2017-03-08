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

        trip_test.trip_id.must_equal    999
        trip_test.rider_id.must_equal   2323
        trip_test.driver_id.must_equal  55555
        trip_test.rating.must_equal     5
        trip_test.date.must_equal       '03-08-17'
      end
    end #end of initialize method


  end #end of instance methods


  describe " Class Methods " do

    let(:my_trips) {Carmmunity::Trip::all}

    let(:trip_data) {CSV.read("support/trips.csv")}


    describe " self.all method " do

      it " Trip.all returns array " do

        my_trips.class.must_equal  Array
      end

      it " First and Last trips are instansces of Trip Class " do

        my_trips.first.must_be_instance_of    Carmmunity::Trip
        my_trips.last.must_be_instance_of     Carmmunity::Trip
      end

      it " The number of trips is correct " do

        my_trips.length.must_equal    CSV.read("support/trips.csv").count
      end

      it " The trip id, driver id, rider id, date, and rating matches the first trip " do

        index = 1
        trip_id = 1
        driver_id = 1
        rider_id = 54
        date = "2016-04-05"
        rating = 3

        #add loop
        my_trips[index].trip_id.must_equal      trip_id
        my_trips[index].rider_id.must_equal     rider_id
        my_trips[index].driver_id.must_equal    driver_id
        my_trips[index].date.must_equal         date
        my_trips[index].rating.must_equal       rating
      end

      it " The trip id, driver id, rider id, date, and rating matches the last trip " do

        trip_id = 0
        driver_id = 1
        rider_id = 2
        date = 3
        rating = 4

        my_trips.last.trip_id.must_equal       trip_data.last[trip_id].to_i
        my_trips.last.driver_id.must_equal     trip_data.last[driver_id].to_i
        my_trips.last.rider_id.must_equal      trip_data.last[rider_id].to_i
        my_trips.last.date.must_equal          trip_data.last[date]
        my_trips.last.rating.must_equal        trip_data.last[rating].to_i
      end
    end #end of self.all


    describe " self.find_rider(id) " do

      it " Returns a rider that exists " do

        my_rider = Carmmunity::Trip::find_rider(54)

        my_rider.name.must_equal          "Gracie Emmerich"
        my_rider.rider_id.must_equal      54
        my_rider.phone_number.must_equal  "591-707-1595 x0908"
      end


      it " Can find the rider of the last trip in csv file " do

        my_rider = Carmmunity::Trip::find_rider(168)

        my_rider.rider_id.must_equal      168
        my_rider.name.must_equal          "Hayden Wisozk"
        my_rider.phone_number.must_equal  "(332) 422-8680 x79530"
      end

      it " Can find the First rider in the CSV file " do

        my_rider = Carmmunity::Trip::find_rider(54)

        my_rider.rider_id.must_equal      54
        my_rider.name.must_equal          "Gracie Emmerich"
        my_rider.phone_number.must_equal  "591-707-1595 x0908"
      end

      it " Only accepts integers in seatch criteria " do
        skip
      end

      it " Outputs message if Trip could not be found " do
        skip
      end
    end #end of self.find_rider

    describe " self.find_driver(id) " do


      it " Returns a driver that exists " do
        #trying to figure out which format is less dependent than that other
        my_driver = Carmmunity::Trip::find_driver(5)

        my_driver.driver_id.must_equal    5
        my_driver.name.must_equal         "Verla Marquardt"
        my_driver.vin.must_equal          "TAMLE35L3MAYRV1JD"
      end


      it " Can find the driver of the last trip " do

        my_driver = Carmmunity::Trip::find_driver(61)

        my_driver.driver_id.must_equal   61
        my_driver.name.must_equal        "Mrs. Everardo Von"
        my_driver.vin.must_equal         "WBTTYCCG00Y9K1VHZ"
      end

      it " Can find the driver of the first trip " do
        
        my_driver = Carmmunity::Trip::find_driver(1)

        my_driver.name.must_equal        "Bernardo Prosacco"
        my_driver.driver_id.must_equal   1
        my_driver.vin.must_equal         "WBWSS52P9NEYLVDE9"
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
