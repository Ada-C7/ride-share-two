require_relative "spec_helper"
require_relative "../lib/trip"

describe "class Trip" do
  describe "Trip#initialize" do
    before do
      @id = "1"
      @driver_id = "1"
      @rider_id = "54"
      @date = "2016-04-05"
      @rating =  "3"
      @trip1 = RideSharing::Trip.new(@id, @driver_id, @rider_id, @date, @rating)
    end
    it "Trip#initialize: Takes an id, driver_id, rider_id, date and rating as parameters" do

      @trip1.must_respond_to :id
      @trip1.id.must_equal 1

      @trip1.must_respond_to :driver_id
      @trip1.driver_id.must_equal 1

      @trip1.must_respond_to :rider_id
      @trip1.rider_id.must_equal 54

      @trip1.must_respond_to :date
      @trip1.date.must_equal "2016-04-05"

      @trip1.must_respond_to :rating
      @trip1.rating.must_equal 3
    end

    it "Trip#initialize: All parameters are integers except date that is a string" do
      @trip1.id.must_be_kind_of Integer
      @trip1.driver_id.must_be_kind_of Integer
      @trip1.rider_id.must_be_kind_of Integer
      @trip1.date.must_be_kind_of String
      @trip1.rating.must_be_kind_of Integer
    end

  end # End of describe "Trip#initialize"
end # End of describe "class Trip"
