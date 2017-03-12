require 'pry'
require_relative 'spec_helper'

describe "Rider" do

  describe "#initialize" do
    it "Takes an ID, name, and phone number" do
      name = "Louise Belcher"
      id = 12345
      phone_num = "(206) 222 222"
      rider = Rider.new(id, name, phone_num)

      rider.must_respond_to :id
      rider.id.must_equal id

      rider.must_respond_to :name
      rider.name.must_equal name

      rider.must_respond_to :phone_num
      rider.phone_num.must_equal phone_num
    end

    it "Is a kind of Rider" do
      name = "Louise Belcher"
      id = 12345
      phone_num = "(206) 222 222"
      rider = Rider.new(id, name, phone_num)

      rider.must_be_kind_of Rider
    end
  end

  describe "Rider.all" do

    before do
      @riders = Rider.all
    end

    it "Returns an array of all riders" do
      @riders.class.must_equal Array
      @riders.each { |rider| rider.must_be_instance_of Rider }
      @riders.length.must_equal 300

      @riders.first.id.must_equal 1
      @riders[0].name.must_equal "Nina Hintz Sr."
      @riders.first.phone_num.must_equal "560.815.3059"

      @riders.last.id.must_equal 300
      @riders[-1].name.must_equal "Miss Isom Gleason"
      @riders.last.phone_num.must_equal "791-114-8423 x70188"

      # index = 0
      # CSV.read("support/riders.csv", { :headers => true }).each do |line|
      #
      #   @riders[index].id.must_equal line[0].to_i
      #   @riders[index].name.must_equal line[1]
      #   @riders[index].phone_num.must_equal line[2]
      #   index += 1
      # end
    end
  end

  describe "Rider.find" do

    before do
      @riders = Rider.all
    end

    it "Returns a rider that exists" do
      rider = Rider.find(150)
      rider.must_be_instance_of Rider
    end

    it "Can find the first rider from the CSV" do
      rider = Rider.find(1)
      rider.name.must_equal @riders.first.name
    end

    it "Can find the last rider from the CSV" do
      rider = Rider.find(300)
      rider.name.must_equal @riders.last.name
    end

    it "Returns nil for a rider that doesn't exist" do
      rider = Rider.find(301)
      rider.must_be_nil
    end

    it "Raises an error for an invalid rider ID" do
      proc {
        Rider.find("a")
      }.must_raise ArgumentError
    end
  end

  describe "Rider#list_trips" do
    it "Returns a list of trips for a specific rider" do
      rider = Rider.new(210, "Rhea Zieme", "940-838-2968 x4910")
      rider.list_trips.must_be_kind_of Array
      rider.list_trips.each { |trip| trip.must_be_kind_of Trip }
    end

    it "Returns a correct number of trips for a specific rider" do
      rider = Rider.new(1, "Nina Hintz Sr.", "560.815.3059")
      rider.list_trips.length.must_equal 2
    end

    it "Returns an empty array if there are no trips for that rider" do
      rider = Rider.new(100, "Hipolito Rogahn",	"944.179.4883")
      rider.list_trips.must_equal []
    end
  end

  describe "Rider#list_drivers" do
    it "Returns a list of drivers for a specific rider" do
      rider = Rider.new(93, "Mrs. Rickey Dickens", "5FS0Y47Z59YGGSXS0")
      rider_drivers = rider.list_drivers
      rider_drivers.must_be_kind_of Array
      rider_drivers.each { |driver| driver.must_be_kind_of Driver }
    end

    it "Returns a correct number of drivers for a specific rider" do
      rider = Rider.new(41, "Ms. Westley Pouros", "133.000.1809 x9028")
      rider.list_drivers.length.must_equal 2
      rider.list_drivers.length.wont_equal rider.list_trips.length
    end

    # Hipolito exists as a Rider, but didn't take any trips yet
    it "Returns an empty array if there are no drivers for that rider" do
      rider = Rider.new(100, "Hipolito Rogahn",	"944.179.4883")
      rider.list_drivers.must_equal []
    end
  end

end
