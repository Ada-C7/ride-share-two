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
        it 'Initializes with the correct information' do
            @new_driver.driver_id.must_equal 18
            @new_driver.name.must_equal 'Ms. Kamille Wyman'
            @new_driver.vn.must_equal 'SUA4ALKJ0YRFMASB2'
        end
    end

    describe 'trips' do
        it 'Returns instances of Trip' do
            @new_driver.trips.must_be_instance_of RideShare::Trip
        end
        it 'Returns an Array' do
            @new_driver.trips.must_be_kind_of Array
        end
        it 'Returns the trips for only the specific driver' do
            @new_driver.trips.each do |trip|
                trip[1].must_equal 18
            end
        end
        describe 'avg_rating' do
            it 'Returns a Float' do
                @new_driver.avg_rating.must_be_kind_of Float
            end
            it 'Cant have a negative rating' do
                @new_driver.avg_rating.wont_be :<, 0
            end
            it 'Calculates the average rating correctly' do
                @new_driver.avg_rating.must_equal 3
            end
        end
        describe 'self.all' do
            it 'Returns an Array' do
                RideShare::Driver.all.must_be_kind_of Array
            end
            it 'Array contains instances of Driver' do
                RideShare::Driver.all.each do |driver|
                    driver.must_be_instance_of RideShare::Driver
                end
            end
            it 'Array contains the right amount of drivers' do
                RideShare::Driver.all.length.must_equal 300
            end
        end
        describe 'self.find' do
            it 'Returns an instance of Driver' do
                RideShare::Driver.find(18).must_be_instance_of RideShare::Driver
            end
            it 'Returns the correct Driver' do
                RideShare::Driver.find(18).must_equal @new_driver
            end
        end
    end
end
