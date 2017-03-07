require 'date'
module RideShare
  class Trip
    attr_reader :id, :driver_id, :rider_id, :date, :rating

    def initialize(info)
      @id = info[:id]
      @driver_id = info[:driver_id]
      @rider_id = info[:rider_id]
      @date = info[:date]
      @rating = info[:rating]
    end

    def self.all(trips_data)
      raise ArgumentError if trips_data.empty?
      trips = trips_data.map do |trip_info|
        trip = Hash.new
        trip[:id] = test_for_integer(trip_info[0])
        trip[:driver_id] = test_for_integer(trip_info[1])
        trip[:rider_id] = test_for_integer(trip_info[2])
        trip[:date] = test_for_date(trip_info[3])
        trip[:rating] = test_for_rating(trip_info[4])
        self.new(trip)
      end
      return trips
    end

    def self.test_for_integer(num)
      Integer(num)
    end

    # this will throw an arugment error if not given proper format
    def self.test_for_date(date)
      Date.parse(date)
    end

    def self.test_for_rating(rating)
      raise ArgumentError.new("Rating must be 1-5") unless ['1', '2', '3', '4', '5'].include?(rating)
      Integer(rating)
    end

    # These two method are very similar - maybe should have a helper method
    # doing this you get undefined method/variable rider_id cause you
    # don't have access to reader methods unless you have an instance of this class
    # Chris would figure out how to make this work
    def self.find_by_driver(id, trips_data)
      trips = all(trips_data)
      trips_of_driver = trips.map { |trip| trip if trip.driver_id == id }.compact
      return trips_of_driver
    end

    def self.find_by_rider(id, trips_data)
      trips = all(trips_data)
      trips_of_rider = trips.map { |trip| trip if trip.rider_id == id }.compact
      return trips_of_rider
    end

    # helper method to use in place of the two above methods - CHRIS WOULD FIGURE OUT HOW TO USE THIS
    # def self.find(id, trips_data, driver_or_rider)
    #   trips = all(trips_data)
    #   search_by_id = driver_or_rider == driver_id ? driver_id : rider_id
    #   trips.map! { |trip| trip if trip.search_by_id == id }.compact!
    #   return trips
    # end
  end
end

# p RideShare::Trip.find_by_driver(2, '../support/trips.csv')
# p RideShare::Trip.test_for_date("hello")
# p RideShare::Trip.all([['3', '1', '54', "2016-04-05", '4']])
# p RideShare::Trip.all([['3', 'one', '54', "2016-04-05", '4']])
# p RideShare::Trip.test_for_rating("7")
# p RideShare::Trip.test_for_integer('7')
# this will fail when you try to send nothing to test for intger etc...
# p RideShare::Trip.all([[]])
