require_relative 'spec_helper.rb'

describe 'Rider class properties' do
  let(:my_rider) {Rideshare::Rider.new}
#tests that driver class initalizes
  it 'will find driver class' do
    my_rider.class.must_equal Rideshare::Rider
  end

  #tests that the rider id instance method is exposed


  #tests t
end

describe "Tests class methods for Driver " do
   #tests that you can generate all rider instances from csv
   #tests that you can generate a specific rider from the driver id
   #tests that you can generate the first and last rider from the csv
end

describe "Tests instance methods for Driver " do
  let(:my_driver) {Rideshare::Driver.new}
   #tests that you can retrieve all of a riders trips
   #tests that you can use those trips to generate the drivers
 end
