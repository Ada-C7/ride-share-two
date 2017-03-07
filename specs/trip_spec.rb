require_relative 'spec_helper.rb'

describe 'Trip class properties' do
  let(:my_trip) {Rideshare::Trip.new}
#tests that driver class initalizes
  it 'will find driver class' do
    my_trip.class.must_equal Rideshare::Trip
  end
  #tests that the trip id instance variable is exposed
  #tests that the rider id instance variable is exposed
  #tests that the driver id instance variable is exposed

  #tests that the trip instance variable is exposed
end

describe "Tests class methods for Driver " do
   #tests that you can generate all trip instances from csv
   #tests that you can generate a specific trip for a given driver id
   #tests that you can generate a specific trip for a given rider id
end

describe "Tests instance methods for Driver " do
  let(:my_driver) {Rideshare::Driver.new}
   #tests that you can call the associated driver from a trip object
   #tests that you can call the associated driver from a trip object
 end
