require_relative 'spec_helper.rb'

describe 'Trip Class Properties' do
  let(:my_trip){Rideshare::Trip.new({trip_id:"5", driver_id:"32", rider_id:"34",date:"05-29-2017", rating:"5"})}


#tests that driver class initalizes
  it 'will find trip class' do
    my_trip.class.must_equal Rideshare::Trip
  end
  #tests that the trip id instance variable is exposed
  it "user can call Trip.trip_id" do
    my_trip.trip_id.must_equal "5"
  end
  #tests that the rider id instance variable is exposed
  it "user can call Trip.rider_id" do
    my_trip.rider_id.must_equal "34"
  end

  it "returns an error if the rider has not used the service" do
    proc {
      Rideshare::Trip.new({trip_id:"5", driver_id:"98", rider_id:"304",date:"05-29-2017", rating:"5"}).must_raise StandardError
    }
  end
  #tests that the driver id instance variable is exposed
  it "user can call Trip.driver_id" do
    my_trip.driver_id.must_equal "32"
  end

  it "returns an error if the driver has not used the service" do
    proc {
      Rideshare::Trip.new({trip_id:"5", driver_id:"198", rider_id:"298",date:"05-29-2017", rating:"5"}).must_raise StandardError
    }
  end
  #tests that the rating instance variable is exposed
  it "user can call Trip.rating" do
    my_trip.rating.must_equal "5"
  end
end

describe "Class Methods for Trip " do
   #tests that you can generate all trip instances from csv
   it "can generate all trip instances from the csv file" do
     Rideshare::Trip.create_trips["1"].class.must_equal Rideshare::Trip
     Rideshare::Trip.create_trips.length.must_equal 600
   end
   #tests that you can generate all osf a given driver's trips
   it "can generate all trips for a specific driver_id" do
     array = Rideshare::Trip.find_by_driver(1).keys
     Rideshare::Trip.find_driver(1)[array[0]].class.must_equal Rideshare::Trip

   end
   #tests that you can generate all of a given rider's trips
   it "can generate all trips for a specific driver_id" do
     array = Rideshare::Trip.find_by_rider(1)
     array[0].class.must_equal Rideshare::Trip
   end
   it "returns an error if the rider has not used the service" do
     proc {
       Rideshare::Trip.find_by_rider(340).must_equal}.raise StandardError
       puts Rideshare::Trip.find_by_rider(340)
   end
 end

 describe "Instance Methods for Trip" do
   let(:driver12) {Rideshare::Trip.find_by_driver(12)}
   it "retrives driver object from driver id on trip file" do
     driver = driver12[0].make_driver
     driver(@driver_id).must_equal "12"
   end
 end
