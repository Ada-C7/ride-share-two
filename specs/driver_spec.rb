require_relative 'spec_helper.rb'

describe 'Driver Class Properties' do
  let(:janeway) {Rideshare::Driver.new({driver_id:"5", name:"tehut", vin:"WBWSS52P9NEYLVDE9"})}
  one_bad_hash = {driver_id: "12", name:"", vin:"WBWSS52P9NEYLVDE9"}
  two_bad_hash = {driver_id: "", name:"Gul Dukat", vin:"WBWSS52P9NEYLVDE9"}
  three_bad_hash = {driver_id: "12", name:"Gul Dukat", vin:"WBW9NEYLVDE9"}
  four_bad_hash = {driver_id: "1200", name:"Gul Dukat", vin:"WBW9NEYLVDE9"}
  it 'will find driver class' do
    janeway.class.must_equal Rideshare::Driver
  end
  #tests that the driver id instance variable is exposed
  it "user can call Driver.driver_id" do
    janeway.driver_id.must_equal "5"
    janeway.driver_id.to_i.must_be_kind_of Integer
  end
  #tests that the driver name instance variable is exposed
  it "user can call Driver.name" do
    janeway.name.must_equal "tehut"
    janeway.name.must_be_kind_of String
  end
  # tests that vin number is appropriate length
  it "Driver.vin can be called and is appropriate length" do
    janeway.vin.length.must_equal 17
    janeway.vin.must_be_kind_of String
  end
  it "returns an error for bad driver_id data" do
    proc {
      Rideshare::Driver.new(four_bad_hash)
    }.must_raise Rideshare::MissingIdError
  end

  it "returns an error for missing name data" do
  proc {
    Rideshare::Driver.new(one_bad_hash)
  }.must_raise Rideshare::InvalidDataError
  end

  it "returns an error for missing driver_id data" do
    proc {
      Rideshare::Driver.new(two_bad_hash)
    }.must_raise Rideshare::MissingIdError
  end

  it "returns an error for bad vin data" do
    proc {
      Rideshare::Driver.new(three_bad_hash)
    }.must_raise Rideshare::InvalidDataError
  end
end
#
describe "Class Methods for Driver " do
   it "will generate all driver instances" do
     hash = Rideshare::Driver.create_drivers
     hash["1"].class.must_equal Rideshare::Driver
     Rideshare::Driver.create_drivers.length.must_equal 100
  end

  it "will return a hash" do
      hash = Rideshare::Driver.create_drivers
      hash.class.must_equal Hash
   end
   it "can generate a specific driver from their driver_id" do
     Rideshare::Driver.find_driver("77").class.must_equal Rideshare::Driver
   end

   it "can generate a specific driver from their driver_id" do
     Rideshare::Driver.find_driver("77").class.must_equal Rideshare::Driver
   end

   it "will generate the first and last driver without" do
     Rideshare::Driver.find_driver(1).class.must_equal Rideshare::Driver
     Rideshare::Driver.find_driver(100).class.must_equal Rideshare::Driver

   end
end

describe "Instance Methods for Driver " do
  let(:janeway) {Rideshare::Driver.new({driver_id:"37",name:"Arnulfo Anderson",vin:"WBW8W7DC0FJLMYCCR"})}
  let(:tuvok){Rideshare::Driver.find_driver(81)}
  let(:harry_kim) {Rideshare::Driver.find_driver(300)}

  it "will find all my trips by driver" do
    janeway.all_my_trips.class.must_equal Array
  end

  it "returns multiple trips for drivers who've driven multiple trips" do
    tuvok.all_my_trips.length.must_equal 7

  end


 it "calculates driver average rating" do
   janeway.driver_rating.must_equal 3
 end

 it "calculates average driver rating for drivers with multiple rides correctly" do
   tuvok.driver_rating.must_equal 3
   tuvok.driver_rating.must_be_kind_of Integer
 end

 it "does not calculate averages for drivers who have not taken trips" do
   proc {harry_kim.driver_rating}
   .must_raise NoMethodError
 end
end
