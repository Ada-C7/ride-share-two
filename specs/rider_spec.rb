require_relative 'spec_helper'
describe "Rider class" do

  it "is an instance of Rider" do
    test_rider = Rider.new({id: 1, name: "Smithy", phone_number: "353-533-5334"})
    test_rider.must_be_kind_of Rider
  end

  describe "Initialize method" do
    it "" do
      # what goes here? nothing?
    end
  end

  describe "get_trips method" do
    it "returns an array of trips" do

    end
    it "each item in array is a Trip instance" do

    end
  end

  describe "get_all_prev_drivers method" do
    it "returns an array" do

    end
    it "all items in array are Driver instances" do

    end
    it "list should not have any duplicates" do
      # is this necessary?
    end
  end

  describe "self.all method" do
    it "returns an array" do
      all_riders = Rider.all
      all_riders.must_be_kind_of Array
    end
    it "all elements are Rider instances" do
      all_riders = Rider.all
      all_riders.each do |rider|
        rider.must_be_kind_of Rider
      end
    end
  end

  describe "self.find(id) method" do
    it "returns a Rider instance" do
      Rider.find(1).must_be_kind_of Rider
    end
    it "Rider's id matches the id passed in" do
      id = 1
      rider = Rider.find(id)
      rider.id.must_equal id
    end
    it "raises an error if no Rider returned" do
      proc {Rider.find(301)}.must_raise ArgumentError
    end
  end

end
