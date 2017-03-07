require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/rider'

describe "RideShare::Rider" do
  before do
    # 13,Dr. Leilani Mertz,777.380.7540
    @rider = RideShare::Rider.new({id: "13", name: "Dr. Leilani Mertz", phone_number: "777.380.7540"})
  end

  describe "Rider#initialize" do
    it "creates a new instance of Rider" do
      @rider.must_be_instance_of RideShare::Rider
    end
    it "passes in the driver name" do
      @rider.id.must_equal "13"
    end
    it "passes in the vin" do
      @rider.name.must_equal "Dr. Leilani Mertz"
    end
    it "passes in the rider_id" do
      @rider.phone_number.must_equal "777.380.7540"
    end
    it "can create a new rider with a missing phone" do
      no_phone = RideShare::Rider.new({id: "87", name: "Tamiko Terada"})
      no_phone.phone_number.must_equal nil
    end
  end
end
