require_relative 'spec_helper.rb'

describe 'Driver class properties' do
  let(:my_driver) {Rideshare::Driver.new}
#tests that driver class initalizes
  it 'will find driver class' do
    my_driver.class.must_equal Rideshare::Driver
  end

  #tests that the driver id instance method is exposed

  # tests that vin number is appropriate length

  #tests t
end

describe "Tests class methods for Driver " do
   #tests that you can generate all driver instances from csv
   #tests that you can generate a specific driver from the driver id
   #tests that you can generate the first and last driver from the csv
end

describe "Tests instance methods for Driver " do
  let(:my_driver) {Rideshare::Driver.new}
   #tests that you can retrieve all of a drivers trips
   #tests that you can use those trips to generate the driver's average rating
 end
 
