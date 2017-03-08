require_relative 'spec_helper'

# Try to use let! :) instead of before
describe "Rider class" do
  let(:riding) { RideShare::Rider.new(id: 1337, name: "bob", phone_number: "123.456.789") }

  describe "Rider#initialize" do
    it "It takes a rider_hash argument" do
      riding.must_be_instance_of RideShare::Rider
    end

    it "Has the correct values that were passed" do
      riding.id.must_equal 1337
      riding.name.must_equal "bob"
      riding.phone_number.must_equal "123.456.789"
    end
  end

  describe "Rider.all" do
    let(:riders) { RideShare::Rider.all }

    it "Returns an array will all the riders info" do
      riders.class.must_equal Array
    end

    it "Everything in the array is a rider" do
      first_rider = riders[0]
      first_rider.class.must_equal RideShare::Rider
    end

    it "The id of the first and last rider" do
      first_rider = riders[1].id
      first_rider.must_equal 1
      last_rider = riders.last.id
      last_rider.must_equal 300
    end

    it "Rider info matches what's in the CSV file" do
      index = 1
      CSV.read("support/riders.csv") do
        riders[index].id.must_equal line[0].to_i
        riders[index].name.must_equal line[1]
        riders[index].phone_number.must_equal line[2]

        index += 1
      end
    end
  end

  describe "Rider.find" do
    let(:rider) { RideShare::Rider }

    it "Returns an account that exists" do
      rider_exists = rider.find(23)
      rider_exists.must_be_instance_of RideShare::Rider

      rider_exists.id.must_equal 23
      rider_exists.name.must_equal "Kevin Stark"
      rider_exists.phone_number.must_equal "315.906.2450 x6575"
    end

    it "Can find the first account from the CSV" do
      rider_exists = rider.find(1)
      rider_exists.id.must_equal 1
      rider_exists.name.must_equal "Nina Hintz Sr."
      rider_exists.phone_number.must_equal "560.815.3059"
    end

    it "Can find the last account from the CSV" do
      rider_exists = rider.find(300)
      rider_exists.id.must_equal 300
      rider_exists.name.must_equal "Miss Isom Gleason"
      rider_exists.phone_number.must_equal "791-114-8423 x70188"
    end

    it "Raises an error for an account that does not exist" do
      proc { rider.find(1337) }.must_raise ArgumentError
    end
  end

  xdescribe "Rider#trip" do
    it "" do
    end
  end

end
