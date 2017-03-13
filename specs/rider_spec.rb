require_relative 'spec_helper'
describe "Rider class" do

  it "is an instance of Rider" do
    test_rider = Rider.new({id: 1, name: "Smithy", phone_number: "353-533-5334"})
    test_rider.must_be_kind_of Rider
  end

  describe "get_trips method" do
    before do
      @rider = Rider.new(id: 9, name: "Merl Glover III", phone_number: "1-602-620-2330 x3723")
    end
    it "returns an array of trips" do
      @rider.get_trips.must_be_kind_of Array
    end
    it "each item in array is a Trip instance" do
      @rider.get_trips.each do |trip|
        trip.must_be_kind_of Trip
      end
    end
    it "all Trips must have the same Rider id" do
      @rider.get_trips.each do |trip|
        trip.rider_id.must_equal 9
      end
    end
  end

  describe "get_all_prev_drivers method" do
    before do
      @rider = Rider.new(id: 9, name: "Merl Glover III", phone_number: "1-602-620-2330 x3723")
    end
    it "returns an array" do
      @rider.get_all_prev_drivers.must_be_kind_of Array
    end
    it "all items in array are Driver instances" do
      @rider.get_all_prev_drivers.each do |driver|
        driver.must_be_kind_of Driver
      end
    end
  end

  describe "self.all method" do
    let(:all_riders) {Rider.all("support/riders.csv")}
    it "returns an array" do
      all_riders.must_be_kind_of Array
    end
    it "all elements are Rider instances" do
      all_riders.each do |rider|
        rider.must_be_kind_of Rider
      end
    end
    it "grabs first line of data from csv" do
      test_rider = nil
      test_rider = all_riders.find {|rider| rider.id == 1}
      test_rider.must_be_kind_of Rider
    end
    it "grabs last line of data from csv" do
      test_rider = nil
      test_rider = all_riders.find {|rider| rider.id == 300}
      test_rider.name.must_equal "Miss Isom Gleason"
    end
    it "grabs random middle line of data from csv" do
      test_rider = nil
      test_rider = all_riders.find {|rider| rider.id == 153}
      test_rider.phone_number.must_equal "1-227-712-3316 x290"
    end
    it "raises no data error if no riders in csv" do
      proc {Rider.all("support/empty.csv")}.must_raise NoDataError
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
