require_relative 'spec_helper.rb'


describe 'Tests Rider Class Properties' do
  
  let(:my_rider) {Rideshare::Rider.new({rider_id:"5", name:"tehut", phone_num:"WBWSS52P9NEYLVDE9"})}
  #tests that rider class initalizes
  it 'will find rider class' do
    my_rider.class.must_equal Rideshare::Rider
  end
  #tests that the rider id instance variable is exposed
  it "user can call .rider_id" do
    my_rider.rider_id.must_equal "5"
  end
  #tests that the rider name instance variable is exposed
  it "user can call rider.name" do
    my_rider.name.must_equal "tehut"
  end
  # tests that phone_num number is appropriate length
  it "phone_num  can be called and is appropriate length" do
    my_rider.phone_num.length.must_equal 17
  end
  #tests t
end
#
describe "Tests Class Methods for Rider " do

   #tests that you can generate all rider instances from csv
   it "will generate all rider instances" do
     Rideshare::Rider.create_rider["1"].class.must_equal Rideshare::Rider
     Rideshare::Rider.create_rider.length.must_equal 300
  end
   #tests that you can generate a specific rider from the rider id
   it "can generate a specific rider from their rider_id" do
     Rideshare::Rider.find_rider(23).class.must_equal Rideshare::Rider

   end
   #tests that you can generate the first and last rider from the csv
   it "will generate the first and last rider without" do
     Rideshare::Rider.find_rider(1).class.must_equal Rideshare::Rider
     Rideshare::Rider.find_rider(100).class.must_equal Rideshare::Rider

   end
end

describe "Tests instance methods for Rider " do

  let(:my_rider) {Rideshare::Rider.new}
   #tests that you can retrieve all of a riders trips
   #tests that you can use those trips to generate the riders
 end
