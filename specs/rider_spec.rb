require_relative 'spec_helper'

describe "RideShare: Rider" do
  let(:riders) {RideShare::Rider.getAll}

  describe "Rider#initialize" do

  end

  describe "Rider.read_csv" do
    it "returns an array of rider objects" do
      riders
      riders.must_be_kind_of Array
      riders[0].must_be_instance_of RideShare::Rider
    end
  end

  describe "Rider.getAll" do
    it "returns an array of 300 rider objects" do
      riders
      riders.length.must_equal 300
    end

    it "returns correct instances of rider objects" do
      riders
      riders[6].id.must_equal 7
      riders[6].name.must_equal "Emmanuelle Breitenberg"
      riders[6].phone_num.must_equal "(707) 341-7157 x98757"
    end
  end

  describe "Rider.findTrips" do
    it "returns an array of trip objects" do
      riders
      rider = riders[0]
      rider.findTrips.must_be_kind_of Array
      rider.findTrips[0].must_be_instance_of RideShare::Trip
    end
  end
  
  describe "Rider.find(id)" do
    it "returns a rider object" do
      riders
      rider = RideShare::Rider.find(300)
      rider.must_be_kind_of RideShare::Rider
    end

    it "returns a rider object" do
      riders
      rider = RideShare::Rider.find(15)
      rider.id.must_equal 15
      rider.name.must_equal "Miss Lori Okuneva"
      rider.phone_num.must_equal "(317) 197-0404 x7013"
    end
  end
end
