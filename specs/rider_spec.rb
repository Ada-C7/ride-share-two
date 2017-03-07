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
          end

          describe "Rider.all" do
              it "Returns an array of all riders:" do
                   @all_riders.must_be_kind_of Array
               end

              it "Returns correct number of riders:" do
                   lines = File.foreach(@file).count
                   @all_riders.length.must_equal lines
               end

               it "Everything in the array is a Rider:" do
                   @all_riders.each do | rider |
                       driver.must_be_kind_of Rider
                    end
               end

              it "The ID, name and VIN of the first and last drivers match the CSV file" do
                    @all_riders[0].id.to_s.must_equal CSV.readlines(@file)[0][0]
                    @all_riders[0].name.must_equal CSV.readlines(@file)[0][1]
                    @all_riders[0].vin.must_equal CSV.readlines(@file)[0][2]

                    @all_riders[-1].id.to_s.must_equal CSV.readlines(@file)[-1][0]
                    @all_riders[-1].name.must_equal CSV.readlines(@file)[-1][1]
                    @all_riders[-1].vin.must_equal CSV.readlines(@file)[-1][2]
               end
          end
     end


end
