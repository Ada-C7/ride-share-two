require_relative '../lib/rider'
require_relative './spec_helper.rb'

describe "Rider" do

  describe "Rider#initialize" do

    before do
      rider_info = {
        id: 6,
        name: "Patience Keeling II",
        phone_number: "412-432-7640"
      }
      @new_rider = RideShare::Rider.new(rider_info)
    end

    it "returns an instance of rider" do
      @new_rider.must_be_instance_of RideShare::Rider
    end

    it "assigns instance variables: id, name, phone_number" do
      @new_rider.id.must_equal 6
      @new_rider.name.must_equal "Patience Keeling II"
      @new_rider.phone_number.must_equal "412-432-7640"
    end
  end

  # AHHH - what about duplicate riders ... duplicate ids...
  # - people could have same name but not phone numbers
   

  describe "Rider#all" do

    before do
      csv_file = './support/riders.csv'
      data = FileData.new(csv_file)
      @riders_data = data.read_csv_and_remove_headings
      @bad_data = {
                    bad_id: [['190', 'john smith', '123-456-7890'], ['two', 'name', '425-789-1234']],
                    bad_phone: [['190', 'john smith','123-456-7890'],['15', 'name', '425-678']],
                    missing_part: [['10', 'name']],
                    empty_array: [],
                    empty_nested_arrays: [[],[],[]],
                    bad_name: [['789', 'c', '123-4567']],
                    bad_phone_number: [['901', 'Cat', '123']]
                  }
    end

    let(:riders) { RideShare::Rider.all(@riders_data) }

    # it "accepts the csv_file and throws no errors" do
    #   @riders_data.each { |rider_data| RideShare::Rider.all([riders_data])
    # end

    it " accepts csv data - doesn't raise any errors & returns an array" do
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
             RideShare::Rider.all(@bad_data[:bad_id])
           }.must_raise ArgumentError
    end

    it "raises an error if given an empty array" do
      proc {
             RideShare::Rider.all(@bad_data[:empty_array])
           }.must_raise ArgumentError
    end

    it "raises an error if given empty nested arrays" do
      proc {
             RideShare::Rider.all(@bad_data[:empty_nested_arrays])
           }.must_raise ArgumentError
    end

    it "raises an error if given arrays missing data" do
      proc {
             RideShare::Rider.all(@bad_data[:missing_part])
           }.must_raise ArgumentError
    end

    it "raises an error if given bad phone_number" do
      err = proc {
                  RideShare::Rider.all(@bad_data[:bad_phone_number])
                  }.must_raise ArgumentError
      err.message.must_equal "Phone num less than 7"
    end

    it "raises an error if given bad name" do
      err = proc {
                  RideShare::Rider.all(@bad_data[:bad_name])
                 }.must_raise ArgumentError
      err.message.must_equal "Name length is under 1"
    end

  end

  describe "Rider#find" do

    # before do
    #   csv_file = './support/riders.csv'
    #   data = FileData.new(csv_file)
    #   @riders_data = data.read_csv_and_remove_headings
    # end

    it "requires an id argument" do
      proc {
        RideShare::Rider.find()
      }.must_raise ArgumentError
    end

    it "returns a rider instane when passed a valid id" do
      RideShare::Rider.find(7).must_be_instance_of RideShare::Rider
    end

    it "returns nil when given a driver id that does no exist" do
      RideShare::Rider.find(900).must_be_nil
    end

    it "can find the first rider from the CSV" do
      first_rider = RideShare::Rider.find(1)
      first_rider.name.must_equal "Nina Hintz Sr."
      first_rider.id.must_equal 1
      first_rider.phone_number.must_equal "560.815.3059"
    end

    it "can find the last rider from the CSV" do
      last_rider = RideShare::Rider.find(300)
      last_rider.name.must_equal "Miss Isom Gleason"
      last_rider.id.must_equal 300
      last_rider.phone_number.must_equal "791-114-8423 x70188"
    end
  end

#############################################################

  before do
    @rider_id = 12

  end

  let(:rider) { RideShare::Rider.find(@rider_id) }
  # rider 42 also doesn't have any trips
  let(:rider_no_trips) { RideShare::Rider.find(300) }
   # riders with more than one trip with same drivers - 41, 164, 92, 74, 63, 250
  let(:rider_with_same_driver) { RideShare::Rider.find(164) }

  describe "Rider#get_trips" do

    it "returns an array of trip instances" do
      rider.get_trips.must_be_instance_of Array
      rider.get_trips.each { |trip| trip.must_be_instance_of RideShare::Trip }
    end

    it "each trip instance has the same rider id" do
      rider.get_trips.each { |trip| trip.rider_id.must_equal @rider_id }
    end

    # is this an edge case?
    it "returns nil if rider has no trips" do
      rider_no_trips.get_trips.must_be_nil
    end
  end

  describe "Rider#get_drivers" do

    it "returns an array" do
      rider.get_drivers.must_be_instance_of Array
    end

    it "returns an array of driver instances" do
      rider.get_drivers.each { |driver| driver.must_be_instance_of RideShare::Driver  }
    end

    it "doesn't return array with duplicate drivers" do
      drivers = rider_with_same_driver.get_drivers
      drivers_ids = drivers.map { |driver| driver.id }
      drivers_ids.must_equal drivers_ids.uniq
    end

    it "returns nil if no drivers for rider" do
      rider_no_trips.get_drivers.must_be_nil
    end
  end
end
