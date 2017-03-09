require_relative 'spec_helper'

describe "Driver" do

  describe "Driver.create_all_drivers" do

    before do
      @drivers = RideShare::Driver.create_all_drivers
    end

    it "Returns an array of all accounts" do
      @drivers.must_be_instance_of Array
    end

    it "The number of drivers is correct" do
      @drivers.length.must_equal 100
    end

    it "The driver_id and vin of the first and last" do

      @drivers.first.driver_id.must_equal 1
      @drivers.first.vin.must_equal "WBWSS52P9NEYLVDE9"

      @drivers.last.driver_id.must_equal 100
      @drivers.last.vin.must_equal "XF9Z0ST7X18WD41HT"

    end

  end

  it "Raises an ArgumentError/Says something when VIN is not 17 characters" do
    skip
    # proc {
    #   Bank::Account.new(1337, -100.0)
    # }.must_raise ArgumentError
    # proc {
    #       account.withdraw(withdrawal_amount)
    #     }.must_output(/.+/)
  end

  # it "has access to that constant" do
  #   DAN_CONSTANT.must_equal 106
  # end
end
