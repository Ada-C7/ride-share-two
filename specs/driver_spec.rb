require_relative 'spec_helper'
require_relative '../lib/driver'

describe "Driver" do

  describe "#initialize" do
    it "Takes an ID, name, and vin" do
      name = "Bob Belcher"
      id = 12345
      vin = 98765
      driver = Driver.new(id, name, vin)

      driver.must_respond_to :id
      driver.id.must_equal id

      driver.must_respond_to :name
      driver.name.must_equal name

      driver.must_respond_to :vin
      driver.vin.must_equal vin
    end

    it "Is a kind of Driver" do
      name = "Bob Belcher"
      id = 12345
      vin = 98765
      driver = Driver.new(id, name, vin)

      driver.must_be_kind_of Driver
    end
  end

  describe "Driver#all" do

    before do
      @drivers = Driver.all
    end

    it "Returns an array of all drivers" do
      @drivers.class.must_equal Array
      @drivers.each { |driver| driver.must_be_instance_of Driver }
      @drivers.length.must_equal 100

      @drivers.first.id.must_equal 1
      @drivers[0].name.must_equal "Bernardo Prosacco"
      @drivers.first.vin.must_equal "WBWSS52P9NEYLVDE9"

      @drivers.last.id.must_equal 100
      @drivers[-1].name.must_equal "Minnie Dach"
      @drivers.last.vin.must_equal "XF9Z0ST7X18WD41HT"

      index = 0
      CSV.read("support/drivers.csv") do |line|

        @drivers[index].id.must_equal line[0].to_i
        @drivers[index].name.must_equal line[1].to_s
        @drivers[index].vin.must_equal line[2]
        index += 1
      end
    end
  end
end
