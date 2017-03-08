require 'csv'
require 'ap'

class Trip
  attr_reader :trip_id, :driver_id, :rider_id, :date, :rating
  def initialize(trip_id, driver_id, rider_id, date, rating)
    @trip_id = trip_id
    @driver_id = driver_id
    @rider_id = rider_id
    @date = date
    @rating = rating
  end
  def self.all
    @trips = []
    CSV.foreach("./support/trips.csv", {:headers => true}).each do |line|
      @trips << self.new(line[0].to_i, line[1].to_i, line[2].to_i, line[3].to_s, line[4].to_i)
    end
    return @trips #this is returning the trips
  end

  def self.find_driver(id)
    trip_find = Trip.all
    array_of_trips = []
    trip_find.each do |trip|
      if trip.driver_id == id
        array_of_trips << trip
      end
    end
    if array_of_trips.length == 0
    raise ArgumentError.new "Sorry, there is no trip with an ID:#{id}."
    else
      return array_of_trips
    end
  end
end

# ap Trip.all
# ap Trip.find_driver(9)
