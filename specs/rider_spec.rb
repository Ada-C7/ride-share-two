require_relative "spec_helper"


describe "Rider" do
  xdescribe "#initialize" do
    it "Takes an id, name and phone number" do
      id = "007"
      name = "James Bond"
      phone_num = "(392) 217-0777"
      rider1 = RideSharing::Rider.new(id, name, phone_num)

      rider1.must_respond_to :id
      rider1.id.must_equal id

      rider1.must_respond_to :name
      rider1.name.must_equal name

      rider1.must_respond_to :phone_num
      rider1.phone_num.must_equal phone_num
    end
  end # End of describe "#initialize"


  xdescribe "#self.all" do
    it "Returns an array." do
      RideSharing::Rider.all.must_be_kind_of Array
    end

    it "The elements in the returned array must be RideSharing::Rider instances " do
      all_riders = RideSharing::Rider.all
      all_riders.each do |rider_obj|
        rider_obj.must_be_kind_of RideSharing::Rider
      end
      all_riders.length.must_equal 300
    end

    it "The phone number of the second instance must be (392) 217-0777" do
      RideSharing::Rider.all[1].phone_num.must_equal "(392) 217-0777"
    end

    it "The name of rider with id number 252 must be Cameron Casper IV" do
      rider1 = RideSharing::Rider.all.select {|rider_obj| rider_obj.id == 252}.first
      rider1.name.must_equal "Cameron Casper IV"
    end
  end # End of describe "Driver#self.all"


  xdescribe "#self.find" do
    it "returns an object of class RideSharing::Rider" do
      returned_object = RideSharing::Rider.find(1)
      returned_object.must_be_kind_of RideSharing::Rider
    end

    it "returns right name" do
      returned_object = RideSharing::Rider.find(1)
      returned_object.name.must_equal "Nina Hintz Sr."
      returned_object = RideSharing::Rider.find(300)
      returned_object.name.must_equal "Miss Isom Gleason"
    end

    it "Throws an error if id is not found" do
      proc{
        RideSharing::Rider.find(301)
      }.must_raise ArgumentError
    end
  end # End of describe "Rider#self.find"


  describe "#previous_drivers" do
    let(:rider1) {RideSharing::Rider.find(1)}

    it "The method must return an array" do
      rider1.previous_drivers.must_be_kind_of Array
    end

    it "The elements of the array must be of kind RideSharing::Rider" do
      rider1.previous_drivers.each do |obj|
        obj.must_be_kind_of RideSharing::Driver
      end
    end

    it "" do
      rider1.previous_drivers.each do |obj|
        obj.must_be_kind_of RideSharing::Driver
      end
    end

    it "Find out how many trips and drivers each rider have utilized" do
      RideSharing::Rider.all.each do |rider|
        # drivers = rider.list_of_trips.map { |trip| trip.find_driver}
        # puts "#{rider.id}: #{rider.list_of_trips.length} trips with #{drivers.length} drivers"
      end
    end
  end # End describe "#previous_drivers"


end # End of describe "Rider"
