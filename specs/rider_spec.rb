require_relative 'spec_helper'

describe Rider do

     before do
          @id = 7
          @name = "Han"
          @phone = "777-777-7777"
          @han = Rider.new(@id, @name, @phone)
     end

     describe "Rider#initialize" do

          it "Creates class Rider:" do
            @han.must_be_kind_of Rider
          end

          it "Takes ID, name and phone:" do
            @han.must_respond_to :id
            @han.id.must_equal @id

            @han.must_respond_to :name
            @han.name.must_equal @name

            @han.must_respond_to :phone
            @han.phone.must_equal @phone
          end

     end

     describe "Self#all" do

          before do
               @file = "support/riders.csv"
               @all_riders = Rider.all(@file)
               @lines = File.foreach(@file).count
          end

          describe "Rider.all" do
              it "Returns an array of all riders:" do
                   @all_riders.must_be_kind_of Array
               end

              it "Returns correct number of riders:" do
                   @all_riders.length.must_equal @lines
               end

               it "Everything in the array is a Rider:" do
                   @all_riders.each do | rider |
                       rider.must_be_kind_of Rider
                    end
               end

              it "The ID, name and phone of the first and last riders match the CSV file" do
                    @all_riders[0].id.to_s.must_equal CSV.readlines(@file)[0][0]
                    @all_riders[0].name.must_equal CSV.readlines(@file)[0][1]
                    @all_riders[0].phone.must_equal CSV.readlines(@file)[0][2]

                    @all_riders[-1].id.to_s.must_equal CSV.readlines(@file)[-1][0]
                    @all_riders[-1].name.must_equal CSV.readlines(@file)[-1][1]
                    @all_riders[-1].phone.must_equal CSV.readlines(@file)[-1][2]
               end
          end
     end

     describe "Self#find" do

          before do
               @file = "support/riders.csv"
               @lines = File.foreach(@file).count
          end

          it "Returns an account that exists:" do
               id = 8
               index = id - 1
               one_rider = Rider.find(@file, id)
               one_rider.must_be_kind_of Rider
               one_rider.id.to_s.must_equal CSV.readlines(@file)[index][0]
          end

          it "Can find the first account from the CSV:" do
               id = 1
               index = id - 1
               first_account = Rider.find(@file, id)
               first_account.must_be_kind_of Rider
               first_account.id.to_s.must_equal CSV.readlines(@file)[index][0]
          end

          it "Can find the last account from the CSV:" do
               id = @lines
               index = id - 1
               first_account = Rider.find(@file, id)
               first_account.must_be_kind_of Rider
               first_account.id.to_s.must_equal CSV.readlines(@file)[index][0]
          end

          it "Raises an error for an account that doesn't exist:" do
               id = @lines + 1
               proc {Rider.find(@file, id)}.must_raise ArgumentError
          end
     end

     describe "Rider#recall_trips" do

          before do
               @file = "support/riders.csv"
               @trip_file = "support/trips.csv"

               @id = 8
               @han = Rider.find(@file, @id)
               @han_trips = @han.recall_trips(@file, @trip_file)
          end

          describe "Rider.recall_trips:" do
               it "Returns an array of all trips for rider:" do
                   @han_trips.must_be_kind_of Array
               end

               it "Returns the correct number of trips:" do
                    count = 0

                    CSV.foreach(@trip_file) do |row|
                         if row[2].to_i == @id then count += 1; end
                    end

                    @han_trips.length.must_equal count
               end

               it "Returns an array of Trip objects with the same Rider ID:" do
                   @han_trips.each do | trip |
                       trip.must_be_kind_of Trip
                       trip.rider_id.must_equal @id
                    end
               end
          end
     end

     describe "Rider#recall_drivers" do

          before do
               @file = "support/riders.csv"
               @trip_file = "support/trips.csv"
               @driver_file = "support/drivers.csv"

               @id = 8
               @han = Rider.find(@file, @id)
               @han_drivers = @han.recall_drivers(@file, @trip_file, @driver_file)
          end

          describe "Rider.recall_drivers:" do
               it "Returns an array of all trips for rider:" do
                   @han_drivers.must_be_kind_of Array
                   @han_drivers.map { | driver | driver.must_be_kind_of Driver}
               end

               it "Returns the correct number of drivers:" do
                    drivers = []

                    CSV.foreach(@trip_file) do |row|

                         if row[2].to_i == @id && drivers.include?(row[1].to_i) != true
                              drivers << row[2].to_i
                         end
                    end

                    @han.drivers.length.must_equal drivers.length
               end
          end
     end
end
