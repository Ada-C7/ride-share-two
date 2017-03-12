require_relative 'spec_helper'

describe RideShare::Trip do
    let(:new_trip) { RideShare::Trip.new(37) }
    let(:first_trip) { RideShare::Trip.new(1) }
    let(:last_trip) { RideShare::Trip.new(600) }

    # trip-info: 37,49,80,2016-04-01,4

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
            proc { RideShare::Trip.new('$*2hus') }.must_raise ArgumentError
            proc { RideShare::Trip.new(-47) }.must_raise ArgumentError
        end
        it 'Raises an error if ID doesnt exist' do
            proc { RideShare::Trip.new(8_387_764) }.must_raise ArgumentError
            proc { RideShare::Trip.new(0) }.must_raise ArgumentError
        end
        it 'Raises an error if rating number is incorrect value' do
            proc { RideShare::Trip.new(18, trip_rating: '-2') }.must_raise ArgumentError
            proc { RideShare::Trip.new(18, trip_rating: '5.5') }.must_raise ArgumentError
            proc { RideShare::Trip.new(18, trip_rating: '0') }.must_raise ArgumentError
            proc { RideShare::Trip.new(18, trip_rating: '') }.must_raise ArgumentError
        end
        it 'Initializes with the correct information for edge cases' do
            first_trip.trip_id.must_equal 1
            first_trip.driver_id.must_equal '1'
            first_trip.rider_id.must_equal '54'
            first_trip.trip_date.must_equal '2016-04-05'
            first_trip.trip_rating.must_equal '3'

            last_trip.trip_id.must_equal 600
            last_trip.driver_id.must_equal '61'
            last_trip.rider_id.must_equal '168'
            last_trip.trip_date.must_equal '2016-04-25'
            last_trip.trip_rating.must_equal '3'
        end
    end

    describe 'driver' do
        it 'Returns an instance of driver' do
            new_trip.driver[0].must_be_instance_of RideShare::Driver
        end
        it 'Returns accurate data' do
            new_trip.driver[0].driver_id.must_equal 49
            new_trip.driver[0].name.must_equal 'Stanford Hills'
            new_trip.driver[0].vin.must_equal 'WD3HFVVW4N1FVPC5X'
        end
    end

    describe 'rider' do
        it 'Returns an instance of Rider' do
            new_trip.rider[0].must_be_instance_of RideShare::Rider
        end
        it 'Returns accurate data' do
            new_trip.rider[0].rider_id.must_equal 80
            new_trip.rider[0].name.must_equal 'Celestine Smith'
            new_trip.rider[0].phone_number.must_equal '1-256-942-4605'
        end
    end

    describe 'self.all' do
        it 'Returns instances of Trip' do
            RideShare::Trip.all.each { |trip| trip.must_be_instance_of RideShare::Trip }
        end
        it 'Array contains correct Trip info' do
            RideShare::Trip.all[36].trip_id.must_equal 37
            RideShare::Trip.all[36].driver_id.must_equal'49'
            RideShare::Trip.all[36].rider_id.must_equal '80'
            RideShare::Trip.all[36].trip_date.must_equal'2016-04-01'
            RideShare::Trip.all[36].trip_rating.must_equal '4'
        end
        it 'Array contains the right amount of drivers' do
            RideShare::Trip.all.length.must_equal 600
        end

        it 'Contains the correct trip info for edge cases' do
            RideShare::Trip.all.first.driver_id.must_equal first_trip.driver_id
            RideShare::Trip.all.first.rider_id.must_equal first_trip.rider_id
            RideShare::Trip.all.first.trip_rating.must_equal first_trip.trip_rating

            RideShare::Trip.all.last.driver_id.must_equal last_trip.driver_id
            RideShare::Trip.all.last.rider_id.must_equal last_trip.rider_id
            RideShare::Trip.all.last.trip_rating.must_equal last_trip.trip_rating
        end
    end

    describe 'self.driver_trips()' do
        it 'Returns instances of Trip' do
            RideShare::Trip.driver_trips(89).each { |trip| trip.must_be_instance_of RideShare::Trip }
        end
        it 'Raises an error if incorrect id is entered' do
            proc { RideShare::Trip.driver_trips('wrong') }.must_raise ArgumentError
            proc { RideShare::Trip.driver_trips('$*2hus') }.must_raise ArgumentError
            proc { RideShare::Trip.driver_trips(-47) }.must_raise ArgumentError
        end
        it 'Returns the trips for only the specific driver' do
            RideShare::Trip.driver_trips(89).each do |trip|
                trip.driver_id.must_equal '89'
            end
        end
        it 'Outputs a message if driver has no trips' do
            proc { RideShare::Trip.driver_trips(101) }.must_output /.+/
        end
    end

    describe 'self.rider_trips()' do
        it 'Returns instances of Trip' do
            RideShare::Trip.rider_trips(75).each { |trip| trip.must_be_instance_of RideShare::Trip }
        end
        it 'Raises an error if incorrect id is entered' do
            proc { RideShare::Trip.rider_trips('wrong') }.must_raise ArgumentError
            proc { RideShare::Trip.rider_trips('$*2hus') }.must_raise ArgumentError
            proc { RideShare::Trip.rider_trips(-47) }.must_raise ArgumentError
        end
        it 'Returns the trips for only the specific driver' do
            RideShare::Trip.rider_trips(75).each do |trip|
                trip.rider_id.must_equal '75'
            end
        end
        it 'Outputs a message if driver has no trips' do
            proc { RideShare::Trip.rider_trips(301) }.must_output /.+/
        end
    end
end
