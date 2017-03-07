require_relative 'spec_helper'

describe "Rider tests" do
  let(:rider) { RideShare::Rider.new({ id: 8, name: "Galois", phone: "206-555-2468" }) }

  describe "Rider#initialize" do
    it "Takes an ID, name, and phone number" do
      rider.must_respond_to :id
      rider.id.must_equal 8

      rider.must_respond_to :name
      rider.name.must_equal "Galois"

      rider.must_respond_to :phone
      rider.phone.must_equal "206-555-2468"
    end
  end

end
