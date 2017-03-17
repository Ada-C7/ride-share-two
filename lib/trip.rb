require 'csv'
require_relative 'driver'
require_relative 'rider'

class Trip
  attr_reader :id, :driver_id, :rider_id, :date, :rating

  def initialize(trip_id, driver_id, rider_id, date, rating)
    @id = trip_id.to_i
    @driver_id = driver_id.to_i
    @rider_id = rider_id.to_i
    @date = date
    raise ArgumentError.new("Rating must be an integer 1-5") if rating <= 0 || rating > 5 || rating.class != Integer
    @rating = rating

  end

  def self.driver(search_id)
    return Driver.find(search_id)
  end

  def self.rider(search_id)
    return Rider.find(search_id)
  end



  def self.all
    trips = []

    CSV.foreach("./support/trips.csv", {:headers => true}) do |line|
      id = line[0].to_i
      driver_id = line[1].to_i
      rider_id = line[2].to_i
      date = line[3]
      rating = line[4].to_i

      trips << Trip.new(id, driver_id, rider_id, date, rating)
    end
    return trips

  end

  def self.rider_find_all(search_id)
    raise ArgumentError.new("The ID you want to search for must be an integer") if search_id.class != Integer
    rider_trips = []
    all_trips = self.all

    all_trips.each {|trip| rider_trips << trip if trip.rider_id == search_id }


    raise ArgumentError.new("No matching trips for that rider") if rider_trips.length == 0

    return rider_trips

  end


  def self.driver_find_all(search_id)
    raise ArgumentError.new("The ID you want to search for must be an integer") if search_id.class != Integer
    driver_trips = []
    all_trips = self.all

    all_trips.each {|trip| driver_trips << trip if trip.driver_id == search_id }

    raise ArgumentError.new("No matching trips for that driver") if driver_trips.length == 0

    return driver_trips
  end


end
