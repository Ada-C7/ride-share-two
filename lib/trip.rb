# require 'csv'
# require_relative 'driver'
# require_relative 'rider'

class Trip
  attr_reader :id, :driver_id, :rider_id, :date, :rating

  def initialize(trip_hash)
    @id = trip_hash[:id]
    @driver_id = trip_hash[:driver_id]
    @rider_id = trip_hash[:rider_id]
    @date = trip_hash[:date]
    @rating = trip_hash[:rating]
  end

end
