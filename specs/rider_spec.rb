require_relative 'spec_helper'

describe "Rider Initialize" do

    it "Takes a Rider ID, name, phone number" do
      rider_id = 318
      name = "Alice"
      phone_num = "(206)634-3400"
      rider = RideShareTwo::Rider.new(rider_id, name, phone_num)

      rider.must_respond_to :rider_id
      rider.rider_id.must_equal rider_id

      rider.must_respond_to :name
      rider.name.must_equal name

      rider.must_respond_to :phone_num
      rider.phone_num.must_equal phone_num
    end

end
