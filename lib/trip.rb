require 'date'
# require_relative 'file'
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

    # this will auto throw an arugment error if not given proper format
    def self.test_for_date(date)
      Date.parse(date)
    end

    def self.test_for_rating(rating)
      raise ArgumentError.new('Rating must be 1-5') unless ['1', '2', '3', '4', '5'].include?(rating)
      Integer(rating)
    end

    # this method returns the read trips.csv data
    def self.get_data
      file_path = './support/trips.csv'
      trip_data = FileData.new(file_path)
      return trip_data.read_csv_and_remove_headings
    end

    # this method checks the array of trips for duplicate trip ids
    def self.test_for_duplicates(trips)
      trip_ids = trips.map { |trip| trip.id }
      if trip_ids.length != trip_ids.uniq.length
        duplicates = trip_ids.detect { |id| trip_ids.count(id) > 1 }
        raise ArgumentError.new("There are two trips with the same id: #{duplicates}")
      end
      trips
    end

    # this all method also requires the trips_data as a FileData object
    # if the data is not passed in an arguments, the get_data method will be called
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

      test_for_duplicates(trips)
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
