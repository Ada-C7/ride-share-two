require_relative "spec_helper"


describe "Rider" do
  describe "#initialize" do
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


  describe "#self.all" do
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


  describe "#self.find" do
    it "returns an object of class RideSharing::Rider if id is found" do
      returned_object = RideSharing::Rider.find(1)
      returned_object.must_be_kind_of RideSharing::Rider
    end

    it "returns right name" do
      returned_object = RideSharing::Rider.find(1)
      returned_object.name.must_equal "Nina Hintz Sr."
      returned_object = RideSharing::Rider.find(300)
      returned_object.name.must_equal "Miss Isom Gleason"
    end

    # it "Throws an error if id is not found" do
    #   proc{
    #     RideSharing::Rider.find(301)
    #   }.must_raise ArgumentError
    # end

    it "Returns nil if id is not found" do
      RideSharing::Driver.find(301).must_be_nil
    end
  end # End of describe "Rider#self.find"


  describe "#previous_drivers" do
    let(:rider1) {RideSharing::Rider.find(1)}
    let(:rider39) {RideSharing::Rider.find(39)} # rider39 has used a driver with id# 0
    let(:rider41) {RideSharing::Rider.find(41)} # rider41 has used a driver twice

    it "The method must return an array" do
      rider1.previous_drivers.must_be_kind_of Array
    end

    it "The elements of the array must be of kind RideSharing::Driver" do
      rider1.previous_drivers.each do |obj|
        obj.must_be_kind_of RideSharing::Driver
      end

      rider39.previous_drivers.each do |obj|
        obj.must_be_kind_of RideSharing::Driver
      end
    end

    it "Find previous drivers for rider with id#85" do
      rider85 = RideSharing::Rider.find(85)
      rider85.previous_drivers.length.must_equal 7
    end

    it "Find previous drivers for rider with id#39" do
      rider39.list_of_trips.map { |trip| trip.find_driver}.length.must_equal 2
      rider39.previous_drivers.length.must_equal 1
    end

    it "Find previous drivers for rider with id#41" do
      rider41.list_of_trips.map { |trip| trip.find_driver}.length.must_equal 3
      rider41.previous_drivers.length.wont_equal 3
      rider41.previous_drivers.length.must_equal 2
    end


  end # End describe "#previous_drivers"


################################################################################
  # describe "EXPLORING DATA" do
    # it "Printout of number of trips and drivers for each rider." do
    #   RideSharing::Rider.all.each do |rider|
    #     drivers = rider.list_of_trips.map { |trip| trip.find_driver}.delete_if {|driver| driver == nil}
    #     drivers = drivers.uniq { |driver| driver.id}
    #     puts "Rider ##{rider.id}: #{rider.list_of_trips.length} trips with #{drivers.length} drivers"
    #   end
    # end
    #
    # it "Find all driver-ids for rider 85, should be 7 of them" do
    #   rider85 = RideSharing::Rider.find(85)
    #   drivers_of_85 = rider85.list_of_trips.map { |trip| trip.find_driver.id}
    #   puts drivers_of_85
    # end

    # it "Find all driver-ids for rider 1, should be ? of them" do
    #   rider1 = RideSharing::Rider.find(1)
    #   drivers_of_1 = rider1.list_of_trips.map { |trip| trip.find_driver.id}
    #   puts drivers_of_1
    # end
    #
    # it "Find all driver-ids for rider 41, should be 2 of them, not 3, due to riding with 1 driver twice" do
    #   rider41 = RideSharing::Rider.find(41)
    #   drivers_of_41 = rider41.list_of_trips.map { |trip| trip.find_driver.id}.uniq
    #   puts drivers_of_41
    # end

    # it "Find all riders with no trips" do
    #   RideSharing::Rider.all.each do |rider|
    #     # rider_with_0_trips = []
    #     if rider.list_of_trips == []
    #       print "#{rider.id} "
    #     end
    #   end
    #   puts ""
    # end
    #
    # it "Find all riders with trips having an unidentified driver" do
    #   RideSharing::Rider.all.each do |rider|
    #     drivers = rider.list_of_trips.map { |trip| trip.find_driver}
    #     unidentified_drivers = drivers.select {|driver| driver == nil}
    #     if unidentified_drivers != []
    #       puts rider.id
    #       rider.list_of_trips.map { |trip| puts "Trip ##{trip.id}"}
    #     end
    #   end
    # end
  # end # End of describe "EXPLORING CODE:
################################################################################

end # End of describe "Rider"
