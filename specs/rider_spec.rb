require_relative 'spec_helper'

describe "initialize" do

  let(:ok_rider) {Rideshare::Rider.new(rider_id: 1, name: "Margerie Stewart-Baxter", phone_num: "12345678901234567")}

  let(:bad_id) {
    proc{
      Rideshare::Rider.new(rider_id: 'b', name: "Hubert Cumberdale", phone_num: "12345678901234567")}
    }

    let(:no_name) {
      proc{Rideshare::Rider.new(name: "", phone_num: "12345678901234567", id: 1)}
    }


    it "has a rider id, a name of the right types" do
      ok_rider.rider_id.must_be_kind_of Integer
      ok_rider.name.must_be_kind_of String
      ok_rider.phone_num.must_be_kind_of String
    end

    it "raises an argument error if rider_id is not an integer " do
      bad_id.must_raise ArgumentError
    end

    it "raises an argument error if name is not entered" do
      no_name.must_raise ArgumentError
    end
  end


  #
  describe "self.all" do
    let(:all_riders) {Rideshare::Rider.all("support/Riders.csv")}

    it "returns a collection with right number of rows" do
      all_riders.length.must_equal 300
    end

    it "has returns values of the correct class (and no nil values)" do
      all_riders.each do |rider|
        rider.rider_id.must_be_kind_of Integer
        rider.phone_num.must_be_kind_of String
        rider.name.must_be_kind_of String
      end
    end

    it 'has a test value from the csv' do
      all_riders[3].name.must_equal "Ervin Wiza"
    end
  end

  describe "find_Rider" do
    let(:found_rider) {Rideshare::Rider.find_rider('support/Riders.csv', 4)}

    let(:imaginary_Rider) {
      proc {Rideshare::Rider.find_rider('support/Riders.csv', 500)}
    }


    it "finds a specific rider using their numeric ID" do
      found_rider.name.must_equal "Ervin Wiza"
      found_rider.phone_num.must_equal "272-041-9587"
    end


    # it "returns an error if the Rider doesn't exist" do
    #   imaginary_rider.must_raise ArgumentError
    # end
  end


  describe "get_Rider_rating" do
    it "retrieves an average rating for that Rider based on all trips taken" do
    end
  end

  describe "subset_Rider_trips" do
    it "retrieves all the trip instances that the Rider has taken" do
    end
  end
