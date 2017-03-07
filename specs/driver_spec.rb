require_relative 'spec_helper'

describe RideShare::Driver do
    let(:new_driver) { RideShare::Driver.new(18) }

    describe 'initialize' do
        it 'Creates a new instance of Driver' do
            new_driver.must_be_instance_of RideShare::Driver
        end
        it 'Initializes with the correct information' do
            new_driver.driver_id.must_equal 18
            new_driver.name.must_equal 'Ms. Kamille Wyman'
            new_driver.vin.must_equal 'SUA4ALKJ0YRFMASB2'
        end
        it 'Raises an error if incorrect id is entered' do
            proc { RideShare::Driver.new('wrong') }.must_raise ArgumentError
            proc { RideShare::Driver.new(101) }.must_raise ArgumentError
            proc { RideShare::Driver.new(-47) }.must_raise ArgumentError
        end
    end

    describe 'avg_rating' do
        it 'Returns a Float' do
            new_driver.avg_rating.must_be_kind_of Float
        end
        it 'Cant have a negative rating' do
            new_driver.avg_rating.wont_be :<, 0
        end
        it 'Calculates the average rating correctly' do
            new_driver.avg_rating.must_equal 3.4
        end
    end
    describe 'self.all' do
        it 'Returns an Array' do
            RideShare::Driver.all.must_be_kind_of Array
        end
        it 'Array contains correct Driver info' do
            RideShare::Driver.all[17].must_equal ['18', 'Ms. Kamille Wyman', 'SUA4ALKJ0YRFMASB2']
        end
        it 'Array contains the right amount of drivers' do
            RideShare::Driver.all.length.must_equal 100
        end
    end
    describe 'self.find' do
        it 'Returns an array of Driver info' do
            RideShare::Driver.find(18).must_be_kind_of Array
        end
        it 'Returns the correct Driver' do
            RideShare::Driver.find(18)[0].must_equal ['18', 'Ms. Kamille Wyman', 'SUA4ALKJ0YRFMASB2']
        end
    end
end
