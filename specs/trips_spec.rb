# require_relative 'spec_helper'
# # require 'simplecov'
# # SimpleCov.start
# #
# # require 'rake/testtask'
# # require 'minitest'
# # require 'minitest/autorun'
# # require 'minitest/reporters'
# # require_relative '../lib/Trips'
# #
# # Minitest::Reporters.use!
# # Minitest::Reporters::SpecReporter.new
#
# describe "RideShare: Trips" do
#   let(:trips) {RideShare::Trip.all}
#
#   describe "Trips#initialize" do
#     #   # it "contains individual hashes of ID, Name, VIN" do
#     #   #   ada_drivers = RideShare::Drivers.new
#     #   #   ada_drivers[0].must_be_kind_of Hash
#     #   #   ada_drivers[0].key.must_equal
#     #   # end
#   end
#
#   describe "Trip.read_csv" do
#     it "returns an array of Trip" do
#       trips
#       trips.must_be_kind_of Array
#     end
#
#     it "returns a hash of trips details" do
#       trips
#       trips[0].must_be_kind_of Hash
#       trips[0].keys.must_equal [:id, :driver_id, :rider_id, :date, :rating]
#     end
#   end
#
#   describe "Trips.all" do
#
#     it "returns an array of 300 driver objects" do
#       RideShare::Trip.all.length.must_equal 600
#     end
#   end
#   # #
#   # # describe "Drivers.find_trips" do
#   # #
#   # # end
#   # #
#   # # describe "Driver.avg_ratings" do
#   # #
#   # # end
#   # #
#   describe "trips.find(id)" do
#     it "returns a hash of a trip" do
#       trips = RideShare::Trip.find(300)
#       trips.must_be_kind_of Hash
#     end
#
#     it "returns the correct details of the trip" do
#       trip_id = {:id => 254, :driver_id => 4, :rider_id => 37, :date => "2015-08-17", :rating => 3}
#       trips = RideShare::Trip.find(254)
#       trips.must_equal trip_id
#     end
#   end
#
#   describe "Trips#find_driver_trips(driver_id)" do
#     it "returns an array" do
#       driver_trips = RideShare::Trip.find_driver_trips(26)
#       driver_trips.must_be_kind_of Array
#     end
#
#     # it "returns the correct number of trips" do
#     #
#     # end
#   end
#
#   describe "Trips#find_rider_trips(rider_id)" do
#     it "returns an array" do
#       rider_trips = RideShare::Trip.find_rider_trips(1)
#       rider_trips.must_be_kind_of Array
#     end
#
#     # it "returns the correct number of trips" do
#     #
#     # end
#   end
#
# end
# # end
