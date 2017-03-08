require 'pry'
require 'csv'
require_relative 'lib/driver'
require_relative 'lib/rider'
module Rideshare
  class Scratch
    attr_reader  :driver_id, :rider_id, :rating, :trip_id

    def initialize(trip_hash)
      @trip_id = trip_hash[:trip_id]
      @driver_id = trip_hash[:driver_id]
      @rider_id = trip_hash[:rider_id]
      @date = trip_hash[:date]
      @rating = trip_hash[:rating]

    end

    def self.create_trips
      array =[]
      CSV.foreach('support/trips.csv', {:headers => true}) do |row|
       #hash[row[0]] =
       array << Scratch.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]})
     end

     return array
    end


    # def self.find_by_driver(param)
    #
    #   hash = Trip.create_trips.select{|key, value| value.driver_id == param.to_s}
      # array = []
      # CSV.foreach('support/trips.csv', {:headers=> true, :header_converters => :symbol}) do |row|
      # array << self.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]}) if row[1] == param.to_s
      # end
    #    return hash.values
    # end
    #
    # def self.find_by_rider(param)
    #   array =[]
    #   CSV.foreach('support/trips.csv', {:headers=> true, :header_converters => :symbol}) do |row|
    #   array << Trip.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]}) if row[2] == param.to_s
    #   end
    #   return array
    # end

    # def make_driver
    # #helper method to extract driver_id from trip object
    #   Rideshare::Driver.find_driver(Rideshare::Trip.driver_id)
    # end

    # def make_rider
    # #helper method to extract driver_id from trip object
    #   Rideshare::Rider.find_rider(self.rider_id)
    # end
    #
    # def find_driver_id(param)
    # #helper method to extract driver_id from trip object
    #   Rideshare::Trip.find_driver(param)[0].driver_id
    # end
    # def find_rider(param)
    #   Rideshare::Rider.find_rider(self.find_rider(param)[rider_id])
    #   end
    # end

    # find_driver(param)
    #    self.create_trips unless trips_created?
    #   if @alltrips.each |array| do
    #    array[1] == param
    #    driver_id = csv.open driver_id
    #    return driver_id
    #   end
    # end
  end
end
#
puts  Rideshare::Scratch.create_trips

# puts Rideshare::Trip.find_by_driver(17).each{|v|v.driver_id}
# puts Rideshare::Trip.find_by_rider(54)
#
# puts Rideshare::Trip.find_by_rider(17)[0]
# puts driver[0]
# puts driver
# driver.make_driver
# puts rider
# rider.make_rider

#
#
#
