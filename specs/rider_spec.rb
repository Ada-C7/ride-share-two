require_relative 'spec_helper'

describe RideShare::Rider do
    let(:new_rider) { RideShare::Rider.new(256) }

    # 256,Kiara Kuhn,458.159.0504 x540

    describe 'initialize' do
        it 'Creates a new instance of Rider' do
            new_rider.must_be_instance_of RideShare::Rider
        end
        it 'Initializes with the correct information' do
            new_rider.rider_id.must_equal 256
            new_rider.name.must_equal 'Kiara Kuhn'
            new_rider.phone_number.must_equal '458.159.0504 x540'
        end
        it 'Raises an error if incorrect id is entered' do
            proc { RideShare::Rider.new('wrong') }.must_raise ArgumentError
            proc { RideShare::Rider.new(101) }.must_raise ArgumentError
            proc { RideShare::Rider.new(-47) }.must_raise ArgumentError
        end
    end
    describe 'previous_drivers' do
        it 'Returns an array of accurate driver data' do
            new_rider.previous_drivers.must_include ['69', 'Ernesto Torp', 'RF4BPA803R4AACTR1']
        end
    end
    describe 'self.all' do
        it 'Returns an Array' do
            RideShare::Rider.all.must_be_kind_of Array
        end
        it 'Array contains correct Rider info' do
            RideShare::Rider.all[255].must_equal ['256', 'Kiara Kuhn', '458.159.0504 x540']
        end
        it 'Array contains the right amount of Riders' do
            RideShare::Rider.all.length.must_equal 300
        end
    end
    describe 'self.find' do
        it 'Returns an array of Rider info' do
            RideShare::Rider.find(256).must_be_kind_of Array
        end
        it 'Returns the correct Rider' do
            RideShare::Rider.find(256)[0].must_equal ['256', 'Kiara Kuhn', '458.159.0504 x540']
        end
    end
end
