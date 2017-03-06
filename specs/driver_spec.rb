require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/driver'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe RideShare::Driver do
    before do
        @new_driver = RideShare::Driver.new(18)
    end
    describe 'initialize' do
        it 'Creates a new instance of Driver' do
            @new_driver.must_be_instance_of RideShare::Driver
        end
    end
end
