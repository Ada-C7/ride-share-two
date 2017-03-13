require_relative 'spec_helper.rb'

describe RideShare::Rider do
  before do
    @my_rider = RideShare::Rider.new(id = 4, name = "Ervin Wiza", phone_number = "272-041-9587")
  end
  describe "initialize" do
    it "takes a name, id, and phone number" do
      name = "Ervin Wiza"
      id = 4
      phone_number = "272-041-9587"
      @my_rider.must_be_instance_of RideShare::Rider
      @my_rider.name.must_equal name
      @my_rider.id.must_equal id
      @my_rider.phone_number.must_equal phone_number
    end
  end
  describe "self.all" do
    before do
      @rider_trips = RideShare::Rider.all
    end
    it "checks for an array" do
      @rider_trips.must_be_instance_of Array
    end
    it "checks every array is instance of Rider" do
      @rider_trips.each do |array|
        array.must_be_instance_of RideShare::Rider
      end
    end
    it "checks correct length of csv driver file" do
      @rider_trips.length.must_equal 300
    end
  end

  describe "self.find" do
    before do
      id = 5
      @sample_rider_id = RideShare::Rider.find(id)
    end
    it "checks that @sample_rider_id is an instance of Rider class" do
      @sample_rider_id.must_be_instance_of RideShare::Rider
    end
    it "checks to make sure that an argument error is being raised for invalid id given" do
      proc {
        RideShare::Rider.find(999)
      }.must_raise ArgumentError
    end
  end

  describe "trip_instances_for_rider" do
    it "checks it is of trip class" do
      @my_rider.must_be_instance_of RideShare::Rider
    end
    it "check that Array is being returned" do
      @my_rider.trip_instances_for_rider.must_be_instance_of Array
    end
    it "will raise argument error if id given doesn't match anything" do
      proc {
        RideShare::Trip.find_trips_of_rider(999)
      }.must_raise ArgumentError
    end
  end

  describe "retrieve_list_of_previous_drivers" do
    it "check that array is being returned" do
      @my_rider.retrieve_list_of_previous_drivers.must_be_instance_of Array
    end
  end

end
