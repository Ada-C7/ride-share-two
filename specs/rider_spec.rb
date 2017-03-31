require_relative 'spec_helper'

describe "Trip" do
  describe "initialize" do

    let(:ok_rider) {Rideshare::Rider.new({ rider_id: 1, name: "Ms. Acceptable Rider",phone_num: "555-555-5555"}, :rider_id) }

    let(:no_name_rider) {Rideshare::Rider.new({ rider_id: 1, phone_num: "555-555-5555"} ) }

    let(:no_id_rider) {Rideshare::Rider.new({ name: "Mr. Mystery ID",  phone_num: "555-555-5555"} ) }

    let(:no_phone_rider) {Rideshare::Rider.new({ rider_id: 1, name: "Dr. No Digits"}, :rider_id) }


    it "creates instance variables rider id, name, and phone_num with proper formatting " do
      ok_rider.rider_id.must_be_kind_of Integer
      ok_rider.name.must_be_kind_of String
      ok_rider.phone_num.must_be_kind_of String
    end

    it "properly stores the search variable as :id" do
      ok_rider.id.must_equal ok_rider.rider_id
    end

    it "raises an argument error if rider_id, name, or phone_num are missing" do
      proc{no_name_rider}.must_raise ArgumentError
      proc{no_id_rider}.must_raise ArgumentError
      proc{no_phone_rider}.must_raise ArgumentError
    end
  end

  describe "all" do
    let(:all_riders) {Rideshare::Rider.all(:rider_id)}

    it "returns a collection with right number of rows" do
      all_riders.length.must_equal 300
    end

    it 'returns right values for first line in csv' do
      all_riders[0].name.must_equal "Nina Hintz Sr."
      all_riders[0].rider_id.must_equal 1
      all_riders[0].phone_num.must_equal  "560.815.3059"
    end

    it 'returns right values for last line in csv' do
      all_riders.last.name.must_equal "Miss Isom Gleason"
      all_riders.last.rider_id.must_equal 300
      all_riders.last.phone_num.must_equal  "791-114-8423 x70188"
    end
  end

  describe "drivers_for_rider" do
    let(:first_rider) {Rideshare::Rider.drivers_for_rider(:rider_id, 1)}

    let(:last_rider) {Rideshare::Rider.drivers_for_rider(:rider_id, 300)}

    let(:imaginary_rider) {Rideshare::Rider.drivers_for_rider(:rider_id, 500)}

    # let(:double_rider) {Rideshare::Rider.find_records(':rider_id, 94)}

    it "finds the first rider from the csv using their numeric ID" do
      first_rider[0].name.must_equal "Nina Hintz Sr."
      first_rider[0].rider_id.must_equal 1
      first_rider[0].phone_num.must_equal "560.815.3059"
    end

    it "finds the last rider from the csv using their numeric ID" do
      last_rider.last.name.must_equal "Miss Isom Gleason"
      last_rider.last.rider_id.must_equal 300
      last_rider.last.phone_num.must_equal  "791-114-8423 x70188"
    end

    it "returns only one rider for first and last" do
      last_rider.length.must_equal 1
      first_rider.length.must_equal 1
    end

    it "returns empty array if the rider does not exist" do
      imaginary_rider.must_be_empty
    end
  end

  describe "drivers for rider" do
    let(:first_rider_drivers) {Rideshare::Rider.drivers_for_rider(1)}

    let(:last_rider_drivers) {Rideshare::Rider.drivers_for_rider(300)}


    it "returns the correct drivers for the first rider" do

      first_rider_drivers.length.must_equal 2

      first_rider_drivers.map!{ |driver| driver.name}
      first_rider_drivers.sort.must_equal ["Federico Bins V", "Ms. Winston Emard"]
    end


    it "returns the correct drivers for the last driver" do

      last_rider_drivers.length.must_equal 1
      last_rider[0].name.must_equal "Charley Kiehn"
    end


  end

end
