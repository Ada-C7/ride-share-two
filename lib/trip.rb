# Each trip should:
#
# have an ID, rider ID, a driver ID, date, rating
# Each rating should be within an acceptable range (1-5)

# Given a trip object, you should be able to:
#

# retrieve the associated driver instance through the driver ID
# retrieve the associated rider instance through the rider ID
# You should be able to:
#

# find all trip instances for a given driver ID
# find all trip instances for a given rider ID
# retrieve all trips from the CSV file

class Trip

  attr_accessor :trip_id, :driver_id, :rider_id, :date, :rating

  def initialize(hash)
    @trip_id = hash[:trip_id]
    @driver_id = hash[:driver_id]
    @rider_id = hash[:rider_id]
    @date = hash[:date]
    @rating = hash[:rating]
  end

  #per trip object
  def self.all
    trips = []
    trips_master = CSV.read("support/trips.csv")
    trips_master.delete_at(0)
    trips_master.each do |line|
      trip_hash = {}
      trip_hash[:trip_id] = line[0].to_i
      trip_hash[:driver_id] = line[1]
      trip_hash[:rider_id] = line[2]
      trip_hash[:date] = line[3]
      trip_hash[:rating] = line[4]
      trips << Trip.new(trip_hash)
    end
    return trips

  end


  def self.trip_by_driver(id)
    all_trips = Trip.all
    find_trips = []
    all_trips.each do |trip|
      find_trips << trip if trip.driver_id == id
      return find_trips
      #given a driver id return all trips that have this driver id
    end

  end


  def self.trips_by_rider(id)
    all_trips = Trip.all
    find_trips = []
    all_trips.each do |trip|
      find_trips << trip if trip.rider_id == id
      return find_trips
      #return instances unique to rider
      #trips
    end


    # def self.find
    #   all_trips = Trip.all
    #   find_trip = nil
    #   all_trips.each do |trip|
    #     find_trip = trip if trip.id == trip_id
    #   end
    #   raise ArgumentError.new("Trips don't match") if find_trip == nil
    #   return find_trip
    # end

  end
end#class end
