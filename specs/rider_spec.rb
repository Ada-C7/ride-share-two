require_relative 'spec_helper'

describe "Rider" do
  describe "#initialize" do
    let (:perfect_rider)  {
      Rider.new(1, "Friendly One", "6172775726")
    }

    it "takes an id, name, and phone" do
      perfect_rider.must_respond_to :id
      perfect_rider.id.must_equal 1

      perfect_rider.must_respond_to :name
      perfect_rider.name.must_equal "Friendly One"

      perfect_rider.must_respond_to :phone
      perfect_rider.phone.must_equal "6172775726"
    end

    it "must be an instance of the Rider class" do
      perfect_rider.must_be_instance_of Rider
    end
  end

  describe "#trips" do
    # retrieve the list of trip instances that only this rider has taken
    it "returns the list of trip instances that only this rider has taken" do
      first_rider = Rider.new(1, "Nina Hintz Sr.", "560.815.3059")
      first_rider_trips = first_rider.trips
      first_rider_trips.must_be_instance_of Array
      first_rider_trips.each { |trip| trip.must_be_instance_of Trip }
    end

    it "returns no trips if the rider hasn't taken any trips" do
      bad_rider = Rider.new(300, "Miss Isom Gleason", "791-114-8423 x70188")
      bad_riders_trips = bad_rider.trips
      bad_riders_trips.must_be_instance_of Array
      bad_riders_trips.must_be_empty
    end
  end

  describe "#previous_drivers" do
    it "must return all the previous drivers for a rider id" do
      nina = Rider.new(1, "Nina Hintz Sr.", "560.815.3059")
      ninas_previous_drivers = nina.previous_drivers
      ninas_previous_drivers.must_be_instance_of Array
      ninas_previous_drivers.length.must_equal 2
      ninas_previous_drivers.each { |driver| driver.must_be_instance_of Driver }
    end

    it "must return only unique previous drivers" do
      westly = Rider.new(41, "Ms. Westley Pouros", "133.000.1809 x9028") #this rider had 3 trips
      westlys_previous_drivers = westly.previous_drivers
      westlys_previous_drivers.length.must_equal 2
      westlys_previous_drivers.each { |driver| driver.must_be_instance_of Driver }
    end
  end

  describe "Rider#all" do
    let (:riders)  {
      Rider.all
    }

    it "returns all drivers from the CSV file" do
      riders.must_be_instance_of Array

      riders.each { |i| i.must_be_instance_of Rider }

      riders.length.must_equal 300
    end
  end

  describe "Rider#find" do
    let (:riders)  {
      Rider.all
    }

    it "returns a rider that exists" do
      rider = Rider.find(riders[0].id)
      rider.must_be_instance_of Rider
    end

    it "can find the first rider from the CSV" do
      rider = Rider.find(1)
      rider.id.must_equal riders[0].id
    end

    it "can find the last rider from the CSV" do
      rider = Rider.find(300)
      rider.id.must_equal riders[-1].id
    end

    it "raises an error for a driver that doesn't exist" do
      proc {
        Rider.find(111111)
      }.must_raise ArgumentError
    end
  end

end
