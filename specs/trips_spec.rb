require_relative 'spec_helper'
require_relative '../lib/trips.rb'

describe "Trips" do
    describe "initialize method" do
        it "Trips.new must be an instance of a trip" do
            new_trip = RideShare::Trips.new(25, 100, 90, "feb 29", 4)
            new_trip.must_be_instance_of RideShare::Trips
        end

        it "Takes an id, rider_id, driver_id and rating" do
            id = 190
            rider_id = 25
            driver_id = 90
            date = "feb 19"
            rating = 4

            trip = RideShare::Trips.new(id, rider_id, driver_id, date, rating)
            trip.id.must_equal 190
            trip.rider_id.must_equal 25
            trip.driver_id.must_equal 90
            trip.rating.must_equal 4
        end

        it "Raises error for ratings below 1 and above 5" do
            proc{ RideShare::Trips.new(25, 100, 90, "jan.12", -1) }.must_raise ArgumentError
            proc{ RideShare::Trips.new(25, 100, 90, "march 3", 6) }.must_raise ArgumentError
        end
    end


        describe "Trips all method" do
            before do
                @trips = RideShare::Trips.all
            end
            it "Reads a CSV and creates an array of trips" do
                @trips.must_be_instance_of Array
            end

            it "Everything in the array must be a trip instance" do
                @trips.each do |trip|
                    trip.must_be_instance_of RideShare::Trips
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
                @trips[399].rider_id.must_equal 9
                @trips[399].driver_id.must_equal 132
                @trips[399].date.must_equal "2016-10-19"
                @trips[399].rating.must_equal 5

            end

        end





end
