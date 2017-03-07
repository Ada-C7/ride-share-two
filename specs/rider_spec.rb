require_relative 'spec_helper'
require_relative '../lib/rider'


describe "Rider tests" do
  describe "Rider#initialize" do
    it "takes an id, name, and phone" do
        new_rider = Rider.new("35", "Jane Doe", "702-464-3849")

        new_rider.must_respond_to :id
        new_rider.id.must_equal "35"

        new_rider.must_respond_to :name
        new_rider.name.must_equal "Jane Doe"

        new_rider.must_respond_to :phone
        new_rider.phone.must_equal "702-464-3849"
    end
  end


  describe "Rider.all" do
    it "returns an array of all riders" do
      Rider.all.class.must_equal Array
    end

    it "each element in array is a Rider" do

      Rider.all.each do |element|
        element.must_be_instance_of Rider
      end
    end

  end

end
