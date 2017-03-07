require_relative 'spec_helper'

describe RideShare::Trip do
    let(:new_trip) { RideShare::Trip.new(37) }

    # 37,49,80,2016-04-01,4

    describe 'initialize' do
        it 'Creates a new instance of Trip' do
            new_trip.must_be_instance_of RideShare::Trip
        end
        it 'Initializes with the correct information' do
            new_trip.trip_id.must_equal 37
            new_trip.driver_id.must_equal '49'
            new_trip.rider_id.must_equal '80'
            new_trip.trip_date.must_equal '2016-04-01'
            new_trip.trip_rating.must_equal '4'
        end
        it 'Raises an error if incorrect id is entered' do
            proc { RideShare::Trip.new('wrong') }.must_raise ArgumentError
            proc { RideShare::Trip.new(601) }.must_raise ArgumentError
            proc { RideShare::Trip.new(-47) }.must_raise ArgumentError
        end
    end

    describe 'driver' do
        it 'Returns an array of accurate driver info' do
            new_trip.driver.must_be_kind_of Array
            new_trip.driver[0][0].must_equal '49'
            new_trip.driver[0][1].must_equal 'Stanford Hills'
            new_trip.driver[0][2].must_equal 'WD3HFVVW4N1FVPC5X'
        end
    end

    describe 'rider' do
        it 'Returns an array of accurate rider info' do
            new_trip.rider.must_be_kind_of Array
            new_trip.rider[0][0].must_equal '80'
            new_trip.rider[0][1].must_equal 'Celestine Smith'
            new_trip.rider[0][2].must_equal '1-256-942-4605'
        end
    end

    describe 'self.all' do
        it 'Returns an Array' do
            RideShare::Trip.all.must_be_kind_of Array
        end
        it 'Array contains correct Trip info' do
            RideShare::Trip.all[36].must_equal ['37', '49', '80', '2016-04-01', '4']
        end
        it 'Array contains the right amount of drivers' do
            RideShare::Trip.all.length.must_equal 600
        end
    end

    describe 'self.driver_trips()' do
        it 'Returns an Array' do
            RideShare::Trip.driver_trips(89).must_be_kind_of Array
        end
        it 'Returns the trips for only the specific driver' do
            RideShare::Trip.driver_trips(89).each do |trip|
                trip[1].must_equal '89'
            end
        end
    end

    describe 'self.rider_trips()' do
        it 'Returns an Array' do
            RideShare::Trip.rider_trips(75).must_be_kind_of Array
        end
        it 'Returns the trips for only the specific driver' do
            RideShare::Trip.rider_trips(75).each do |trip|
                trip[2].must_equal '75'
            end
        end
    end
end
