# require_relative 'spec_helper.rb'
#
# describe 'Tests Driver Class Properties' do
#   let(:my_driver) {Rideshare::Driver.new({driver_id:"5", name:"tehut", vin:"WBWSS52P9NEYLVDE9"})}
#   #tests that driver class initalizes
#   it 'will find driver class' do
#     my_driver.class.must_equal Rideshare::Driver
#   end
#   #tests that the driver id instance variable is exposed
#   it "user can call Driver.driver_id" do
#     my_driver.driver_id.must_equal "5"
#   end
#   #tests that the driver name instance variable is exposed
#   it "user can call Driver.name" do
#     my_driver.name.must_equal "tehut"
#   end
#   # tests that vin number is appropriate length
#   it "Driver.vin can be called and is appropriate length" do
#     my_driver.vin.length.must_equal 17
#   end
#   #tests t
# end
# #
# describe "Tests Class Methods for Driver " do
#    #tests that you can generate all driver instances from csv
#    it "will generate all driver instances" do
#      Rideshare::Driver.create_drivers["1"].class.must_equal Rideshare::Driver
#      Rideshare::Driver.create_drivers.length.must_equal 100
#   end
#    #tests that you can generate a specific driver from the driver id
#    it "can generate a specific driver from their driver_id" do
#      Rideshare::Driver.find_driver(23).class.must_equal Rideshare::Driver
#
#    end
#    #tests that you can generate the first and last driver from the csv
#    it "will generate the first and last driver without" do
#      Rideshare::Driver.find_driver(1).class.must_equal Rideshare::Driver
#      Rideshare::Driver.find_driver(100).class.must_equal Rideshare::Driver
#
#    end
# end
# #
# # describe "Tests instance methods for Driver " do
# #   let(:my_driver) {Rideshare::Driver.new}
# #    #tests that you can retrieve all of a drivers trips
# #    #tests that you can use those trips to generate the driver's average rating
#  #
#  # it "calculates driver average rating" do
#  #   driver = driver12[0].make_driver
#  #   driver.driver_rating
#  # end
# #  end
