require_relative 'spec_helper'

describe "Ride_share_two::Rider" do
  let(:rider1) {Ride_share_two::Rider.new("1","Nina Hintz Sr.","560.815.3059")}
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

  describe "#find_trips_for_rider" do
    it "retrieve the list of trip instances that only this rider has taken" do
      rider1.find_trips_for_rider.must_be_instance_of Array
      rider1.find_trips_for_rider.length.must_equal 2
    end
  end

  describe "#find_drivers_by_find_trips_for_rider" do
    it "find_drivers_by_find_trips_for_rider" do
      rider1.find_trips_for_rider
      rider1.find_drivers_by_find_trips_for_rider.length.must_equal 2
    end


  end
end
