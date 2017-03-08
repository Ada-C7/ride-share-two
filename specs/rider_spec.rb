require_relative '../specs/spec_helper'

describe "RideShare::Rider" do

  let(:new_rider_hash) { {id:42, name:'Marcelina Howe', phone: '656-421-8363 x85791'} }
  let(:new_rider) {RideShare::Rider.new(new_rider_hash)}

  describe "RideShare::Rider#initialize" do

    it "Creates a new instance of Rider class" do
      new_rider.must_be_instance_of RideShare::Rider
    end

    it "Takes a argument hash and assigns an id, name, and phone number" do
      new_rider.must_respond_to :id
      new_rider.id.must_equal new_rider_hash[:id]

      new_rider.must_respond_to :name
      new_rider.name.must_equal new_rider_hash[:name]

      new_rider.must_respond_to :phone
      new_rider.phone.must_equal new_rider_hash[:phone]
    end
  end


  describe "RideShare::Rider.all" do

    it "Returns an array of Rider instances" do
      RideShare::Rider.all.must_be_instance_of Array, "Not an array."
      RideShare::Rider.all.each do |rider|
        rider.must_be_instance_of   RideShare::Rider, "Not an instance of Rider class."
      end
    end

    it "Returns an array with the correct number of riders" do
      number_of_riders = CSV.read("support/riders.csv").length - 1
      RideShare::Rider.all.length.must_equal number_of_riders, "Wrong number of riders"
    end

    it "gives correct values for the ID, NAME, and PHONE NUMBER of the last
    rider in the CSV file" do
    RideShare::Rider.all.last.id.must_equal 300, "ID of last rider is incorrect."
    RideShare::Rider.all.last.name.must_equal 'Miss Isom Gleason', "NAME of last rider is incorrect."
    RideShare::Rider.all.last.phone.must_equal '791-114-8423 x70188', "Phone number of last rider is incorrect."
  end
end


describe "RideShare::Rider.find" do
  it "Returns a Rider" do
    RideShare::Rider.find(88).must_be_instance_of RideShare::Rider, "Does not return a rider"
  end

  #   # it "Raises ArgumentError if rider id doesn't exist" do
  #   #   proc {
  #   #     RideShare::Rider.find(500)
  #   #   }.must_raise RideShare::ID_Not_Found_Error
  #   # end
  #
  it "Can find the last rider from the CSV" do
    #Checking that the id's of the returned and last riders are the same, since they will not be the same internal object due to 'all' having been called separated for each.
    RideShare::Rider.find(300).id.must_equal RideShare::Rider.all.last.id, "Cannot find last account"
  end

  it "Returns nil if no rider with the given id is found." do
    RideShare::Rider.find(500).must_equal nil
  end
end

describe "RideShare::Rider.trips" do

  #This directly uses the RideShare::Trip.all_by(type, id) method, so we do not need to re-test the full functionality of that method. To test that the Rider.trips method is working appropriately, we can test one, nominal case and one edge case.

  it "Returns an array of Trip instances" do
    RideShare::Rider.all
    rider_54 = RideShare::Rider.find(54)
    rider_54.trips.must_be_instance_of Array
    rider_54.trips[0].must_be_instance_of RideShare::Trip
    rider_54.trips.length.must_equal 2
  end


  it "returns an empty array if the driver has had no trips" do
    RideShare::Rider.all
    rider_300 = RideShare::Rider.find(300)
    rider_300.trips.must_equal []
  end
end




describe "RideShare::Driver.drivers_used" do
it "Returns an array" do
  new_driver.drivers_used.must_be_instance_of Array
end
#
# it "Returns an array of driver instances" do
#   new_driver.drivers_used.each do |driver|
#     trip.must_be_instance_of RideShare::Driver
# end
#
# it "Returns an array of ALL drivers used for that riderinstances" do
#   new_driver.drivers_used.
# end
#
# it "test an edge case" do
# end

end

end
