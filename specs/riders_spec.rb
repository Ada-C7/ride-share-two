require_relative 'spec_helper'

describe "rider_id" do
  let(:my_rider) {RideShare::Rider.new(1, 2, 3)}

  describe "Diver#initialize" do
    it "takes an ID, Name, and Phone Number to initialize" do
      my_driver.must_respond_to :id
    end
  end

end
