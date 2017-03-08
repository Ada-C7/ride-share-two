require_relative 'spec_helper'
require_relative "../ride_share"
require "csv"



describe "Driver#initialize" do
  let(:max) { Ride_Share::Driver.new(name: 'max', driver_id: "2", vin: "12345338" )}
  it "Takes an ID , name and vin" do
    # id = 1
    # name = "Bernardo Prosacco"
    # vin = "WBWSS52P9NEYLVDE9"
    # driver = Ride_Share::Driver.new :id,:name, :vin

    max.must_respond_to :id
    max.id.must_equal "2"

    max.must_respond_to :name
    max.name.must_equal "max"

    max.must_respond_to :vin
    max.vin.must_equal "12345338"
  end

describe "Driver#all" do
  let(:all_drivers) { Ride_Share::Driver.all}


  it "Returns an array of all driver instances" do
    all_drivers.must_be_kind_of Array
  end

  it 'Everything in the array is an instane of Ride_share::Driver class' do
    all_drivers.each do |driver_instance|
      driver_instance.must_be_instance_of Ride_Share::Driver
    end
  end

    it "The records of drivers are = 100" do
      all_drivers.length.must_equal 100
    end

    it "The ID and name and vihecle identification of the first driver match what's in the CSV file" do
      #1 Bernardo Prosacco	WBWSS52P9NEYLVDE9
      driver_id = "1"
      name = "Bernardo Prosacco"
      vin = "WBWSS52P9NEYLVDE9"

      all_drivers.first.id.must_equal driver_id
      all_drivers.first.name.must_equal name
      all_drivers.first.vin.must_equal vin
    end

    it "The ID and name and vihecle identification of the first driver match what's in the CSV file" do
      # 100,Minnie Dach,XF9Z0ST7X18WD41HT

      driver_id = "100"
      name = "Minnie Dach"
      vin = "XF9Z0ST7X18WD41HT"

      all_drivers.last.id.must_equal driver_id
      all_drivers.last.name.must_equal name
      all_drivers.last.vin.must_equal vin
    end
    #




  end


end
