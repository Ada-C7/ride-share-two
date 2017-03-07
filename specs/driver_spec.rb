require_relative 'spec_helper'

describe Driver do

     before do
          @id = 3
          @name = "Leia"
          @vin = "VWING33"
          @leia = Driver.new(@id, @name, @vin)
     end

     describe "Driver#initialize" do

          it "Creates class Driver" do
            @leia.must_be_kind_of Driver
          end

          it "Takes ID, name and VIN" do
            @leia.must_respond_to :id
            @leia.id.must_equal @id

            @leia.must_respond_to :name
            @leia.name.must_equal @name

            @leia.must_respond_to :vin
            @leia.vin.must_equal @vin
          end

          it "Verifies VIN is a string, containing no more than 17 characters" do
            proc {Driver.new(@id, @name, 777)
            }.must_raise ArgumentError

            proc {Driver.new(@id, @name, "777333777333777333")
            }.must_raise ArgumentError
          end
     end

     describe "Self#all" do

          before do
               @file = "../support/drivers.csv"
               @all_drivers = Driver.all(@file)
          end

          describe "Driver.all" do
              it "Returns an array of all drivers" do
                   @all_drivers.must_be_kind_of Array
               end

              it "The number of drivers is correct" do
                   lines = File.foreach(@file).count
                   @all_drivers.length.must_equal lines
               end

               it "Everything in the array is a Driver" do
                   @all_drivers.each do | driver |
                       driver.must_be_kind_of Driver
                    end
               end

              it "The ID, name and VIN of the first and last drivers match the CSV file" do
                   @all_drivers[0].id.must_equal IO.readlines(@file).first[0]
                   @all_drivers[0].name.must_equal IO.readlines(@file).first[1]
                   @all_drivers[0].vin.must_equal IO.readlines(@file).first[2]

                   @all_drivers[0].id.must_equal IO.readlines(@file).last[0]
                   @all_drivers[0].name.must_equal IO.readlines(@file).last[1]
                   @all_drivers[0].vin.must_equal IO.readlines(@file).last[2]
               end
          end
     end
end
