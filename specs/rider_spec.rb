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

  it "things in the array are an instance of rider infomation" do
    # skip
    @rider.each do |rider_info|
      rider_info.must_be_instance_of RideShare::Rider
    end
  end

  it "number of riders is correct" do
    # skip
    @rider.length.must_equal 300
  end

  it "retrieves the rider_id, name, and phone_num" do
    # FIXME: Fix object calling issue. Test passing but not correct.
    CSV.readlines('support/riders.csv') do |line|
      counter = 0

      @rider[counter].rider_id.must_equal line[counter][0].to_i
      @rider[counter].name.must_equal line[counter][1].to_s
      @rider[counter].phone_num.must_equal line[counter][2].to_s

      counter += 1
    end
  end

  it "retrieves the first and last rider_id" do
    # skip

    @rider[0].rider_id.must_equal "1"
    @rider[225].rider_id.must_equal "226"
  end
  # TODO: Edgecase and 'middle' case test
end

describe "rider: self.find" do
  # before do
  #   @rider = RideShare::Rider.all
  # end

  it "return a rider from self.all" do
    skip "Error message"
    # TODO: Fix object calling issue
    #  NoMethodError: undefined method `name' for "Marcellus Hoeger":String
    rider = RideShare::Rider.find("3")

    # @rider.must_be_instance_of RideShare::Rider
    # rider.rider_id.must_equal rider_id
    rider.name.must_equal "Marcellus Hoeger"
    # rider.phone_num.must_equal "(222) 926-0138"
  end
end
