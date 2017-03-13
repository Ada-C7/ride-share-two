require_relative 'spec_helper.rb'


describe 'Rider Class Properties' do

  let(:janeway) {Rideshare::Rider.new({rider_id:"5", name:"tehut", phone_num:"WBWSS52P9NEYLVDE9"})}
  #tests that rider class initalizes
  it 'will find rider class' do
    janeway.class.must_equal Rideshare::Rider
  end
  #tests that the rider id instance variable is exposed
  it "user can call .rider_id" do
    janeway.rider_id.must_equal "5"
  end
  #tests that the rider name instance variable is exposed
  it "user can call rider.name" do
    janeway.name.must_equal "tehut"
  end
  # tests that phone_num number is appropriate length
  it "phone_num  can be called and is appropriate length" do
    janeway.phone_num.length.must_equal 17
  end
  #tests t
end
#
describe "Rider Class Methods " do

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
     Rideshare::Rider.find_rider(300).class.must_equal Rideshare::Rider
   end
end

describe "Rider Instance Methods " do
  let(:janeway) {Rideshare::Rider.new({rider_id:"5", name:"tehut", phone_num:"WBWSS52P9NEYLVDE9"})}
  let(:harry_kim) { Rideshare::Rider.find_rider(81)}
  let (:tuvok) {Rideshare::Rider.find_rider(300)}
   #tests that you can retrieve all of a riders trips
   it "can retrieve all of a rider's trips" do
     janeway.find_my_trips.must_be_kind_of Array
     harry_kim.find_my_trips.must_be_kind_of Array
   end

   it "returns an error if a rider has no trips" do

     proc {
       tuvok.find_my_trips}.must_raise Rideshare::MissingIdError
   end

   it "generates trip objects" do
     janeway.find_my_trips[0].must_be_kind_of Rideshare:: Trip
     harry_kim.find_my_trips

   end

   #tests that you can use those trips to generate the riders
   it "can retrieve driver names" do
     janeway.find_my_drivers.must_be_kind_of Array

   end


   it "generates a list of drivers" do
     janeway.find_my_drivers[0].must_be_kind_of String
   end

   it "generates drivers for the first rider" do
     Rideshare::Rider.find_rider(1).find_my_drivers.must_be_kind_of Array
     Rideshare::Rider.find_rider(1).find_my_drivers[0].must_be_kind_of String
     end

    it "will not create drivers for riders that have not taken trips" do
     proc {
       Rideshare::Rider.find_rider(300).find_my_drivers}.must_raise Rideshare::MissingIdError

       proc {
         Rideshare::Rider.find_rider(300).find_my_drivers}.must_raise Rideshare::MissingIdError
   end

   it"willl not list drivers for riders that do not exist" do
      proc {
        Rideshare::Rider.find_rider(301).find_my_drivers}.must_raise NoMethodError
   end
 end
