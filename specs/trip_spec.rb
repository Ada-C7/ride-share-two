require_relative 'spec_helper.rb'

describe "retrieve an array from self.all" do
  before do
    # TODO: update to let()
    @trip = RideShare::Trip.all
  end
  it "retrieve an array" do
    @trip.must_be_instance_of Array
  end
end
