# Each trip should:
#
### have an ID, rider ID, a driver ID, date, rating

# Each rating should be within an acceptable range (1-5)


class Trip

  attr_accessor :trip_id, :driver_id, :rider_id, :date, :rating, :raiting_range

  def initialize(hash)
    @trip_id = hash[:trip_id]
    @driver_id = hash[:driver_id]
    @rider_id = hash[:rider_id]
    @date = hash[:date]
    @rating = hash[:rating]
    @rating_range = valid_rating? if @rating == (1..5)
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


  def self.trips_by_driver(driver_id)
    all_trips = Trip.all
    driver_trips = []
    all_trips.each do |trip|
      driver_trips << trip if trip.driver_id == driver_id
      return driver_trips
      #given a driver id return all trips that have this driver id
    end
  end


  def self.trips_by_rider(rider_id)
    all_trips = Trip.all
    rider_trips = []
    all_trips.each do |trip|
      rider_trips << trip if trip.rider_id == rider_id
      return rider_trips
      #return instances unique to rider
      #trips
    end
  end


  def self.find(trip_id)
    all_trips = Trip.all
    find_trip = nil
    all_trips.each do |trip|
      find_trip = trip if trip.trip_id == trip_id
    end
    raise ArgumentError.new("Drivers don't match") if find_trip == nil
    return find_trip
    #remember above loop as searching to reset from nil
  end

  #local_var[] = class object.class_method(pass arg)

  def trip_driver(driver_id)
    trips_by_driver
    driver_instance = Trip.driver_id
    #find driver for single instance of trip/retrieve the associated driver instance through the driver ID
  end


  def find_rider(rider_id)
    trips_by_rider
    rider_instance = Trip.rider_id
    # find rider for single instance of trip/retrieve the associated driver instance through the driver ID
  end

end#class end
