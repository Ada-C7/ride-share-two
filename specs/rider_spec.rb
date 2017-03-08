require_relative 'spec_helper'

describe "Ride_share_two::Rider" do
  describe "Rider#initialize" do
    it "Takes rider_id, name, phone_num" do
      rider_id = "1"
      name = "Nina Hintz Sr."
      phone_num = "560.815.3059"
      rider1 = Ride_share_two::Rider.new(rider_id, name, phone_num)
      rider1.name.must_equal "Nina Hintz Sr."
    end
  end

  describe "#self.all_riders" do
    it "retrieves all riders from the CSV file" do
      Ride_share_two::Rider.all_riders.length.must_equal 300
    end

  end
end
