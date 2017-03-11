require_relative 'spec_helper'

describe "RideShare: Rider" do
  let(:riders) {RideShare::Rider.all}

  describe "Rider#initialize" do
    #   # it "contains individual hashes of ID, Name, VIN" do
    #   #   ada_drivers = RideShare::Drivers.new
    #   #   ada_drivers[0].must_be_kind_of Hash
    #   #   ada_drivers[0].key.must_equal
    #   # end
  end

  describe "Rider.read_csv" do
    it "returns an array of rider objects" do
      riders
      riders.must_be_kind_of Array
      riders[0].must_be_instance_of RideShare::Rider
    end
  end

  describe "Rider.all" do
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

  describe "Rider.find_trips" do
    it "returns an array of trips" do
    skip
      riders
      trips = riders[0].find_trips
      trips.must_be_kind_of Array
    end

  end

  # describe "Driver.avg_ratings" do
  #
  # end
  #
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
