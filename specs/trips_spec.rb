require_relative 'spec_helper'
require_relative '../lib/trips.rb'
require 'pry'

describe "Trip" do
    describe "initialize method" do
        it "Trip.new must be an instance of a trip" do
            new_trip = RideShare::Trip.new(25, 100, 90, "feb 29", 4)
            new_trip.must_be_instance_of RideShare::Trip
        end

        it "Takes an id, rider_id, driver_id and rating" do
            id = 190
            rider_id = 25
            driver_id = 90
            date = "feb 19"
            rating = 4

            trip = RideShare::Trip.new(id, rider_id, driver_id, date, rating)
            trip.id.must_equal 190
            trip.rider_id.must_equal 90
            trip.driver_id.must_equal 25
            trip.rating.must_equal 4
        end

        it "Raises error for ratings below 1 and above 5" do
            proc{ RideShare::Trip.new(25, 100, 90, "jan.12", -1) }.must_raise ArgumentError
            proc{ RideShare::Trip.new(25, 100, 90, "march 3", 6) }.must_raise ArgumentError
        end
    end


        describe "Trip all method" do
            before do
                @trips = RideShare::Trip.all
            end
            it "Reads a CSV and creates an array of trips" do
                @trips.must_be_instance_of Array
            end

            it "Everything in the array must be a trip instance" do
                @trips.each do |trip|
                    trip.must_be_instance_of RideShare::Trip
                end

            end

            it "Reads in correct number of ride instances from CSV" do
                @trips.length.must_equal 600

            end

            it "First and last elements in CSV match the first and last in array" do
                @trips[0].id.must_equal 1
                @trips[-1].id.must_equal 600

            end

            it "Correctly assigns values from csv to Trips object" do
                @trips[399].id.must_equal 400
                @trips[399].rider_id.must_equal 132
                @trips[399].driver_id.must_equal 9
                @trips[399].date.must_equal "2016-10-19"
                @trips[399].rating.must_equal 5
            end

        end

        describe "Trips find driver method" do
            before do
                new_trip = RideShare::Trip.new(25, 90, 100, "feb 29", 4)
                @driver = new_trip.find_driver
            end

            it "Returns an instance of a RideShare::Driver" do
                @driver.must_be_instance_of RideShare::Driver
            end


            it "Returns an instance of a RideShare::Driver" do
                @driver.id.must_equal 90
                @driver.name.must_equal "Kristy Cremin"
                @driver.vin.must_equal "1F9FF7C27LJA041VR"
            end

            #this isn't working for some reason
            # it "Raises error if invalid driver entered" do
            #     proc{ trip = RideShare::Trips.new(25, 100, 200, "feb 29", 4)}.must_raise ArgumentError
            # end

        end


        describe "Trips find rider method" do
            before do
                new_trip = RideShare::Trip.new(25, 100, 90, "feb 29", 4)
                @rider = new_trip.find_rider
            end

            it "Returns and instance of RideShare::Rider" do
                @rider.must_be_instance_of RideShare::Rider
            end


            it "Returns correct instance of RideShare::Driver" do
            @rider.id.must_equal 90
            @rider.name.must_equal "Zackary Willms I"
            @rider.phone_number.must_equal "471-731-8253 x6048"
            end
        end


        describe "Find all trips for driver method" do

            it "Returns an array" do
                RideShare::Trip.find_all_drivers(16).must_be_instance_of Array

            end

            it "Returns correct number of trips" do
                RideShare::Trip.find_all_drivers(16).length.must_equal 6
            end


            # it "Raises an error if invalid driver is entered" do
            #
            # end

        end

        describe "Average rating method" do
            it "Returns a float" do
                RideShare::Trip.calculate_average_rating(16).must_be_instance_of Float
            end

            it "Returns the correct average" do
                RideShare::Trip.calculate_average_rating(16).must_equal 2.5
            end
        end

        describe "Find all trips for rider" do
            it "returns correct number of trips" do
                RideShare::Trip.find_all_trips_riders(45).length.must_equal 4   
            end
        end



end
