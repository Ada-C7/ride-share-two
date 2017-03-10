require 'date'
require_relative 'file'
# require_relative 'driver'
# require_relative 'rider'

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
      driver = RideShare::Driver.find(driver_id)
      return driver unless driver.nil?
      raise ArgumentError.new("No driver with id: #{driver_id} in driver csv")
    end

    # there is no other class calling this method
    # OMG YOUR ERROR MESSAGE HELPED YOU FIND THE BAD RIDER - AMAZING!!
    def get_rider
      rider = RideShare::Rider.find(rider_id)
      return rider unless rider.nil?
      raise ArgumentError.new("No rider with id: #{rider_id} in rider csv")
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

    def self.get_data
      file_path = '/Users/Cynthia/Documents/Ada/queues/ruby_exercises/ruby_week5/ride-share-two/support/trips.csv'
      trip_data = FileData.new(file_path)
      return trip_data.read_csv_and_remove_headings
    end

    # all takes in trips_data because it is better to inject the file data object
    # this also lets you test the data more easily (you can more easily pass in bad data)
    # but there is a default of trips data
    # this project needs the default because lots of methods call each other and
    # expect that all is reading the csv data
    def self.all(trips_data = nil)
      trips_data = get_data if trips_data.nil?
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
