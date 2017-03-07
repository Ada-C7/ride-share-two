require_relative 'spec_helper'

# Each driver should:

# Each vehicle identification number should be a specific length to ensure it is a valid vehicle identification number
# use InvalidVinError
describe Driver do
  let(:vindiesel) { Driver.new(0.5, "Vin Diesel", "FASTNFURIOUS00007") }

  describe "Driver#initialize" do

    it "Driver has a name, ID, and VIN" do
      vindiesel.id.must_equal 0.5
      vindiesel.name.must_equal "Vin Diesel"
      vindiesel.vin.must_equal "FASTNFURIOUS00007"
    end


  end


end


# Given a driver object, you should be able to:
# retrieve the list of trip instances that only this driver has taken
# retrieve an average rating for that driver based on all trips taken

# You should be able to:
# retrieve all drivers from the CSV file
# find a specific driver using their numeric ID
