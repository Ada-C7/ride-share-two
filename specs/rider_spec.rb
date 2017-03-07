require 'pry'
require_relative 'spec_helper'
require_relative '../lib/rider'

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

    it "Is a kind of Driver" do
      name = "Louise Belcher"
      id = 12345
      phone_num = "(206) 222 222"
      rider = Rider.new(id, name, phone_num)

      rider.must_be_kind_of Rider
    end
  end

  describe "Rider#all" do

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

      index = 0
      CSV.read("support/riders.csv") do |line|

        @riders[index].id.must_equal line[0].to_i
        @riders[index].name.must_equal line[1]
        @riders[index].phone_num.must_equal line[2]
        index += 1
      end
    end

  end

end
