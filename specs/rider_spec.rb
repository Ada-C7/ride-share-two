require_relative 'spec_helper'

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
