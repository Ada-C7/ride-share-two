require_relative '../specs/spec_helper.rb'

describe "Rider" do

  describe "Rider#initialize" do

    let(:new_rider) {RideShare::Rider.new(1, "Nina Hintz Sr.", "560.815.3059")}

    it "Should create an instance of rider " do
      new_rider.must_be_instance_of RideShare::Rider
    end
  end
end
