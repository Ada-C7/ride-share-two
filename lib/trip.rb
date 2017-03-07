require 'csv'
require 'ap'

class Trip
  attr_reader :trip_id, :rider_id, :driver_id, :date, :rating
  def initialize(trip_id, rider_id, driver_id, date, rating)
    @trip_id = trip_id
    @rider_id = rider_id
    @driver_id = driver_id
    @date = date
    @rating = rating
  end
  def self.all
    @trips = []
    CSV.open("./support/trips.csv").each do |line|
      @trips << self.new(line[0].to_i, line[1].to_i, line[2].to_i, line[3].to_s, line[4].to_i)
    end
    return @trips #this is returning the riders
  end
end

# ap Trip.all
