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
               id = 100
               index = id - 1
               first_account = Rider.find(@file, id)
               first_account.must_be_kind_of Rider
               first_account.id.to_s.must_equal CSV.readlines(@file)[index][0]
          end

          it "Raises an error for an account that doesn't exist:" do
               id = 9033
               proc {Rider.find(@file, id)}.must_raise ArgumentError
          end

     end
end
