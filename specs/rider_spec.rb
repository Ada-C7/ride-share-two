require_relative 'spec_helper.rb'

require_relative '../lib/rider'

describe "RideShare::Rider" do
  before do
    # 13,Dr. Leilani Mertz,777.380.7540
    @rider = RideShare::Rider.new({id: "13", name: "Dr. Leilani Mertz", phone_number: "777.380.7540"})
  end

  describe "Rider#initialize" do
    it "creates a new instance of Rider" do
      @rider.must_be_instance_of RideShare::Rider
    end
    it "passes in the rider id" do
      @rider.id.must_equal "13"
    end
    it "passes in the rider name" do
      @rider.name.must_equal "Dr. Leilani Mertz"
    end
    it "passes in the rider phone number" do
      @rider.phone_number.must_equal "777.380.7540"
    end
    it "can create a new rider with a missing phone" do
      no_phone = RideShare::Rider.new({id: "87", name: "Tamiko Terada"})
      no_phone.phone_number.must_equal nil
    end
  end

  describe "Rider#all" do
    before do
      @riders = RideShare::Rider.all
    end

    it "returns an array" do
      @riders.must_be_kind_of Array
    end
    it "each returned element is a rider instances" do
      @riders.each do |object|
        object.must_be_instance_of RideShare::Rider
      end
    end
    it "returns the correct number of elements" do
      @riders.length.must_equal 300 # rows in CSV file
    end
    it "correctly reads in the first row of the CSV file" do
      # last row of data: 1,Nina Hintz Sr.,560.815.3059
      @riders[0].id.must_equal "1"
      @riders[0].name.must_equal "Nina Hintz Sr."
      @riders[0].phone_number.must_equal "560.815.3059"
    end
    it "correctly reads in the last row of the CSV file" do
      # last row of data: 300,Miss Isom Gleason,791-114-8423 x70188
      @riders[-1].id.must_equal "300"
      @riders[-1].name.must_equal "Miss Isom Gleason"
      @riders[-1].phone_number.must_equal "791-114-8423 x70188"
    end
  end
end
