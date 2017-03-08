require 'pry'
require 'csv'
require_relative 'driver'
require_relative 'rider'

module Rideshare
  class Trip
    attr_reader  :driver_id, :rider_id, :rating, :trip_id

    def initialize(trip_hash)
      @trip_id = trip_hash[:trip_id]
      @driver_id = trip_hash[:driver_id]
      @rider_id = trip_hash[:rider_id]
      @date = trip_hash[:date]
      @rating = trip_hash[:rating]
    end

    def self.create_trips
      array = []
      CSV.foreach('support/trips.csv', {:headers => true}) do |row|
       array << Trip.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]})
     end
     return array
    end


    def self.find_by_driver(param)
      array = Trip.create_trips.select{| value| value[1]== param.to_s}
      # array = []
      # CSV.foreach('support/trips.csv', {:headers=> true, :header_converters => :symbol}) do |row|
      # array << Trip.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]}) if row[1] == param.to_s
      # end
      return array
    end

    def self.find_by_rider(param)
      array = Trip.create_trips.select{| value| value[2]== param.to_s}
      # array =[]
      # CSV.foreach('support/trips.csv', {:headers=> true, :header_converters => :symbol}) do |row|
      # array << Trip.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]}) if row[2] == param.to_s
      # end
      return array
    end

    def make_driver
    #helper method to extract driver_id from trip object
      Rideshare::Driver.find_driver(self.driver_id)
    end

    def make_rider
    #helper method to extract driver_id from trip object
      Rideshare::Rider.find_rider(self.rider_id)
    end
  end
end


puts Rideshare::Trip.create_trips[0].make_rider
puts Rideshare::Trip.create_trips[0].make_driver

#
#
