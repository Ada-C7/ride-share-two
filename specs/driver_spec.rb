require_relative 'spec_helper'

describe Driver do

     before do
          @id = 3
          @name = "Leia"
          @vin = "VWING33"
          @leia = Driver.new(@id, @name, @vin)
     end

     describe "Driver#initialize" do

          it "Creates class Driver:" do
            @leia.must_be_kind_of Driver
          end

          it "Takes ID, name and VIN:" do
            @leia.must_respond_to :id
            @leia.id.must_equal @id

            @leia.must_respond_to :name
            @leia.name.must_equal @name

            @leia.must_respond_to :vin
            @leia.vin.must_equal @vin
          end

          it "Verifies VIN is a string, containing no more than 17 characters:" do
            proc {Driver.new(@id, @name, 777)
            }.must_raise ArgumentError

            proc {Driver.new(@id, @name, "777333777333777333")
            }.must_raise ArgumentError
          end
     end

     describe "Self#all" do

          before do
               @file = "support/drivers.csv"
               @all_drivers = Driver.all(@file)
               @lines = File.foreach(@file).count

          end

          describe "Driver.all" do
              it "Returns an array of all drivers:" do
                   @all_drivers.must_be_kind_of Array
               end

              it "Returns correct number of drivers:" do
                   @all_drivers.length.must_equal @lines
               end

               it "Returns an array of Driver objects:" do
                   @all_drivers.each do | driver |
                       driver.must_be_kind_of Driver
                    end
               end

              it "Matches the ID, name and VIN of the first and last drivers with the CSV file:" do
                    @all_drivers[0].id.to_s.must_equal CSV.readlines(@file)[0][0]
                    @all_drivers[0].name.must_equal CSV.readlines(@file)[0][1]
                    @all_drivers[0].vin.must_equal CSV.readlines(@file)[0][2]

                    @all_drivers[-1].id.to_s.must_equal CSV.readlines(@file)[-1][0]
                    @all_drivers[-1].name.must_equal CSV.readlines(@file)[-1][1]
                    @all_drivers[-1].vin.must_equal CSV.readlines(@file)[-1][2]
               end
          end
     end

     describe "Self#find" do

          before do
               @file = "support/drivers.csv"
               @lines = File.foreach(@file).count
          end

          it "Returns an account that exists:" do
               id = 8
               index = id - 1
               one_driver = Driver.find(@file, id)
               one_driver.must_be_kind_of Driver
               one_driver.id.to_s.must_equal CSV.readlines(@file)[index][0]
          end

          it "Can find the first account from the CSV:" do
               id = 1
               index = id - 1
               first_account = Driver.find(@file, id)
               first_account.must_be_kind_of Driver
               first_account.id.to_s.must_equal CSV.readlines(@file)[index][0]
          end

          it "Can find the last account from the CSV:" do
               id = @lines
               index = id - 1
               first_account = Driver.find(@file, id)
               first_account.must_be_kind_of Driver
               first_account.id.to_s.must_equal CSV.readlines(@file)[index][0]
          end

          it "Raises an error for an account that doesn't exist:" do
               id = @lines + 1
               proc {Driver.find(@file, id)}.must_raise ArgumentError
          end
     end

     describe "Driver#recall_trips" do

          before do
               @file = "support/drivers.csv"
               @trip_file = "support/trips.csv"
               @id = 7
               @leia = Driver.find(@file, @id)
               @leia_trips = @leia.recall_trips(@file, @trip_file)
          end

          describe "Driver.recall_trips:" do
               it "Returns an array of all trips for driver:" do
                   @leia_trips.must_be_kind_of Array
               end

               it "Returns the correct number of trips:" do
                    count = 0

                    CSV.foreach(@trip_file) do |row|
                         if row[1].to_i == @id then count += 1; end
                    end

                    @leia_trips.length.must_equal count
               end

               it "Returns an array of Trip objects with the same Driver ID:" do
                   @leia_trips.each do | trip |
                       trip.must_be_kind_of Trip
                       trip.driver_id.must_equal @id
                    end
               end
          end
     end

     describe "Driver#calculate_average_rating" do

          before do
               @file = "support/drivers.csv"
               @trip_file = "support/trips.csv"
               @id = 7
               @leia = Driver.find(@file, @id)
               @leia.calculate_average_rating(@file, @trip_file)
          end

          describe "Driver.calculate_average_rating:" do
               it "Returns an integer:" do
                   @leia.average_rating.must_be_kind_of Integer
               end

               it "Returns the average:" do
                    count = 0
                    csv_ratings = []

                    CSV.foreach(@trip_file) do |row|
                         if row[1].to_i == @id then count += 1; end
                    end

                    CSV.foreach(@trip_file) do |row|
                         if row[1].to_i == @id then csv_ratings << row[4].to_i; end
                    end

                    csv_average_rating = csv_ratings.inject { | sum, rating | sum + rating}/count

                    @leia.average_rating.must_equal csv_average_rating
               end
          end
     end
end
