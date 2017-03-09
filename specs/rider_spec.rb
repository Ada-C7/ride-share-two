require_relative 'spec_helper'

describe "Rider class" do
  let(:rider)  {RideShare::Rider.new(31, "Ms. Enrique Kiehn", "416-848-6488 x8656")}
  describe "#initialize method" do
    it "Initializes a new driver instance from the parameter" do
      rider.must_be_instance_of RideShare::Rider
      rider.must_respond_to :id
      rider.id.must_equal rider[:id]
      rider.must_respond_to :name
      rider.name.must_equal rider[:name]
      rider.must_respond_to :phone
      rider.vin.must_equal rider[:phone]
    end

    it "raises an argument error if Driver's ID or name or   phone number are invalid" do
      proc {
        RideShare::Rider.new("1q", "Ms. Enrique Kiehn", "416-848-6488 x8656")
      }.must_raise ArgumentError
      proc {
        RideShare::Rider.new(31, 57448888, "416-848-6488 x8656")}.must_raise ArgumentError
        proc {
          RideShare::Rider.new(31, "Ms. Enrique Kiehn", 4168486488)}.must_raise ArgumentError
        end
      end
    end
