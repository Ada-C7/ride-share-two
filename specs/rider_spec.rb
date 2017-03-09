require_relative 'spec_helper'
require_relative '../lib/rider'


describe "Rider tests" do
  describe "Rider#initialize" do
    it "takes an id, name, and phone" do
        new_rider = Rider.new(35, "Jane Doe", "702-464-3849")

        new_rider.must_respond_to :id
        new_rider.id.must_equal 35

        new_rider.must_respond_to :name
        new_rider.name.must_equal "Jane Doe"

        new_rider.must_respond_to :phone
        new_rider.phone.must_equal "702-464-3849"
    end
  end


  describe "Rider.all" do
    before do
      @all_riders = Rider.all
      @csv_file = CSV.read("./support/riders.csv", {:headers => true})
    end

    it "returns an array of all riders" do
      @all_riders.class.must_equal Array
    end

    it "each element in array is a Rider" do

      @all_riders.each do |element|
        element.must_be_instance_of Rider
      end
    end

    it "first element matches piece of data in csv" do
      @all_riders[0].name.must_equal @csv_file[0][1]
    end

    it "last element matches last piece of data in csv" do
      @all_riders[-1].name.must_equal @csv_file[-1][1]
    end

    it "number of elements matches number of elements in csv file" do
      @all_riders.length.must_equal @csv_file.length
    end

  end

  describe "Rider.find(id)" do
    before do
      @csv_file = CSV.read("./support/riders.csv", {:headers => true})
    end

    it "returns a rider based on id" do
      Rider.find(3).must_be_instance_of Rider
    end

    it "returns the correct rider based on id" do
      Rider.find(3).name.must_equal @csv_file[2][1]
    end

    it "raises an ArgumentError if there are no matching riders" do
      proc {Rider.find(@csv_file.length + 100)}.must_raise ArgumentError
    end

  end


  describe "Rider#trips" do
    it "returns an array of trips taken" do
      new_rider = Rider.new(1, "Jan Brown", "702-123-4567")

      new_rider.trips.class.must_equal Array

    end

    it "each element in the array is a trip" do
      new_rider = Rider.new(2, "Kaia Klocko", "(392) 217-0777")

      new_rider.trips.each do |element|
        element.must_be_instance_of Trip
      end

    end

  end

  describe "Rider.drivers" do
    it "returns array of past drivers used" do
      new_rider = Rider.new(2, "Kaia Klocko", "(392) 217-0777")

      new_rider.drivers.class.must_equal Array
    end

    it "everything in array is a driver" do
      new_rider = Rider.new(45, "Lavina Friesen", "1-213-163-6582")

      new_rider.drivers.each do |element|
        element.must_be_instance_of Driver
      end
    end

    it "there are the correct number of drivers in the array" do
      new_rider = Rider.new(45, "Lavina Friesen", "1-213-163-6582")

      new_rider.drivers.length.must_equal 4

    end

  end

end
