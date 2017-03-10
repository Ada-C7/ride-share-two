require_relative '../specs/spec_helper.rb'

describe "Rider" do

  describe "Rider#initialize" do

    let(:new_rider) {RideShare::Rider.new(1, "Nina Hintz Sr.", "560.815.3059")}

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

    it "Should create instances of riders and their associated data" do
      RideShare::Rider.all.must_be_kind_of Array
    end
  end

  describe "Rider#find" do

    it "Should return the first account from the CSV file" do
      RideShare::Rider.find(1).id.must_equal(1)
      RideShare::Rider.find(1).name.must_equal("Nina Hintz Sr.")
      RideShare::Rider.find(1).phone_num.must_equal("560.815.3059")
    end

    it "Should return the last account from the CSV file" do
      RideShare::Rider.find(300).id.must_equal(300)
      RideShare::Rider.find(300).name.must_equal("Miss Isom Gleason")
      RideShare::Rider.find(300).phone_num.must_equal("791-114-8423 x70188")
    end

    it "Returns an account that exists" do
      RideShare::Rider.find(100).id.must_equal(100)
      RideShare::Rider.find(100).name.must_equal("Hipolito Rogahn")
      RideShare::Rider.find(100).phone_num.must_equal("944.179.4883")
    end

    it "Raises an error when the account does not exist" do
      proc { RideShare::Rider.find(301)}.must_raise ArgumentError
    end
  end

  describe "Rider#retrieve_trips" do

  let(:new_rider) {RideShare::Rider.new(1, "Nina Hintz Sr.", "560.815.3059")}

    it "Should return a list of trips taken by rider_id" do
      # binding.pry
      new_rider.retrieve_trips.length.must_equal 2
      # binding.pry
    end
  end

describe "Rider#find_drivers" do

  let(:new_rider) {RideShare::Rider.new(2, "Kaia Klocko", "(392) 217-0777")}
  # 2,Kaia Klocko,(392) 217-0777
    it "Should retrieve trip's drivers" do
      driver = new_rider.find_drivers.each do |x|
         return x.id
       end
    end
   id.must_equal(11)
           # .must_equal 10
      # new_rider.must_equal 1

    # binding.pry
  end
end
