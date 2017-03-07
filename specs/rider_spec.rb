require_relative 'spec_helper'

describe "Rider tests" do
  let(:rider) { RideShare::Rider.new({ id: 8, name: "Galois", phone: "206-555-2468" }) }
  let(:riders_array) { RideShare::Rider.all }
  let(:csv_info) { CSV.read('support/riders.csv') }

  describe "Rider#initialize" do
    it "Takes an ID, name, and phone number" do
      rider.must_respond_to :id
      rider.id.must_equal 8

      rider.must_respond_to :name
      rider.name.must_equal "Galois"

      rider.must_respond_to :phone
      rider.phone.must_equal "206-555-2468"
    end
  end

  describe "Rider.all" do
    it "Rider.all returns an array" do
      riders_array.must_be_instance_of Array
    end

    it "Everything in the array is a Rider" do
      riders_array.each do |rider|
        rider.must_be_instance_of RideShare::Rider
      end
    end

    it "The number of riders is correct" do
      riders_array.length.must_equal csv_info.count - 1
    end

    it "The information for the first & last rider is correct" do
      riders_array[0].id.must_equal csv_info[1][0].to_i
      riders_array[0].name.must_equal csv_info[1][1]
      riders_array[0].phone.must_equal csv_info[1][2]

      riders_array[-1].id.must_equal csv_info[-1][0].to_i
      riders_array[-1].name.must_equal csv_info[-1][1]
      riders_array[-1].phone.must_equal csv_info[-1][2]
    end
  end
end
