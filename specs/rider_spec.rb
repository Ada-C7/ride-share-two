require_relative 'spec_helper.rb'


describe "rider: self.all" do
  before do
    @rider = RideShare::Rider.all
  end

  it "retrieve an array" do
    @rider.must_be_instance_of Array
  end

  it "things in the array are an instance of rider infomation" do
    # skip
    @rider.each do |rider_info|
      rider_info.must_be_instance_of RideShare::Rider
    end
  end

  it "number of riders is correct" do
    # skip
    @rider.length.must_equal 300
  end

  it "retrieves the rider_id, name, and phone_num" do
    CSV.readlines('support/riders.csv') do |line|
      counter = 0

      @rider[counter].rider_id.must_equal line[counter][0].to_i
      @rider[counter].name.must_equal line[counter][1].to_s
      @rider[counter].phone_num.must_equal line[counter][2].to_s

      counter += 1
    end
  end

  it "retrieves the first and last rider_id" do
    # skip

    @rider[0].rider_id.must_equal "1"
    @rider[225].rider_id.must_equal "226"
  end

  it "retrieves random rider_id" do
    @rider[27].rider_id.must_equal "28"
  end
end

describe "rider: self.find" do

  it "returns the first rider using rider_id" do
    rider = RideShare::Rider.find("1")

    rider.must_equal "Nina Hintz Sr."
  end

  it "returns the last driver using rider_id" do
    rider = RideShare::Rider.find("40")

    rider.must_equal "Julius Johns"
  end

  it "return a random rider using rider_id" do
    # skip
    rider = RideShare::Rider.find("3")

    rider.must_equal "Marcellus Hoeger"
  end
end

describe "rider: trips" do
  before do
    @rider = RideShare::Rider.new("", "", "")
  end

  it "finds first and last rider instances of first rider" do
    instances = @rider.trips("1")

    array_1 = ["46", "98", "1", "2016-06-28", "2"]
    array_2 = ["272", "17", "1", "2015-09-14", "4"]

    instances[0].must_equal array_1
    instances[-1].must_equal array_2
  end

  it "finds rider instance of last rider" do
    instance = @rider.trips("300")
    array_1 = nil

    instance[0].must_equal array_1
  end

  it "finds first and last rider instance of random rider" do
    instances = @rider.trips("19")
    array_1 = ["93", "57", "19", "2015-06-25", "5"]
    array_2 = ["228", "18", "19", "2015-10-10", "5"]

    instances[0].must_equal array_1
    instances[-1].must_equal array_2
  end
end
