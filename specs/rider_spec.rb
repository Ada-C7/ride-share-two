require_relative '../specs/spec_helper.rb'

describe "Rider" do

  describe "Rider#initialize" do

    let(:new_rider) do
      RideShare::Rider.new(1, "Nina Hintz Sr.", "560.815.3059")
    end

    it "Should create an instance of rider " do
      new_rider.must_be_instance_of RideShare::Rider
    end

    it "Should be associated with :id, :name, and :phone_num" do
      new_rider.must_respond_to(:id)
      new_rider.must_respond_to(:name)
      new_rider.must_respond_to(:phone_num)
    end
  end

  describe "Rider#all" do

    let(:new_rider) { RideShare::Rider.all }

    it "Should create instances of riders and their associated data" do
      new_rider.must_be_kind_of Array
      new_rider.length.must_equal 300
      new_rider.each do
        |object| object.must_be_instance_of RideShare::Rider
      end
    end

  end

  describe "Rider#find" do

    let(:new_rider) { RideShare::Rider.find(1) }
    let(:rider_300) { RideShare::Rider.find(300) }
    let(:rider_100) { RideShare::Rider.find(100) }
    let(:invalid_rider) { RideShare::Rider.find(301) }

    it "Should return the first account from the CSV file" do
      new_rider.id.must_equal(1)
      new_rider.name.must_equal("Nina Hintz Sr.")
      new_rider.phone_num.must_equal("560.815.3059")
    end

    it "Should return the last account from the CSV file" do
      rider_300.id.must_equal(300)
      rider_300.name.must_equal("Miss Isom Gleason")
      rider_300.phone_num.must_equal("791-114-8423 x70188")
    end

    it "Returns an account that exists" do
      rider_100.id.must_equal(100)
      rider_100.name.must_equal("Hipolito Rogahn")
      rider_100.phone_num.must_equal("944.179.4883")
    end

    it "Raises an error when the account does not exist" do
      proc { invalid_rider }.must_raise InvalidFileError
    end
  end

  describe "Rider#retrieve_trips" do

    let(:new_rider) do
      RideShare::Rider.new(1, "Nina Hintz Sr.", "560.815.3059")
    end

    let(:no_trip) do
      RideShare::Rider.new(300, "Miss Isom Gleason", "791-114-8423 x70188")
    end

    it "Should return a list of trips taken by rider_id" do
      new_rider.retrieve_trips.must_be_kind_of Array
      new_rider.retrieve_trips.length.must_equal 2
      new_rider.retrieve_trips.first.must_be_instance_of RideShare::Trip
    end

    it "Returns no trips if the rider has not taken a trip" do
      no_trip.retrieve_trips.must_be_empty
    end
  end

  describe "Rider#find_drivers" do

    let(:new_rider) do
      RideShare::Rider.new(12, "Jean Donnelly", "120-307-6251 x164")
    end

    it "Should retrieve trip's drivers" do
      new_rider.find_drivers.length.must_equal 4
      new_rider.find_drivers.first.must_be_kind_of(RideShare::Driver)
      # binding.pry
    end

  end
end
