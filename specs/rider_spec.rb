require_relative 'spec_helper'

describe "Rider Class" do

  describe "Initialize Method" do

    let(:rider) {
        RideShare::Rider.new({
        :id => "1",
        :name => "Nina Hintz Sr.",
        :phone_num => "560.815.3059"
        })
      }


    it "Initializes an object" do
      rider.must_be_instance_of RideShare::Rider
    end

    it "Initializes with an ID, name, and phone number" do
      rider.must_respond_to :id
      rider.must_respond_to :name
      rider.must_respond_to :phone_num
    end
  end

  describe "self.all" do

    let(:riders) {RideShare::Rider.all }

    it "Returns an array" do
      riders.must_be_instance_of Array
    end

    it "Returns an Array with elements" do
      riders.length.must_be :>, 0
    end

    it "Returns an array of rider Objects" do
      riders.each do |rider|
        rider.must_be_instance_of RideShare::Rider
      end
    end

    it "Each rider object contains an id, name and vin" do
      riders.each do |rider|
        rider.must_respond_to :id
        rider.must_respond_to :name
        rider.must_respond_to :phone_num
      end
    end

    it "Contains the correct information" do
      first = riders[0]
      first.name.must_equal "Nina Hintz Sr."
      first.id.must_equal "1"
      first.phone_num.must_equal "560.815.3059"
    end
  end

end
