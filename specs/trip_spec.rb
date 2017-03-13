require_relative 'spec_helper.rb'
# require_relative '../lib/module.rb'


describe 'Trip Class Properties' do

   let(:delta_flyer){Rideshare::Trip.new({trip_id:"5", driver_id:"32", rider_id:"34",date:"05-29-2017", rating:"5"})}


#tests that driver class initalizes
  it 'will find trip class' do
    delta_flyer.class.must_equal Rideshare::Trip
  end
  #tests that the trip id instance variable is exposed
  it "user can call Trip.trip_id" do
    delta_flyer.trip_id.must_equal "5"
  end
  #tests that the rider id instance variable is exposed
  it "user can call Trip.rider_id" do
    delta_flyer.rider_id.must_equal "34"
  end

  it "returns an error if the rider has not used the service" do
    proc {
      Rideshare::Trip.new({trip_id:"5", driver_id:"98", rider_id:"304",date:"05-29-2017", rating:"5"}).must_raise StandardError
    }
  end
  #tests that the driver id instance variable is exposed
  it "user can call Trip.driver_id" do
    delta_flyer.driver_id.must_equal "32"
  end

  it "returns an error if the driver has not used the service" do
    proc {
      Rideshare::Trip.new({trip_id:"5", driver_id:"198", rider_id:"298",date:"05-29-2017", rating:"5"}).must_raise StandardError
    }
  end
  #tests that the rating instance variable is exposed
  it "user can call Trip.rating" do
    delta_flyer.rating.must_equal "5"
  end
end

describe "Class Methods for Trip " do

   #tests that you can generate all trip instances from csv
   it "can generate all trip instances from the csv file" do
     Rideshare::Trip.create_trips[0].class.must_equal Rideshare::Trip
     Rideshare::Trip.create_trips.length.must_equal 600
   end
   #tests that you can generate all osf a given driver's trips
   it "can generate all trips for a specific driver_id" do
     array = Rideshare::Trip.find_by_driver(1)
     array[0].class.must_equal Rideshare::Trip

   end
   #tests that you can generate all of a given rider's trips
   it "can generate all trips for a specific driver_id" do
     array = Rideshare::Trip.find_by_rider(1)
     array[0].class.must_equal Rideshare::Trip
   end
   it "returns an error if the rider has not used the service" do
     proc {
       Rideshare::Trip.find_by_rider(340)}.must_raise StandardError
   end
 end

 describe "Instance Methods for Trip" do
  let(:delta_flyer){Rideshare::Trip.new({trip_id:"5", driver_id:"300", rider_id:"34",date:"05-29-2017", rating:"5"})}
  let(:driver12) {Rideshare::Trip.find_by_driver(12)}
  let(:driver1) {Rideshare::Trip.find_by_driver(1)}
  let(:driver99) {Rideshare::Trip.find_by_driver(99)}

     it "reads .driver_id instance method and generates driver object" do
     driver = driver12[0] .make_driver
       driver.driver_id.must_equal "12"
     end

     it "first & last: reads .driver_id instance method and generates driver object" do
     driver = driver1[0].make_driver
     driver.driver_id.must_equal "1"
     driver = driver99[0].make_driver
     driver.driver_id.must_equal "99"

=begin
Wondering why I'm edge testing with Driver 99 instead of Driver 100?!
Tests revealed that Driver #100 had no rides.

**See test below for No Rides test**
 driver = driver100[0].make_driver
 driver.driver_id.must_equal "100"

 This test would have raised the same MissingIdError that is raised below with
 Driver #12
=end
     end

     it "returns an error if a driver has no rides" do
       proc{
          delta_flyer.make_driver
        }.must_raise Rideshare::MissingIdError
     end








 end
