require 'date'
require_relative './file'
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

    def get_driver
      RideShare::Driver.find(driver_id)
    end

    # there is no other class calling this method
    def get_rider
      RideShare::Rider.find(rider_id)
    end

                    ###################
                    ## Class methods ##
                    ###################

    def self.test_for_integer(num)
      Integer(num)
    end

    # this will throw an arugment error if not given proper format
    def self.test_for_date(date)
      Date.parse(date)
    end

    def self.test_for_rating(rating)
      raise ArgumentError.new('Rating must be 1-5') unless ['1', '2', '3', '4', '5'].include?(rating)
      Integer(rating)
    end

    # all takes in trips_data so you can test bad data
    # but will default to nil which then gets set to the csv data if nothing is passed
    # when the find methods call all - they will not send any data
    def self.all(trips_data = nil)

      if trips_data.nil?
       trip_data = FileData.new("./support/trips.csv")
       trips_data = trip_data.read_csv_and_remove_headings
     end

      raise ArgumentError if trips_data.empty?

      trips = trips_data.map do |trip_info|
        raise ArgumentError unless trip_info.length == 5
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

    def self.find_by_driver(id)
      trips = all
      trips_of_driver = trips.map { |trip| trip if trip.driver_id == id }.compact
      trips_of_driver.empty? ? nil : trips_of_driver
    end

    def self.find_by_rider(id)
      trips = all
      trips_of_rider = trips.map { |trip| trip if trip.rider_id == id }.compact
      trips_of_rider.empty? ? nil : trips_of_rider
    end
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
