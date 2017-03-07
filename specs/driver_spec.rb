require_relative "spec_helper"

xdescribe "Driver" do
  describe "#initialize" do
    it "Takes an id, name and vehicle number" do
      id = "007"
      name = "James Bond"
      vin = "WBWSS52P9NEYLVDE9"
      driver1 = RideSharing::Driver.new(id, name, vin)

      driver1.must_respond_to :id
      driver1.id.must_equal id

      driver1.must_respond_to :name
      driver1.name.must_equal name

      driver1.must_respond_to :vin
      driver1.vin.must_equal vin
    end
  end # End of describe "Driver#initialize"

  describe "#self.all" do
    it "Returns an array." do
      path = "./support/drivers_spec1.csv"
      all_drivers = RideSharing::Driver.all(path)
      all_drivers.must_be_kind_of Array
    end

    it "The elements in the returned array must be RideSharing::Driver instances " do
      path = "./support/drivers_spec1.csv"
      all_drivers = RideSharing::Driver.all(path)
      all_drivers.each do |obj|
        obj.must_be_kind_of RideSharing::Driver
      end
      all_drivers.length.must_equal 3
    end

    it "Does not initialize driver if vin is not valid" do
      path = "./support/drivers_spec2.csv"
      all_drivers = RideSharing::Driver.all(path)
      all_drivers.length.must_equal 2
      all_drivers[0].name.must_equal "Bernardo Prosacco"
      all_drivers[1].name.wont_equal "Emory Rosenbaum"
    end

    it "drivers.csv should return 100 drivers" do
      all_drivers = RideSharing::Driver.all
      all_drivers.length.must_equal 100
    end
  end # End of describe "Driver#self.all"

  describe "#self.find" do
    it "returns an object of class RideSharing::Driver" do
      returned_object = RideSharing::Driver.find(1)
      returned_object.must_be_kind_of RideSharing::Driver
    end

    it "Throws an error if id is not found" do
      proc{
        RideSharing::Driver.find(101)
      }.must_raise ArgumentError
    end
  end # End of describe "Driver#self.find"


end # End of describe "class Driver"
