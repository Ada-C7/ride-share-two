require_relative 'spec_helper'

# Try to use let! :) instead of before
describe "Rider class" do
  let(:riding) { RideShare::Rider.new(id: 1337, name: "bob", phone_number: "123.456.789") }

  describe "Rider#initialize" do
    it "It takes a rider_hash argument" do
      riding.must_be_instance_of RideShare::Rider
    end

    it "Has the correct values that were passed" do
      riding.id.must_equal 1337
      riding.name.must_equal "bob"
      riding.phone_number.must_equal "123.456.789"
    end
  end

  xdescribe "Rider.all" do
    it "" do

    end
  end

  xdescribe "Rider.find" do
    it "" do

    end
  end

  xdescribe "Rider#trip" do
    it "" do
    end
  end

end
