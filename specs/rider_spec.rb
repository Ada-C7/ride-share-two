require_relative 'spec_helper'
require_relative '../lib/rider'

describe RideShare::Rider do
  describe "#initialize" do
    it "Doesn't create a rider without an id" do
      proc {
        RideShare::Rider.new(name: "Alix", phone_number: "123-4567")
      }.must_raise ArgumentError
    end

    it "Doesn't create a rider without a name" do
      proc {
        RideShare::Rider.new(id: 4, phone_number: "123-4567")
      }.must_raise ArgumentError
    end

    it "Doesn't create a rider without a phone number" do
      proc {
        RideShare::Rider.new(id: 4, name: "Alix")
      }.must_raise ArgumentError
    end
  end

  describe "self.all" do
    let(:all) { RideShare::Rider.all }

    it "Creates an array of all rider from the csv file" do
      all.must_be_instance_of Array
      all.first.must_be_instance_of RideShare::Rider
    end

    it "Includes the first rider in the csv file" do
      all.first.name.must_equal "Nina Hintz Sr."
    end

    it "Includes the last rider in the csv file" do
      all.last.name.must_equal "Miss Isom Gleason"
    end
  end

  describe "self.find" do
    it "Returns a rider object when given a valid rider ID" do
      rider = RideShare::Rider.find(139)

      rider.must_be_instance_of RideShare::Rider
      rider.name.must_equal "Adah Miller"
    end

    it "Returns nil when given an invalid rider ID" do
      RideShare::Rider.find("TRICKERY!").must_be_nil
    end
  end
end
