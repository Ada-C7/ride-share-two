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
          @vin = "VWING33"
          @leia = Driver.new(@id, @name, @vin)
     end

     describe "Driver#initialization" do

          it "Creates class Driver" do
            @leia.must_be_kind_of Driver
          end

          it "Takes ID, name and vehicle ID" do
            @leia.must_respond_to :id
            @leia.id.must_equal @id

            @leia.must_respond_to :name
            @leia.name.must_equal @name

            @leia.must_respond_to :vin
            @leia.vin.must_equal @vin
          end

          it "Verifies vehicle ID is a string, containing no more than 17 characters" do
            proc {Driver.new(@id, @name, 777)
            }.must_raise ArgumentError

            proc {Driver.new(@id, @name, "777333777333777333")
            }.must_raise ArgumentError
          end
     end
end
