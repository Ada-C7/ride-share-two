# TODO: Make sure array is picking values correctly.

require_relative 'spec_helper.rb'


describe "rider: self.all" do
  before do
    # TODO: update to let()
    @rider = RideShare::Rider.all
  end
  it "retrieve an array" do
    @rider.must_be_instance_of Array
  end

  it "retrieves the rider_id, name, and phone_num" do
    # TODO: Fix object calling issue. Test passing but not correct.
    CSV.read('support/riders.csv') do |line|
      counter = 0

      @rider[counter].must_equal line[counter][0].to_i
      @rider[counter].must_equal line[counter][1].to_s
      @rider[counter].must_equal line[counter][2].to_s

      counter += 1
    end
  end

  it "retrieves the first and last rider_id" do
    # skip
    # TODO: Fix object calling issue.

    @rider[0][0].must_equal "1"
    @rider[225][0].must_equal "226"
  end

end
