require_relative 'spec_helper'

describe "Rider" do
  describe "constructor" do
    before do
      @name = 'Ada'
      @id = 108
      @phone_num = '123.456.7890'
    end

    let (:rider) {RideShare::Rider.new(name: @name, id: @id, phone_num: @phone_num)}

    it "can be instantiated" do
      rider.must_be_instance_of RideShare::Rider
    end

    it "takes a name, phone number, and ID" do
      rider.must_respond_to :name
      rider.name.must_equal @name

      rider.must_respond_to :id
      rider.id.must_equal @id

      rider.must_respond_to :phone_num
      rider.phone_num.must_equal @phone_num
    end
  end

  # describe "trips" do
  #   # handle the case that @rider_id is nil?
  #   it "returns an array" do
  #     skip
  #   end
  #
  #   it "returns only Trip objects in the array" do
  #     skip
  #   end
  #
  #   it "returns only Trip instances that this rider has taken" do
  #     #must_include id
  #     #must_not_include id
  #     #length
  #   end
  #
  #   it "returns nil if @rider_id is undefined" do
  #
  #   end
  # end
  #
  # describe "drivers" do
  #   # handle the case that @rider_id is nil?
  #   it "returns an array" do
  #
  #   end
  #
  #   it "returns only Driver objects in the array" do
  #
  #   end

      # it "returns the correct number of Drivers" do
      #
      # end
  #
  #   it "returns all previous driver instances" do
  #     # posibly break into more tests
  #     #array.length, check ids
  #   end
  #
  #   it "retruns nil if @driver_id is undefined" do
  #
  #   end
  # end

  # retrieves all riders from the CSV file
  describe "Rider.all" do
    it "returns an array" do

    end

    it "returns only Rider instances in the array" do

    end

    it "returns the correct number of riders" do

    end

    it "initializes a 1st Rider with the CSV's first id, name, and phone number" do

    end

    it "initializes a last Rider with the CSV's last id, name, and phone number" do

    end
  end

  describe "Rider.find" do
    it "returns a Rider that exists" do
    end

    it "can find the first Rider from the CSV file" do

    end

    it "can find the last Rider from the CSV file" do

    end

    it "returns nil if no rider_id is found"
  end
end
