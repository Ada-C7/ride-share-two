require_relative 'spec_helper'

describe "Driver" do
  let(:my_driver) {RideShare::Driver.new(1, 2, 3)}

  describe "Diver#initialize" do
    it "takes an ID, Name, and VIN to initialize" do
      my_driver.must_respond_to :id
    end
  end

end
