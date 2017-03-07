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
          end

          describe "Driver.all" do
              it "Returns an array of all drivers:" do
                   @all_drivers.must_be_kind_of Array
               end

              it "Returns correct number of drivers:" do
                   lines = File.foreach(@file).count
                   @all_drivers.length.must_equal lines
               end

               it "Everything in the array is a Driver:" do
                   @all_drivers.each do | driver |
                       driver.must_be_kind_of Driver
                    end
               end

              it "The ID, name and VIN of the first and last drivers match the CSV file" do
                   @all_drivers[0].id.to_s.must_equal CSV.foreach(@file).first[0]
                   @all_drivers[0].name.must_equal CSV.foreach(@file).first[1]
                   @all_drivers[0].vin.must_equal CSV.foreach(@file).first[2]

               #     @all_drivers[0].id.to_s.must_equal CSV.foreach(@file).last[0]
               #     @all_drivers[0].name.must_equal CSV.foreach(@file).last[1]
               #     @all_drivers[0].vin.must_equal CSV.foreach(@file).last[2]
               end
          end
     end

     describe "Self#find" do

          before do
               @file = "support/drivers.csv"
               @one_driver = Driver.find(@file, id)
          end

          it "Returns an account that exists" do
               id = 7
               @one_driver = Driver.find(@file, id)
               @one_driver.must_be_kind_of Driver
               @one_driver.id.must_equal CSV.readlines(@file)[index - 1][1]
          end

          it "Can find the first account from the CSV" do
               index = 0
               first_account = Driver.find_with_index(@file, index)
               first_account.must_be_kind_of Driver
               find_account.id.must_equal CSV.readlines(@file)[index][1]

          end

          it "Can find the last account from the CSV" do
               index = -1
               last_account = Driver.find_with_index(@file, index)
               last_account.must_be_kind_of Driver
               last_account.id.must_equal CSV.readlines(@file)[index][1]

          end

          it "Raises an error for an account that doesn't exist" do
               id = 9033
               proc {@one_driver}.must_raise ArgumentError
          end

     end
end
