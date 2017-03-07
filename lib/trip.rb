require 'csv'
require 'pry'

class Trip

  attr_reader :rider_id, :driver_id, :rating, :id, :date

  def initialize(hash)
    @id = hash[:id]
    @driver_id = hash[:driver_id]
    @rider_id = hash[:rider_id]
    @date = hash[:date]
    @rating = hash[:rating]
  end

  def get_driver
    return Driver.find(@driver_id)
  end

  def get_rider
    return Rider.find(@rider_id)
  end

  def self.all_with_driver(id)
    list_of_trips = []
    all_trips = Trip.all("support/trips.csv")
    all_trips.each do |trip|
      list_of_trips << trip if trip.driver_id == id
    end
    return list_of_trips
  end

  def self.all_with_rider(id)
    list_of_trips = []
    all_trips = Trip.all("support/trips.csv")
    all_trips.each do |trip|
      list_of_trips << trip if trip.rider_id == id
    end
    return list_of_trips
  end

  def self.all(csv)
    my_file = CSV.open(csv)
    all_trip_info = []
    my_file.each do |line|
      trip_hash = {}
      trip_hash[:id] = line[0].to_i
      trip_hash[:driver_id] = line[1].to_i
      trip_hash[:rider_id] = line[2].to_i
      trip_hash[:date] = line[3]
      trip_hash[:rating] = line[4].to_f if line[4].to_f >= 1 && line[4].to_f <= 5

      all_trip_info << trip_hash
    end
    raise NoDataError.new("no data") if all_trip_info.empty?
    all_trip_info.delete_at(0)
    all_trips = []
    all_trip_info.each do |trip|
      new_trip = Trip.new(trip)
      all_trips << new_trip
    end

    return all_trips
  end

end
