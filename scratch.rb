require 'csv'

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
    hash = {}
    CSV.foreach('support/trips.csv', {:headers => true, :header_converters=> :symbol}) do |row|
     hash[row[0]] = Trip.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]})
   end
   return hash
  end


  def self.find_driver(param)
    hash = {}
    CSV.foreach('support/trips.csv', {:headers=> true, :header_converters => :symbol}) do |row|
    hash[row[0]] = Trip.new({trip_id:row[0], driver_id:row[1], rider_id:row[2],date:row[3], rating:row[4]}) if row[1] == param.to_s
    end
    return hash
  end
end
end
# print Trip.find_driver("23").rider_id

# puts Trip.find_driver(80).keys.class
array = Rideshare::Trip.find_driver(1).keys
puts array
Rideshare::Trip.find_driver(1)[array[0]]
# Trip.create_trips.length.must_equal 600
