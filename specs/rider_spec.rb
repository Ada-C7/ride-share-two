require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/rider'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Rider" do
  describe "Rider#Initialize" do

    before do
      rider_info = {
        id: 6,
        name: "Patience Keeling II",
        phone_number: "412-432-7640"
      }
      @new_rider = RideShare::Rider.new(rider_info)
    end

    it "raises an argumen error if ..." do
      skip
    end

    it "initializes with 1 argument: a rider info hash" do
      @new_rider.must_be_instance_of RideShare::Rider
    end

    it "assigns instance variables: id, name, phone_number" do
      @new_rider.id.must_equal 6
      @new_rider.name.must_equal "Patience Keeling II"
      @new_rider.phone_number.must_equal "412-432-7640"
    end
  end

  describe "Rider#all" do

    before do
      csv_file = './support/riders.csv'
      data = FileData.new(csv_file)
      @riders_data = data.read_csv_and_remove_headings
      @riders_bad_data_1 = [['two', 'name', '425-789-1234']]
      @riders_bad_data_2 = [['10', 'name', 'phone_number']]
      @riders_bad_data_3 = [['15', 'name', 425-678-1234]]
      @riders_bad_data_4 = [['10', 'name']]
      @riders_bad_data_5 = []
      @riders_bad_data_6 = [[],[],[]]
    end

    let(:riders) { RideShare::Rider.all(@riders_data) }

    it "returns an array" do
      riders.must_be_instance_of Array
    end

    it "has instances of riders in the array" do
      riders.each { |rider| rider.must_be_instance_of RideShare::Rider }
    end

    it "has the same number of riders instances as the CSV file" do
      riders.length.must_equal @riders_data.length
    end

    it "raises an error if given bad id data" do
      proc {
         RideShare::Rider.all(@riders_bad_data_1)
      }.must_raise ArgumentError
    end

    it "raises an error if given an empty array" do
      proc {
         RideShare::Rider.all(@riders_bad_data_5)
      }.must_raise ArgumentError
    end

    it "raises an error if given empty nested arrays" do
      proc {
         RideShare::Rider.all(@riders_bad_data_6)
      }.must_raise ArgumentError
    end

    it "raises an error if given arrays missing data" do
      proc {
         RideShare::Rider.all(@riders_bad_data_4)
      }.must_raise ArgumentError
    end

  end

  describe "Rider#find" do

    before do
      csv_file = './support/riders.csv'
      data = FileData.new(csv_file)
      @riders_data = data.read_csv_and_remove_headings
    end

    it "requires arguments" do
      proc {
        RideShare::Rider.find()
      }.must_raise ArgumentError
    end

    it "returns a rider instane when passed a valid id" do
      RideShare::Rider.find(7, @riders_data).must_be_instance_of RideShare::Rider
    end

    it "returns nil when given a driver id that does no exist" do
      RideShare::Rider.find(900, @riders_data).must_be_nil
    end

    it "can find the first rider from the CSV" do
      first_rider = RideShare::Rider.find(1, @riders_data)
      first_rider.name.must_equal "Nina Hintz Sr."
      first_rider.id.must_equal 1
      first_rider.phone_number.must_equal "560.815.3059"
    end

    it "can find the last rider from the CSV" do
      last_rider = RideShare::Rider.find(300, @riders_data)
      last_rider.name.must_equal "Miss Isom Gleason"
      last_rider.id.must_equal 300
      last_rider.phone_number.must_equal "791-114-8423 x70188"
    end
  end
end
