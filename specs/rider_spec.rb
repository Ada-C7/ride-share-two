require_relative 'spec_helper'

describe "Rider Initialize" do

    it "Takes a Rider ID, name, phone number" do
      rider_id = 318
      name = "Alice"
      phone_num = "(206)634-3400"
      rider = RideShareTwo::Rider.new(rider_id, name, phone_num)

      rider.must_respond_to :rider_id
      rider.rider_id.must_equal rider_id

      rider.must_respond_to :name
      rider.name.must_equal name

      rider.must_respond_to :phone_num
      rider.phone_num.must_equal phone_num
    end

end

describe "self.all_riders" do
  let(:rider_list) {RideShareTwo::Rider.all_riders}

  it "Returns an array of all riders" do
    rider_list
    rider_list.must_be_kind_of Array, "Oops - the class is not an array"
  end

  it "Everything in the array returned is a rider" do
    rider_list
    rider_list.each do |rider|
      rider.must_be_kind_of RideShareTwo::Rider, "This is not a rider."
    end
  end

  it "The number of riders is correct" do
    rider_list
    rider_list.length.must_equal 300, "Oops you are missing a rider!"
  end

  it "The ID of the first rider match what's in the CSV file" do
    rider_list
    rider_list[0].rider_id.must_equal "1", "Oops the first id is not in the array"
  end

  it "The phone number of the first rider match what's in the CSV file" do
    rider_list
    rider_list[0].phone_num.must_equal "560.815.3059", "Oops the first phone number is not in the array"
  end

  it "The ID of the last rider match what's in the CSV file" do
    rider_list
    rider_list[299].rider_id.must_equal "300", "Oops the last id is not in the array"
  end

  it "The phone number of the last rider match what's in the CSV file" do
    rider_list
    rider_list[299].phone_num.must_equal "791-114-8423 x70188", "Oops the last phone number is not in the array"
  end

end

#I think I need more tests for this
describe "self.find_rider" do
  it "finds a specific rider using their numeric ID" do
    RideShareTwo::Rider.find_rider("88").must_be_kind_of RideShareTwo::Rider, "Oops that ID does not match a rider"
  end

end
