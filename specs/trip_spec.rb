require_relative 'spec_helper'

describe "Trip Class" do

  describe "Instance Methods" do


    describe "initialize method" do

      let(:trip) { Carmmunity::Trip.new(
        trip_id: 1,
        rider_id: 22,
        driver_id: 333,
        rating: 4,
        date: '2017-03-08')}

      it "Instantiates a new instance of Trip class" do

        trip.must_be_instance_of Carmmunity::Trip
      end

      it "trip information matches " do

        trip.trip_id.must_equal    1
        trip.rider_id.must_equal   22
        trip.driver_id.must_equal  333
        trip.rating.must_equal     4
        trip.date.must_equal       '2017-03-08'
      end
    end #end of initialize method

    describe " find_rider method " do

      it " Returns a rider that exists " do
        trip = Carmmunity::Trip::all[342]
        rider = trip.find_rider

        rider.name.must_equal     "Gracie Emmerich"
        rider.rider_id.must_equal      54
        rider.phone_number.must_equal  "591-707-1595 x0908"
      end


      it " Can find the rider of the last trip in csv file " do

        trip = Carmmunity::Trip::all.last
        rider = trip.find_rider

        rider.rider_id.must_equal      168
        rider.name.must_equal          "Hayden Wisozk"
        rider.phone_number.must_equal  "(332) 422-8680 x79530"
      end

      it " Can find the First rider in the CSV file " do

        #need to remove first row from csv
        trip = Carmmunity::Trip::all[1]
        rider = trip.find_rider

        rider.rider_id.must_equal      54
        rider.name.must_equal          "Gracie Emmerich"
        rider.phone_number.must_equal  "591-707-1595 x0908"
      end

      it " Only accepts integers in seatch criteria " do
        skip
      end

      it " Outputs message if Trip could not be found " do
        skip
      end
    end #end of find_rider



    describe " find_driver method " do

      it " Returns a driver that exists " do

        trip = Carmmunity::Trip::all[342]

        driver = trip.find_driver

        driver.driver_id.must_equal     39
        driver.name.must_equal          "Mrs. Skylar Strosin"
        driver.vin.must_equal           "WD3R6AJ15CPJZLR0T"
      end

      it " Can find the driver of the last trip in csv file " do
        trip = Carmmunity::Trip::all.last
        driver = trip.find_driver

        driver.driver_id.must_equal     61
        driver.name.must_equal          "Mrs. Everardo Von"
        driver.vin.must_equal           "WBTTYCCG00Y9K1VHZ"
      end

      it " Can find the First driver in the CSV file " do
        #need to remove first row from csv
        trip = Carmmunity::Trip::all[1]
        driver = trip.find_driver

        driver.driver_id.must_equal     1
        driver.name.must_equal          "Bernardo Prosacco"
        driver.vin.must_equal           "WBWSS52P9NEYLVDE9"
      end

      it " Only accepts integers in seatch criteria " do
        skip
      end

      it " Outputs message if Trip could not be found " do
        skip
      end
    end #end of find_driver


  end #end of instance methods







  describe " Class Methods " do

    let(:trips) {Carmmunity::Trip::all}

    let(:trip_data) {CSV.read("support/trips.csv")}


    describe " self.all method " do

      it " Trip.all returns array " do

        trips.class.must_equal  Array
      end

      it " First and Last trips are instansces of Trip Class " do

        trips.first.must_be_instance_of    Carmmunity::Trip
        trips.last.must_be_instance_of     Carmmunity::Trip
      end

      it " The number of trips is correct " do

        trips.length.must_equal    CSV.read("support/trips.csv").count
      end

      it " The trip id, driver id, rider id, date, and rating matches the first trip " do

        index = 1
        trip_id = 1
        driver_id = 1
        rider_id = 54
        date = "2016-04-05"
        rating = 3

        #add loop
        trips[index].trip_id.must_equal      trip_id
        trips[index].rider_id.must_equal     rider_id
        trips[index].driver_id.must_equal    driver_id
        trips[index].date.must_equal         date
        trips[index].rating.must_equal       rating
      end

      it " The trip id, driver id, rider id, date, and rating matches the last trip " do

        trip_id = 0
        driver_id = 1
        rider_id = 2
        date = 3
        rating = 4

        trips.last.trip_id.must_equal       trip_data.last[trip_id].to_i
        trips.last.driver_id.must_equal     trip_data.last[driver_id].to_i
        trips.last.rider_id.must_equal      trip_data.last[rider_id].to_i
        trips.last.date.must_equal          trip_data.last[date]
        trips.last.rating.must_equal        trip_data.last[rating].to_i
      end
    end #end of self.all


    describe " self.rider_trips(id) " do

      it "returns an array " do
        Carmmunity::Trip::rider_trips(5).must_be_instance_of Array
      end

      # Is ther a situation where would find your selfing building a method to test your code. For example, checking to see if rider_trips(5) returns a trip that exists. We don't have a specific 'find trip' functionality. Would it be best practices to build this in the spec, or is this a red flag that something is missing in the program?

      #   it " Returns a trip that exists " do
      #   skip
      #   rider_trips = Carmmunity::Trip::rider_trips(54)
      #
      #
      #   rider_trips.must_include      "2016-04-05"
      #   rider_trips.must_include      1
      #   rider_trips.must_include      3
      # end

      it " Returns more than one trip " do

        rider_trips = Carmmunity::Trip::rider_trips(54)

        rider_trips.length.must_be    :>, 1

      end


      it " Only accepts integers in seatch criteria " do
        skip
      end

      it " Outputs message if Trip could not be found " do
        skip
      end
    end #end of self.rider_trips


    describe " self.driver_trips(id) " do

      it "Returns an Array" do

        trips = Carmmunity::Trip::driver_trips(5)

        trips.must_be_instance_of Array

      end


      # it " Returns a driver that exists " do
      #
      #   trips = Carmmunity::Trip::driver_trips(5)
      #   binding.pry
      #   my_driver.driver_id.must_equal    5
      #   my_driver.name.must_equal         "Verla Marquardt"
      #   my_driver.vin.must_equal          "TAMLE35L3MAYRV1JD"
      # end


      it " Only accepts integers in seatch criteria " do
        skip
      end

      it " Outputs message if Trip could not be found " do
        skip
      end
    end #end self.driver_trips

  end #end of class methods
end
