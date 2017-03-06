require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/rider'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe RideShare::Rider do
    before do
        @new_rider = RideShare::Rider.new(256)
    end
    describe 'initialize' do
        it 'Creates a new instance of Rider' do
            @new_rider.must_be_instance_of RideShare::Rider
        end
    end
end
