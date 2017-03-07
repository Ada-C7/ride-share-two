require 'csv'

class Trip

  attr_reader :rider_id, :driver_id, :rating, :id

  def initialize(hash)
    @id = hash[:id]
    @driver_id = hash[:driver_id]
    @rider_id = hash[:rider_id]
    @date = hash[:date]
    @rating = hash[:rating]
    # must be between 1 and 5
  end

  def get_driver
    # uses Driver.find(id) to retrieve the Driver object for that Trip
    return Driver.find(@driver_id)
  end

  def get_rider
    # uses Rider.find(id) to retrieve the Rider object for that Trip
    return Rider.find(@rider_id)
  end

  def self.all_with_driver(id)
    list_of_trips = []
    all_trips = Trip.all
    all_trips.each do |trip|
      list_of_trips << trip if trip.driver_id == id
    end
    return list_of_trips
    # locates all trips in the all list given a driver id
  end

  def self.all_with_rider(id)
    list_of_trips = []
    all_trips = Trip.all
    all_trips.each do |trip|
      list_of_trips << trip if trip.rider_id == id
    end
    return list_of_trips
    # locates all trips in the all list given a rider id
  end

  def self.all
    # read in CSV file to creat list of all trip instances
    my_file = CSV.open("support/trips.csv")
    all_trip_info = []
    my_file.each do |line|
      trip_hash = {}
      trip_hash[:id] = line[0].to_i
      trip_hash[:driver_id] = line[1].to_i
      trip_hash[:rider_id] = line[2].to_i
      trip_hash[:date] = line[3]
      trip_hash[:rating] = line[4].to_f

      all_trip_info << trip_hash
    end
    all_trip_info.delete_at(0)
    all_trips = []
    all_trip_info.each do |trip|
      new_trip = Trip.new(trip)
      all_trips << new_trip
    end

    return all_trips
  end

end
