require_relative 'spec_helper'

describe "Driver" do
  # describe "constructor" do
  #   let (:driver) {RideShare::Driver.new(name: 'Ada', id: 108, vin: '123456789abcdefeg')}
  #
  #   it "can be instantiated" do
  #     driver.must_be_instance_of RideShare::Driver
  #   end
  #
  #   it "takes a name, VIN, and ID" do
  #     driver.must_respond_to :name
  #     driver.name.must_equal 'Ada'
  #
  #     driver.must_respond_to :id
  #     driver.id.must_equal 108
  #
  #     driver.must_respond_to :vin
  #     driver.vin.must_equal '123456789abcdefeg'
  #   end
  #
  #   it "raises an error if the VIN is not 17 characters long" do
  #     invalid_vin = '123456dfsd'
  #
  #     proc {
  #       RideShare::Driver.new(name: 'Ada', id: 108, vin: invalid_vin)
  #     }.must_raise ArgumentError
  #   end
  #
  #   it "raises an error if the VIN has a character other than a letter or number" do
  #     invalid_vin = '12345!!12345ddegd'
  #
  #     proc {
  #       RideShare::Driver.new(name: 'Ada', id: 108, vin: invalid_vin)
  #     }
  #   end
  # end

  describe "constructor" do
    before do
      @name = 'Ada'
      @id = 108
      @vin = '123456789abcdefeg'
    end

    it "can be instantiated" do
      driver = RideShare::Driver.new(name: @name, id: @id, vin: @vin)
      driver.must_be_instance_of RideShare::Driver
    end

    it "takes a name, VIN, and ID" do
      driver = RideShare::Driver.new(name: @name, id: @id, vin: @vin)

      driver.must_respond_to :name
      driver.name.must_equal @name

      driver.must_respond_to :id
      driver.id.must_equal @id

      driver.must_respond_to :vin
      driver.vin.must_equal @vin
    end

    it "raises an error if the VIN is not 17 characters long" do
      invalid_vin = '123456dfsd'

      proc {
        RideShare::Driver.new(name: @name, id: @id, vin: invalid_vin)
      }.must_raise RideShare::InvalidVinError
    end

    it "raises an error if the VIN has a character other than a letter or number" do
      invalid_vin = '12345!!#2345ddegd'

      proc {
        RideShare::Driver.new(name: @name, id: @id, vin: invalid_vin)
      }.must_raise RideShare::InvalidVinError
    end
  end
end
