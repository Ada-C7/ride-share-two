require_relative 'spec_helper'
describe "Rider class" do

  it "is an instance of Rider" do
    test_rider = Rider.new({id: 1, name: "Smithy", phone_number: "353-533-5334"})
    test_rider.must_be_kind_of Rider
  end

  describe "Initialize method" do
    it "" do

    end
  end

  describe "get_trips method" do
    it "" do

    end
  end

  describe "get_all_prev_drivers method" do
    it "" do

    end
  end

  describe "self.all method" do
    it "" do

    end
  end

  describe "self.find(id) method" do
    it "" do

    end
  end

end
