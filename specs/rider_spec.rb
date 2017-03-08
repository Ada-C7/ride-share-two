require_relative 'spec_helper'

require_relative 'spec_helper'


describe "Rider" do
  let(:riders) { RideShare::Rider.all }

  describe "Rider#initialize" do
    let(:the_rock) { RideShare::Rider.new(333, "Dwayne 'The Rock' Johnson", "999.999.9999") }

    it "Rider has a name, ID, and VIN" do
      the_rock.id.must_equal 777
      the_rock.name.must_equal "Dwayne 'The Rock' Johnson"
      the_rock.phone.must_equal "999.999.9999"
    end

    it "raises error if Rider's ID, name, or phone are invalid input" do
      proc {
        RideShare::Rider.new("DTRJ", "Dwayne 'The Rock' Johnson", "999.999.9999")
      }.must_raise ArgumentError
      proc {
        RideShare::Rider.new(777, ["Dwayne 'The Rock' Johnson"], "999.999.9999")
      }.must_raise ArgumentError
      proc {
        RideShare::Rider.new(777, "Dwayne 'The Rock' Johnson", 9999999999)
      }.must_raise ArgumentError
    end
  end


  describe "Rider#all" do

    it "returns an array of Rider instances" do
      riders.must_be_kind_of Array
      riders.all? do |rider|
        rider.must_be_instance_of RideShare::Rider
      end
    end

    it "returns array with the correct number of Riders from csv" do
      riders.length.must_equal 300
    end

    it "Rider instances match what's in the csv file" do
      index = 0
      CSV.read("support/riders.csv", headers: true) do |line|
        riders[index].id.must_equal line[0].to_i
        riders[index].name.must_equal line[1]
        riders[index].phone.must_equal line[2]
        index += 1
      end
    end

  end


  describe "Rider#find" do

    it "raises an error if a non-integer is provided" do
      proc {
        RideShare::Rider.find("third rider")
      }.must_raise ArgumentError
    end

    it "returns an instance of Rider" do
      RideShare::Rider.find(1).must_be_instance_of RideShare::Rider
    end

    it "can find any driver based on a randomly generated number" do
      10.times do
        random_id = rand(1..100)
        rider_check = riders[random_id - 1].id
        rider = RideShare::Rider.find(random_id)
        expect(rider.id).must_equal rider_check
      end
    end

    it "returns nil if account doesn't exist" do
      RideShare::Rider.find(383).must_be_nil
    end

  end


  describe "Rider#trips and #drivers" do
    let(:hipolito) { RideShare::Rider.new(100, "Hipolito Rogahn", "944.179.4883") }

    it "returns an empty array if the Rider has taken no trips" do
      no_rider = riders[299]
      no_rider.trips.must_equal []
    end

    it "returns an array whose length matches the number of Rider's trips" do
      hipolito.trips.must_be_kind_of Array
      hipolito.trips.length.must_equal RideShare::Trip.find_by_rider(100).length
    end

    it "returns an array of all Trip instances" do
      hipolito.trips.all? do | trip |
        trip.must_be_instance_of RideShare::Trip
      end
    end

    it "returns an array of all Drivers for given Rider" do
      hipolito.drivers.must_be_kind_of Array
      hipolito.drivers.all? do |driver|
        driver.must_be_instance_of RideShare::Driver
      end
    end

    it "returns an array with correct number of Drivers" do
      rider_drivers = RideShare::Trip.find_by_rider(100).map! do |trip|
        trip.driver_id
      end
      hipolito.drivers.length.must_equal rider_drivers.length
    end

    it "returns an array with no Drivers repeated" do
      rider_drivers = RideShare::Trip.find_by_rider(92).map! do |trip|
        trip.driver_id
      end
      hipolito.drivers.length.must_equal rider_drivers.uniq.length
      end
  end

end
