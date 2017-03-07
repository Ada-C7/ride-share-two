require_relative 'spec_helper'

describe Trip do

     before do
          @id = 300
          @rider_id = 3
          @driver_id = 7
          @date = "3 March 2017"
          @rating = 5
          @deathstar = Trip.new(@id, @rider_id, @driver_id, @date, @rating)

     end

     describe "Trip#initialize" do

          it "Creates class Trip:" do
            @deathstar.must_be_kind_of Trip
          end

          it "Takes ID, rider ID, driver ID, date and rating" do
            @deathstar.must_respond_to :id
            @deathstar.id.must_equal @id

            @deathstar.must_respond_to :rider_id
            @deathstar.rider_id.must_equal @rider_id

            @deathstar.must_respond_to :driver_id
            @deathstar.driver_id.must_equal @driver_id

            @deathstar.must_respond_to :date
            @deathstar.date.must_equal @date

            @deathstar.must_respond_to :rating
            @deathstar.rating.must_equal @rating
          end

          it "Verifies rating is an integer, between and including 1 - 5:" do
            proc {Trip.new(@id, @rider_id, @driver_id, @date, 777)
            }.must_raise ArgumentError

            proc {Driver.new(@id, @rider_id, @driver_id, @date, "777333777333777333")
            }.must_raise ArgumentError
          end
     end
end
