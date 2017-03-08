require_relative 'spec_helper'

describe Trip do

     before do
          @id = 300
          @driver_id = 7
          @rider_id = 3
          @date = "3 March 2017"
          @rating = 5
          @deathstar = Trip.new(@id, @driver_id, @rider_id, @date, @rating)

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
            proc {Trip.new(@id, @rider_id, @driver_id, @date, 0)
            }.must_raise ArgumentError

            proc {Trip.new(@id, @rider_id, @driver_id, @date, 6)
           }.must_raise ArgumentError

            proc {Driver.new(@id, @rider_id, @driver_id, @date, "777333777333777333")
            }.must_raise ArgumentError
          end
     end

     describe "Self#all" do

          before do
               @file = "support/trips.csv"
               @all_trips = Trip.all(@file)
          end

          describe "Trip.all" do
               it "Returns an array of all trips:" do
                   @all_trips.must_be_kind_of Array
               end

              it "Returns correct number of trips:" do
                   lines = File.foreach(@file).count
                   @all_trips.length.must_equal lines
               end

               it "Returns an arry of Trip objects:" do
                   @all_trips.each do | trip |
                       trip.must_be_kind_of Trip
                    end
               end

              it "The ID, Driver ID, Rider ID, date and rating of the first and last trips match the CSV file:" do
                    @all_trips[0].id.to_s.must_equal CSV.readlines(@file)[0][0]
                    @all_trips[0].driver_id.to_s.must_equal CSV.readlines(@file)[0][1]
                    @all_trips[0].rider_id.to_s.must_equal CSV.readlines(@file)[0][2]
                    @all_trips[0].date.must_equal CSV.readlines(@file)[0][3]
                    @all_trips[0].rating.to_s.must_equal CSV.readlines(@file)[0][4]

                    @all_trips[-1].id.to_s.must_equal CSV.readlines(@file)[-1][0]
                    @all_trips[-1].driver_id.to_s.must_equal CSV.readlines(@file)[-1][1]
                    @all_trips[-1].rider_id.to_s.must_equal CSV.readlines(@file)[-1][2]
                    @all_trips[-1].date.must_equal CSV.readlines(@file)[-1][3]
                    @all_trips[-1].rating.to_s.must_equal CSV.readlines(@file)[-1][4]

               end
          end
     end

     describe "Self#find_trips_for_driver" do

          before do
               @driver_file = "support/drivers.csv"
               @file = "support/trips.csv"
               @id = 3
               @driver_trips = Trip.find_trips_for_driver(@driver_file, @file, @id)
          end

          describe "Trip.find_trips_for_driver:" do
               it "Returns an array of all trips for driver:" do
                   @driver_trips.must_be_kind_of Array
               end

               it "Returns the correct number of trips:" do
                    count = 0

                    CSV.foreach(@file) do |row|
                         if row[1].to_i == @id then count += 1; end
                    end

                    @driver_trips.length.must_equal count
               end

               it "Returns an array of Trip objects with the same Driver ID:" do
                   @driver_trips.each do | trip |
                       trip.must_be_kind_of Trip
                       trip.driver_id.must_equal @id
                    end
               end

               it "Raises an error for an account that doesn't exist:" do
                    id = 101
                    proc {Trip.find_trips_for_driver(@driver_file, @file, id)}.must_raise ArgumentError
               end
          end
     end

     describe "Self#find_trips_for_rider" do

          before do
               @rider_file = "support/riders.csv"
               @file = "support/trips.csv"
               @id = 3
               @rider_trips = Trip.find_trips_for_rider(@rider_file, @file, @id)
          end

          describe "Trip.find_trips_for_rider:" do
               it "Returns an array of all trips for rider:" do
                   @rider_trips.must_be_kind_of Array
               end

               it "Returns the correct number of trips:" do
                    count = 0

                    CSV.foreach(@file) do |row|
                         if row[1].to_i == @id then count += 1; end
                    end

                    @rider_trips.length.must_equal count
               end

               it "Returns an array of Trip objects with the same Rider ID:" do
                   @rider_trips.each do | trip |
                       trip.must_be_kind_of Trip
                       trip.rider_id.must_equal @id
                    end
               end

               it "Raises an error for an account that doesn't exist:" do
                    id = 101
                    proc {Trip.find_trips_for_rider(@drider_file, @file, id)}.must_raise ArgumentError
               end
          end
     end
end
