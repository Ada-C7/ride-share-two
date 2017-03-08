require_relative 'spec_helper'

describe "Rider" do

  before do
    @args = { rider_id: 1, name: "Nina Hintz Sr.", phone_num: "560.815.3059" }
    @rider = RideShare::Rider.new(@args)
  end

  describe "Rider#initialize" do

    it "Can be initialized" do
      @rider.must_be_instance_of RideShare::Rider
    end

    it "Takes a rider id" do
      @rider.must_respond_to :rider_id
      @rider.rider_id.must_equal @args[:rider_id]
    end

    it "Takes a rider name" do
      @rider.must_respond_to :name
      @rider.name.must_equal @args[:name]
    end

    it "Takes a phone number" do
      @rider.must_respond_to :phone_num
      @rider.phone_num.must_equal @args[:phone_num]
    end

  end

end
