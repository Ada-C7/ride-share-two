require_relative 'spec_helper'

describe "RideShare::Rider" do

  describe "RideShare::Rider#iniitalize" do

    it "A new rider can be initialized with an id, name, and phone number" do
      new_rider = RideShare::Rider.new(2345, "Some Dude", "800-000-000")
      new_rider.must_be_instance_of RideShare::Rider
    end

  end


  describe "RideShare::Rider#trips" do
  end


  describe "RideShare::Rider#drivers" do
  end


  describe "RideShare::Rider#self.all" do
  end


  describe "RideShare::Rider#self.find" do
  end

end
