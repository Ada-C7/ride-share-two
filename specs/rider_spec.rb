require 'pry'
require_relative 'spec_helper'
require_relative '../lib/rider'

describe "Rider" do

  describe "#initialize" do
    it "Takes an ID, name, and phone number" do
      name = "Louise Belcher"
      id = 12345
      phone_num = "(206) 222 222"
      rider = Rider.new(id, name, phone_num)
      
      rider.must_respond_to :id
      rider.id.must_equal id

      rider.must_respond_to :name
      rider.name.must_equal name

      rider.must_respond_to :phone_num
      rider.phone_num.must_equal phone_num
    end

    it "Is a kind of Driver" do
      name = "Louise Belcher"
      id = 12345
      phone_num = "(206) 222 222"
      rider = Rider.new(id, name, phone_num)

      rider.must_be_kind_of Rider
    end
  end
end
