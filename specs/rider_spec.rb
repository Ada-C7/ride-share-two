require_relative 'spec_helper'

describe "Rider Class" do

  describe "Initialize Method" do

    let(:rider) {
        RideShare::Rider.new({
        :id => "1",
        :name => "Nina Hintz Sr.",
        :phone_num => "560.815.3059"
        })
      }


    it "Initializes an object" do
      rider.must_be_instance_of RideShare::Rider
    end

    it "Initializes with an ID, name, and phone number" do
      rider.must_respond_to :id
      rider.must_respond_to :name
      rider.must_respond_to :phone_num
    end
  end

  describe "self.all" do

    let(:riders) {RideShare::Rider.all }

    it "Returns an array" do
      riders.must_be_instance_of Array
    end

    it "Returns an Array with elements" do
      riders.length.must_be :>, 0
    end

    it "Returns an array of rider Objects" do
      riders.each do |rider|
        rider.must_be_instance_of RideShare::Rider
      end
    end

    it "Each rider object contains an id, name and vin" do
      riders.each do |rider|
        rider.must_respond_to :id
        rider.must_respond_to :name
        rider.must_respond_to :phone_num
      end
    end

    it "Contains the correct information" do
      first = riders[0]
      first.name.must_equal "Nina Hintz Sr."
      first.id.must_equal "1"
      first.phone_num.must_equal "560.815.3059"
    end
  end

  describe "self.find" do

    let(:rider) { RideShare::Rider.find("1") }

    it "Returns a rider object based on ID" do
      rider.must_be_instance_of RideShare::Rider
    end

    it "Returns the correct rider object" do
      rider.name.must_equal "Nina Hintz Sr."
      rider.phone_num.must_equal "560.815.3059"
    end

    it "Returns nil if the ID was not found" do
      RideShare::Rider.find("1000").must_equal nil
    end

    it "Returns nil if the ID is not found" do
      RideShare::Rider.find("0").must_equal nil
    end

  end

  describe "Trips method" do

    let(:rider) { RideShare::Rider.all.first}



    it "Returns an Array" do
      rides = rider.trips
      rides.must_be_instance_of Array
    end

    it "Returns an Array of Objects" do
      rides = rider.trips
      rides.each { |r| r.must_be_instance_of RideShare::Trip }
    end

    it "Returns the correct information" do
      rider = RideShare::Rider.find("54")
      rides = rider.trips
      first = rides.first
      first.date.must_equal "2016-04-05"
    end

    it "Returns nil if a rider has no trips" do
      made_up_rider = RideShare::Rider.new({
        :id => "0",
        :name => "John Doe",
        :phone_num => "560.815.3059"
        })
      made_up_rider.trips.must_be_nil
    end
    
  end

  describe "Drivers method" do
    let(:rider) { RideShare::Rider.all.first }
    let(:drivers) { rider.drivers }

    it "Returns an array" do
      drivers.must_be_instance_of Array
    end

    it "Returns an array of driver objects" do
      drivers.each {|d| d.must_be_instance_of RideShare::Driver }
    end

    it "Returns nil if no trips are recorded" do
      made_up_rider = RideShare::Rider.new({
        :id => "0",
        :name => "John Doe",
        :phone_num => "560.815.3059"
        })
        made_up_rider.drivers.must_be_nil
    end

  end

end
