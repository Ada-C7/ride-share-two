require_relative '../specs/spec_helper.rb'

describe "Rider" do

  describe "Rider#initialize" do

    let(:new_rider) {RideShare::Rider.new(1, "Nina Hintz Sr.", "560.815.3059")}

    it "Should create an instance of rider " do
      new_rider.must_be_instance_of RideShare::Rider
    end

    it "Should be associated with :id, :name, and :phone_num" do
      new_rider.must_respond_to(:id)
      new_rider.must_respond_to(:name)
      new_rider.must_respond_to(:phone_num)
    end
  end

  describe "Rider#all" do

    it "Should create instances of riders and their associated data" do
      RideShare::Rider.all.must_be_kind_of Array
    end
  end

  describe "Rider#find" do

    it "Should return the first account from the CSV file" do
      RideShare::Rider.find(1).id.must_equal(1)
      RideShare::Rider.find(1).name.must_equal("Nina Hintz Sr.")
      # binding.pry
      RideShare::Rider.find(1).phone_num.must_equal("560.815.3059")
    end
end
end
