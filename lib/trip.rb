require 'csv'
# require_relative 'module.rb'



module Rideshare
  class Trip
    attr_accessor :driver_id, :rider_id, :rating, :trip_id

    def initialize(trip_hash)

      @trip_id = trip_hash[:trip_id]
      @driver_id = trip_hash[:driver_id]
      @rider_id = trip_hash[:rider_id]
      @date = trip_hash[:date]
      @rating = trip_hash[:rating]
      raise StandardError.new("That is an invalid driver id") if @driver_id.to_i > 100 || @driver_id.to_i < 0
      raise StandardError.new("That is an invalid rating") if @rating.to_i > 5 || @rating.to_i < 1
      raise StandardError.new("That is an invalid rider id") if @rider_id.to_i > 300 || @rider_id.to_i < 0

    end

    def self.create_trips
      array = []
      CSV.foreach('support/trips.csv', {:headers => true}) do |row|
       array << Trip.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]})
     end
        array = array.reject{|value|value.rating.to_i < 1 || value.rating.to_i > 5}
     return array
    end


    def self.find_by_driver(param)
      return Trip.create_trips.select{|value| value.driver_id== param.to_s}

    end

    def self.find_by_rider(param)
      array = Trip.create_trips.select{| value| value.rider_id== param.to_s}
      raise StandardError.new("That is an invalid rating") if array.length < 1

      # array =[]
      # CSV.foreach('support/trips.csv', {:headers=> true, :header_converters => :symbol}) do |row|
      # array << Trip.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]}) if row[2] == param.to_s
      # end
      return array

    end



    def make_driver
    #helper method to extract driver_id from trip object
      Driver.find_driver(self.driver_id)
    end

    def make_rider
    #helper method to extract driver_id from trip object
      Rider.find_rider(Trip.rider_id)

    end
  end
end

#
#
# puts Rideshare::Trip.create_trips[0].make_rider
# puts  Rideshare::Trip.create_trips[1].driver_id
# puts Rideshare::Trip.find_by_driver(17)
# puts Rideshare::Trip.find_by_driver(102)
# puts Rideshare::Trip.find_by_rider(290)
#
# #
#
