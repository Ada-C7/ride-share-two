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
    let (:riders) {RideShare::Rider.all}
    let (:rider_csv_info) {CSV.read("support/riders.csv")[1 .. -1]} # ignore headers

    it "returns an array" do
      riders.must_be_instance_of Array
    end

    it "returns only Rider instances in the array" do
      riders.each do |rider|
        rider.must_be_instance_of RideShare::Rider
      end
    end

    it "returns the correct number of riders" do
      expected_num_of_riders = rider_csv_info.size
      num_of_riders = riders.size
      num_of_riders.must_equal expected_num_of_riders
    end

    it "initializes a 1st Rider with the CSV's first id, name, and phone number" do
      first_rider_id = rider_csv_info.first[0].to_i
      first_rider_name = rider_csv_info.first[1]
      first_rider_phone_num = rider_csv_info.first[2]

      riders.first.id.must_equal first_rider_id
      riders.first.name.must_equal first_rider_name
      riders.first.phone_num.must_equal first_rider_phone_num
    end

    it "initializes a last Rider with the CSV's last id, name, and phone number" do
      last_rider_id = rider_csv_info.last[0].to_i
      last_rider_name = rider_csv_info.last[1]
      last_rider_phone_num = rider_csv_info.last[2]

      riders.last.id.must_equal last_rider_id
      riders.last.name.must_equal last_rider_name
      riders.last.phone_num.must_equal last_rider_phone_num
    end
  end

  describe "Rider.find" do
    it "returns a Rider that exists" do
    end

    it "can find the first Rider from the CSV file" do

    end

    it "can find the last Rider from the CSV file" do

    end

    it "returns nil if no rider_id is found" do
      
    end
  end
end
