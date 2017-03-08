require_relative 'spec_helper'

describe "Rider" do
  describe "constructor" do
    before do
      @name = 'Ada'
      @id = 108
      @phone_num = '123.456.7890'
    end

    let (:rider) {RideShare::Rider.new(name: @name, id: @id, phone_num: @phone_num)}

    it "can be instantiated" do
      rider.must_be_instance_of RideShare::Rider
    end

    it "takes a name, phone number, and ID" do
      rider.must_respond_to :name
      rider.name.must_equal @name

      rider.must_respond_to :id
      rider.id.must_equal @id

      rider.must_respond_to :phone_num
      rider.vin.must_equal @phone_num
    end
  end
end
