# TODO: Make sure array is picking values correctly.

require_relative 'spec_helper.rb'


describe "retrieve an array from self.all" do
  before do
    # TODO: update to let()
    @rider = RideShare::Rider.all
  end
  it "retrieve an array" do
    @rider.must_be_instance_of Array
  end

  it "retrieves the rider_id, name, phone_num, and new_rider" do
    CSV.read('support/riders.csv') do |line|
      counter = 0

      @rider[counter][0].rider_id.must_equal line[counter][0].to_i
      @rider[counter][1].name.must_equal line[counter][1].to_i
      @rider[counter][2].phone_num.must_equal line[counter][2].to_i
      @rider[counter][3].new_rider.must_equal line[counter][3].to_s
    end
  end
end
