require_relative 'spec_helper'

describe "RideShare::Rider" do

  describe "RideShare::Rider#iniitalize" do

    let (:new_rider) { RideShare::Rider.new(2345, "Some Dude", "800-000-000") }

    it "A new rider can be initialized with an id, name, and phone number" do
      new_rider.must_be_instance_of RideShare::Rider
    end

  end


  describe "RideShare::Rider#trips" do
  end


  describe "RideShare::Rider#drivers" do
  end


  describe "RideShare::Rider#self.all" do

    let (:first_rider) { RideShare::Rider.all.first }
    let (:last_rider) { RideShare::Rider.all.last }
    let (:random_rider) { RideShare::Rider.all[115] }

    it "Initializes first line from riders.csv as a new RideShare::Rider instance" do
      first_rider.id.must_equal 0
      first_rider.name.must_equal "name"
      first_rider.phone.must_equal "phone_num"
    end

    it "Ititializes last line from riders.csv as a new RideShare::Rider instance" do
      last_rider.id.must_equal 300
      last_rider.name.must_equal "Miss Isom Gleason"
      last_rider.phone.must_equal "791-114-8423 x70188"
    end

    it "Ititializes random line from riders.csv as a new RideShare::Rider instance" do
      random_rider.id.must_equal 115
      random_rider.name.must_equal "Ms. Andreanne Littel"
      random_rider.phone.must_equal "550-756-7630"
    end

  end


  describe "RideShare::Rider#self.find" do

    let (:found_rider) { RideShare::Rider.find(99) }

    it "Returns a RideShare::Rider" do
      found_rider.must_be_instance_of RideShare::Rider
    end

    it "Is able to find random rider using the rider ID" do
      found_rider.id.must_equal 99
      found_rider.name.must_equal "Theresia Hessel"
      found_rider.phone.must_equal "1-440-395-0568 x9245"
    end

    it "Will raise an ArgumentError if Rider ID is not found" do
      proc { RideShare::Rider.find(400) }.must_raise ArgumentError
    end

  end

end
