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

end
