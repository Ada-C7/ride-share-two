require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/driver'
require_relative '../lib/trip'

Minitest::Reporters.use!
Minitest::Reporters::SpecReporter.new

describe Driver do

     before do
          @id = 3
          @name = "Leia"
          @vehicle_id = "VWING33"
          @leia = Driver.new(@id, @name, @vehicle_id)
     end

     describe 'Driver#initialization' do

          it "Creates class Driver" do
            @leia.must_be_kind_of Driver
          end

          it "Takes ID, name and vehicle ID" do
            @leia.must_respond_to :id
            @leia.id.must_equal @id

            @leia.must_respond_to :name
            @leia.name.must_equal @name

            @leia.must_respond_to :vehicle_id
            @leia.vehicle_id.must_equal @vehicle_id
          end


     end


end
