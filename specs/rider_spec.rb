require_relative "spec_helper"


describe "Rider" do
  describe "#initialize" do
    it "Takes a hash with id, name and phone number" do
    # it "Takes an id, name and phone number" do
    #   id = "007"
    #   name = "James Bond"
    #   phone_num = "(392) 217-0777"
    #   rider1 = RideSharing::Rider.new(id, name, phone_num)
      rider1 = RideSharing::Rider.new({rider_id: 007, name: "James Bond", phone_num: "1-580-581-8405 x079"})
      rider1.must_respond_to :id
      rider1.id.must_equal 007

      rider1.must_respond_to :name
      rider1.name.must_equal "James Bond"

      rider1.must_respond_to :phone_num
      rider1.phone_num.must_equal "1-580-581-8405 x079"
    end

    it "Must raise an ArgumentError if :rider_id input is not an integer > 0" do
      proc{
        RideSharing::Rider.new({rider_id: "007", name: "James Bond", phone_num: "1-580-581-8405 x079"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({rider_id: 0, name: "James Bond", phone_num: "1-580-581-8405 x079"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({rider_id: 11.0, name: "James Bond", phone_num: "1-580-581-8405 x079"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({name: "James Bond", phone_num: "1-580-581-8405 x079"})
      }.must_raise ArgumentError
    end

    it "Must raise an ArgumentError if :name is not a string" do
      proc{
        RideSharing::Rider.new({rider_id: 007, name: ["James Bond"], phone_num: "1-580-581-8405 x079"})
      }.must_raise ArgumentError

      RideSharing::Rider.new({rider_id: 007, name: "[James Bond]", phone_num: "1-580-581-8405 x079"}).must_be_kind_of RideSharing::Rider

      proc{
        RideSharing::Rider.new({rider_id: 007, name: "", phone_num: "1-580-581-8405 x079"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({rider_id: 007, name: "  ", phone_num: "1-580-581-8405 x079"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({rider_id: 007, name: "Al", phone_num: "1-580-581-8405 x079"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({rider_id: 007,  phone_num: "1-580-581-8405 x079"})
      }.must_raise ArgumentError
    end

    it "Invalid phone number must raise ArgumentError" do
      proc{
        RideSharing::Rider.new({rider_id: 007, name: "James Bond", phone_num: " "})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({rider_id: 007, name: "James Bond"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({rider_id: 007, name: "James Bond", phone_num: "1-580-581-840 x079"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({rider_id: 007, name: "James Bond", phone_num: "2-580-581-8405 x079"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({rider_id: 007, name: "James Bond", phone_num: "1-580-511-8405 x079"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({rider_id: 007, name: "James Bond", phone_num: "1-580-181-8405 x079"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({rider_id: 007, name: "James Bond", phone_num: "1-180-581-8405 x079"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({rider_id: 007, name: "James Bond", phone_num: "1-580-081-8405 x079"})
      }.must_raise ArgumentError

      proc{
        RideSharing::Rider.new({rider_id: 007, name: "James Bond", phone_num: "1-080-581-8405 x079"})
      }.must_raise ArgumentError
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
      all_riders.length.must_equal 209
      # A bunch of phone numbers does not match up with the North American Numbering Plan
      # They must be in the format  NPA-NXX-xxxx
      # N cannot be 0 or 1
      # XX cannot be 11
    end

    it "The phone number of the second instance must be (392) 217-0777" do
      RideSharing::Rider.all[1].phone_num.must_equal "(392) 217-0777"
    end

    it "The name of rider with id number 252 must be Mrs. Keara Kozey" do
      rider253 = RideSharing::Rider.all.select {|rider_obj| rider_obj.id == 253}.first
      rider253.name.must_equal "Mrs. Keara Kozey"
    end

    it "Does not initialize rider for any of the invalid inputs in /support/riders_spec_false.csv" do
      path = "./support/riders_spec_false.csv"
      all_riders = RideSharing::Rider.all(path)
      all_riders.length.must_equal 17
      all_riders[0].name.must_equal "Nina Hintz Sr."
      all_riders[1].name.wont_equal "Kaia Klocko"
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
      returned_object = RideSharing::Rider.find(298)
      returned_object.name.must_equal "Maybelle Wilkinson"
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


  describe "#list_of_trips" do
    # This method is solely dependent upon a class method in the class Trip.
    # Blind trust is giving that no tests should be needed. The method used should have been thouroughly tested in the class Trip.
  end


  describe "#previous_drivers" do
    let(:rider1) {RideSharing::Rider.find(1)}
    let(:rider103) {RideSharing::Rider.find(103)} # rider103 has used a driver with id# 0
    let(:rider92) {RideSharing::Rider.find(92)} # rider92 has used a driver twice

    it "The method must return an array" do
      rider1.previous_drivers.must_be_kind_of Array
    end

    it "The elements of the array must be of kind RideSharing::Driver" do
      rider1.previous_drivers.each do |obj|
        obj.must_be_kind_of RideSharing::Driver
      end

      rider103.previous_drivers.each do |obj|
        obj.must_be_kind_of RideSharing::Driver
      end
    end

    it "Find previous drivers for rider with id#85" do
      rider85 = RideSharing::Rider.find(85)
      rider85.previous_drivers.length.must_equal 7
    end

    it "Find previous drivers for rider with id#39" do
      rider103.list_of_trips.map { |trip| trip.find_driver}.length.must_equal 2
      rider103.previous_drivers.length.must_equal 1
    end

    it "Find previous drivers for rider with id#41" do
      rider92.list_of_trips.map { |trip| trip.find_driver}.length.must_equal 4
      rider92.previous_drivers.length.wont_equal 4
      rider92.previous_drivers.length.must_equal 3
    end
  end # End describe "#previous_drivers"


################################################################################
  xdescribe "EXPLORING DATA" do
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
    #
    # it "Find all driver-ids for rider 1, should be ? of them" do
    #   rider1 = RideSharing::Rider.find(1)
    #   drivers_of_1 = rider1.list_of_trips.map { |trip| trip.find_driver.id}
    #   puts drivers_of_1
    # end
    #
    # it "Find all driver-ids for rider 92, should be 3 of them, not 4, due to riding with 1 driver twice" do
    #   rider92 = RideSharing::Rider.find(92)
    #   drivers_of_92 = rider92.list_of_trips.map { |trip| trip.find_driver.id}
    #   print drivers_of_92
    #   puts ""
    #   print drivers_of_92.uniq
    #   puts ""
    # end
    #
    # it "Find all riders with no trips" do
    #   RideSharing::Rider.all.each do |rider|
    #     # rider_with_0_trips = []
    #     if rider.list_of_trips == []
    #       print "#{rider.id} "
    #     end
    #   end
    #   puts ""
    # end

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
  end # End of describe "EXPLORING CODE:
################################################################################

end # End of describe "Rider"
