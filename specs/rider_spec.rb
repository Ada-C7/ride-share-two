require_relative 'spec_helper'
require_relative '../lib/rider.rb'

describe "Rider" do
    describe "Initialize method" do
        it "Rider.new must be an instance of a rider" do
            my_rider = RideShare::Rider.new(116,"Miss Daisy","1231231234")
            my_rider.must_be_instance_of RideShare::Rider
        end

        it "Takes an id, name and phone_number" do
            id = 209
            name = "Travis Bickle"
            phone_number = "3242351261"

            my_rider = RideShare::Rider.new(id, name, phone_number)
            my_rider.id.must_equal 209
            my_rider.name.must_equal "Travis Bickle"
            my_rider.phone_number.must_equal"3242351261"

        end
    end

    describe "Self.all method" do
        before do
            @my_riders = RideShare::Rider.all
        end
        it "Must read a csv and create an array of rider" do
            @my_riders.must_be_instance_of Array
        end

        it "Everything in the array must be an instance of a rider" do
            @my_riders.each do |rider|
                rider.must_be_instance_of RideShare::Rider
            end
        end

        it "Contains the correct number of riders" do
            @my_riders.length.must_equal 300
        end

        it "First and last lines of csv match first and last riders in rider array" do

            @my_riders[0].id.must_equal 1
            @my_riders[0].name.must_equal "Nina Hintz Sr."
            @my_riders[0].phone_number.must_equal "560.815.3059"

            @my_riders[-1].id.must_equal 300
            @my_riders[-1].name.must_equal "Miss Isom Gleason"
            @my_riders[-1].phone_number.must_equal "791-114-8423 x70188"

        end

        it "All elements from the csv match the instances" do
            @my_riders[215].id.must_equal 216
            @my_riders[215].name.must_equal "Assunta Waters Jr."
            @my_riders[215].phone_number.must_equal "(319) 982-0908"
        end
    end


    describe "Self.find method" do
        it "Takes an id and returns the correct rider" do
            my_rider = RideShare::Rider.find(116)
            my_rider.name.must_equal "Laurianne Larkin"
            my_rider.phone_number.must_equal "567.228.1637 x86366"
        end

        it "Raises and argument error for invalid ids" do
            proc { RideShare::Driver.find(416) }.must_raise ArgumentError

        end
    end


    describe "Find all trips for rider method" do
        before do
            @my_rider = RideShare::Rider.new(116,"Miss Daisy","1231231234")
        end

        it "returns an array of trips" do
            @my_rider.find_trips.must_be_instance_of Array
        end
    end

    describe "Find all previous drivers for a rider" do
        before do
            @my_rider = RideShare::Rider.new(116,"Miss Daisy","1231231234")
            @previous_drivers = @my_rider.previous_drivers

        end

        it "returns an array of previous drivers" do
            @previous_drivers.must_be_instance_of Array
        end

        it "Every item in the array is an instance of driver" do
            @previous_drivers.each do |rider|
                rider.must_be_instance_of RideShare::Rider
            end

        end

    end




end
