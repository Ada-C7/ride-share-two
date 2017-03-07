require_relative 'spec_helper'

describe "Rider initialize" do
  it "Takes an ID, name, and phone number" do
    id = 1
    name = "Nina Hintz Sr."
    phone_num = "560.815.3059"
    rider = RideShare::Rider.new(id, name, phone_num)

    rider.must_respond_to :id
    rider.id.must_equal id

    rider.must_respond_to :name
    rider.name.must_equal name

    rider.must_respond_to :phone_num
    rider.phone_num.must_equal phone_num
  end
end

describe "Rider.all" do

  before do
    @rider_array = RideShare::Rider.all
  end

  it "Returns an array of all accounts" do
    @rider_array.must_be_instance_of Array
  end
end
