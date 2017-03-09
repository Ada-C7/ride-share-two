require_relative 'spec_helper'
require_relative '../lib/driver'

describe "Driver tests" do
  describe "Driver#initialize" do
    it "takes an id, name, and vin" do
        new_driver = Driver.new("3", "Bob Jones", "L1CXMYNZ3MMGTTYWU")

        new_driver.must_respond_to :id
        new_driver.id.must_equal 3

        new_driver.must_respond_to :name
        new_driver.name.must_equal "Bob Jones"

        new_driver.must_respond_to :vin
        new_driver.vin.must_equal "L1CXMYNZ3MMGTTYWU"
    end

    it "raises an error if vin is not 17 characters long" do

      proc {Driver.new(3, "Bob Jones", "12345")
      }.must_raise ArgumentError

    end

    ##maybe add test to make sure vin is letters and numbers??

  end


  describe "Driver.all" do
    before do
      @drivers_array = Driver.all
      @csv_file = CSV.read("./support/drivers.csv", {:headers => true})

    end

    it "Returns an array of all drivers" do
      @drivers_array.class.must_equal Array

    end

    it "Everything in array is a Driver" do
      @drivers_array.each do |element|
        element.must_be_instance_of Driver
      end
    end

    it "First element in array is first line in csv" do
      @drivers_array[0].name.must_equal @csv_file[0][1]

    end

    it "Last element in array is last line in csv" do
      @drivers_array[-1].name.must_equal @csv_file[-1][1]

    end

    it "number of elements matches number of elements in csv file" do
      @drivers_array.length.must_equal @csv_file.length
    end

  end


  describe "Driver#trips" do
    it "returns an array of trips taken" do
      new_driver = Driver.new(1, "Jan Brown", "HFG347DJ84HKX9872")

      new_driver.trips.class.must_equal Array

    end

    it "each element in the array is a trip" do
      new_driver = Driver.new(7, "Lizeth Dickens", "W09XNTZR9KTFK10WW")

      new_driver.trips.each do |element|
        element.must_be_instance_of Trip
      end

    end

    it "number of elements is the same as number of matches in csv file" do
      new_driver = Driver.new(78, "Casimir Vandervort", "SUA6WS160SW70DUP4")

      new_driver.trips.length.must_equal 8

      new_driver.trips.each do |trip|
        trip.driver.must_equal 78
      end


    end

  end

  describe "Driver#average" do
    before do
      @all_drivers = Driver.all
      @csv_file = CSV.read("./support/drivers.csv", {:headers => true})
    end

    it "returns a float of an average rating" do
      new_driver = Driver.new(1, "Jan Brown", "HFG347DJ84HKX9872")

      new_driver.average.class.must_equal Float
    end

    it "returns a correct average" do
      # @csv_file.each do |line|
      #   line[-1]

      new_driver = Driver.new(78, "Casimir Vandervort", "SUA6WS160SW70DUP4")

      total = 0
      new_driver.trips.each do |trip|
        total += trip.rating
      end

      new_driver.average.must_equal (total / new_driver.trips.length)

    end

  end

  describe "Driver.find(id)" do
    before do
      @all_drivers = Driver.all
      @csv_file = CSV.read("./support/drivers.csv", {:headers => true})
    end

    it "returns a driver" do
      Driver.find(1).must_be_instance_of Driver
    end

    it "returns correct driver" do
      Driver.find(1).name.must_equal @csv_file[0][1]
    end

    it "raises an argument error if no matching drivers found" do
      proc {Driver.find(@csv_file.length + 100)}.must_raise ArgumentError
    end

  end

end
