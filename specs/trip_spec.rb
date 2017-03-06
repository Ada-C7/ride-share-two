require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/trip'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe RideShare::Trip do
    before do
        @new_trip = RideShare::Trip.new(37)
    end
    describe 'initialize' do
        it 'Creates a new instance of Trip' do
            @new_trip.must_be_instance_of RideShare::Trip
        end
    end
end
