require_relative 'spec_helper'

describe "Loadable Class" do
  it "has a class method to call CSVs that returns an Array of objects" do
    # skip
    RideShare::Driver.all.must_be_kind_of Array
  end

  it "can find the correct data when passed the driver CSV" do
    RideShare::Driver.find(100).name.must_equal "Minnie Dach"
  end

  it "can find the correct data when passed the rider CSV" do
    RideShare::Rider.find(1).phone_num.must_equal "560.815.3059"
  end

  it "can find the correct data when passed the trips CSV" do
    skip
  end
end
