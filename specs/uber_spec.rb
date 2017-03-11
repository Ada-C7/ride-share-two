require_relative 'spec_helper'

describe RideShare::Uber do
  describe "self.fare" do
    it "Calculates a fare given distance and duration" do
      duration = 10
      distance = 5
      RideShare::Uber.fare(duration, distance).must_equal 12.15
    end

    it "Returns the min fare if the calculated fare is less than the minimum" do
      duration = 1
      distance = 1
      RideShare::Uber.fare(duration, distance).must_equal 5.15
    end
  end
end
