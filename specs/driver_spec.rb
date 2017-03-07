require_relative 'spec_helper'

# Each driver should:

# Each vehicle identification number should be a specific length to ensure it is a valid vehicle identification number
# use InvalidVinError
describe Driver do
  let(:vindiesel) { Driver.new(777, "Vin Diesel", "FASTNFURIOUS00007") }

  describe "Driver#initialize" do

    it "Driver has a name, ID, and VIN" do
      vindiesel.id.must_equal 777
      vindiesel.name.must_equal "Vin Diesel"
      vindiesel.vin_num.must_equal "FASTNFURIOUS00007"
    end

    it "raises error if Driver's ID is not a number" do
      proc {
        Driver.new("VD", "Vin Diesel", "fastnfurious00007")
      }.must_raise ArgumentError
    end

    it "raises error if Driver's name is not a String" do
      proc {
        Driver.new(777, ["Vin Diesel"], "FASTNFURIOUS00007")
      }.must_raise ArgumentError
    end

    it "raises error if VIN has invalid characters or wrong length" do
      proc {
        Driver.new(777, "Vin Diesel", "FASTNFURIOUS@@!!7")
      }.must_raise InvalidVinError

      proc {
        Driver.new(777, "Vin Diesel", "FASTNFURIOUS007")
      }.must_raise InvalidVinError
    end

    let(:vindiesel) { Driver.new(777, "Vin Diesel", "fastnfurious00007") }
  
    it "accepts lowercase letters in VIN" do
      vindiesel.vin.must_equal "fastnfurious00007"
    end


  end


end


# Given a driver object, you should be able to:
# retrieve the list of trip instances that only this driver has taken
# retrieve an average rating for that driver based on all trips taken

# You should be able to:
# retrieve all drivers from the CSV file
# find a specific driver using their numeric ID
