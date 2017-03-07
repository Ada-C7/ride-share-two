require_relative 'spec_helper'

describe RideShare::Rider do
    let(:new_rider) { RideShare::Rider.new(256) }

    describe 'initialize' do
        it 'Creates a new instance of Rider' do
            new_rider.must_be_instance_of RideShare::Rider
        end
        it 'Initializes with the correct information' do
            new_rider.driver_id.must_equal 18
            new_rider.name.must_equal 'Ms. Kamille Wyman'
            new_rider.vin.must_equal 'SUA4ALKJ0YRFMASB2'
        end
        it 'Raises an error if incorrect id is entered' do
            proc { RideShare::Rider.new('wrong') }.must_raise ArgumentError
            proc { RideShare::Rider.new(101) }.must_raise ArgumentError
            proc { RideShare::Rider.new(-47) }.must_raise ArgumentError
        end
    end
end
