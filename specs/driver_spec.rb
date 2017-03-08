require_relative 'spec_helper.rb'

describe "retrieve an array from self.all" do
  before do
    # TODO: update to let()
    @driver = RideShare::Driver.all
  end
  it "retrieve an array" do
    @driver.must_be_instance_of Array
  end
end
