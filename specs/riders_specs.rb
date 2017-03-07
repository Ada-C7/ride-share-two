require_relative 'spec_helper'
require 'pry'

describe "Rider initialize" do
  it "Takes an ID, name, and phone number" do
    id = 1
    name = "Nina Hintz Sr."
    phone_num = "560.815.3059"
    rider = RideShare::Rider.new(id, name, phone_num)

    rider.must_respond_to :id
    rider.id.must_equal id

    rider.must_respond_to :name
    rider.name.must_equal name

    rider.must_respond_to :phone_num
    rider.phone_num.must_equal phone_num
  end
end

describe "Rider.all" do

  before do
    @rider_array = RideShare::Rider.all
  end

  it "Returns an array of all accounts" do
    @rider_array.must_be_instance_of Array
  end


  #   - The number of accounts is correct
  it "The number of riders is correct" do
    @rider_array.length.must_equal CSV.read("support/riders.csv").length - 1
  end
  #   - account is an Array
  it "account is an Array" do
    @rider_array.class.must_equal Array
  end

  #    - Everything in the array is a Rider
  it "Everything in the array is a Rider" do
    @rider_array.each {|account| account.class.must_equal RideShare::Rider}
  end

  #   - The ID and balance of the first and last
  #       riders match what's in the CSV file
  it " riders match what's in the CSV file" do
    index = 0
    # binding.pry
    CSV.read("support/riders.csv", {:headers => true}).each do |line|
      # binding.pry
      @rider_array[index].id.must_equal line[0]
      @rider_array[index].name.must_equal line[1]
      @rider_array[index].phone_num.must_equal line[2]
      # binding.pry
      index += 1
    end
  end

  it "The info of the first and last match csv" do
    @rider_array.first.id.must_equal "1"
    @rider_array.first.name.must_equal "Nina Hintz Sr."
    @rider_array.first.phone_num.must_equal "560.815.3059"
    @rider_array.last.id.must_equal "300"
    @rider_array.last.name.must_equal "Miss Isom Gleason"
    @rider_array.last.phone_num.must_equal "791-114-8423 x70188"
  end
end

describe "Rider.find" do
  before do
    @test_array = RideShare::Rider.all
  end
  # self.find(id) - returns an instance of a Rider
  # where the value of the id field in the CSV matches
  # the passed parameter.
  it "Returns a rider that exists" do
    test_variable = RideShare::Rider.find("2")
    test_variable.must_be_instance_of RideShare::Rider
    test_variable.id.must_equal "2"
  end

  it "Can find the first account from the CSV" do
    RideShare::Rider.find(@test_array[0].id).id.must_equal "1"
  end

  it "Can find the last account from the CSV" do
    RideShare::Rider.find(@test_array[-1].id).id.must_equal "300"
  end
end
