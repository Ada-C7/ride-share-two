s
require 'csv'
require 'pry'

class Rider

  attr_accessor :rider_id, :name, :phone

  def initialize()
    @rider_id = hash[:rider_id]
    @name = hash[:name]
    @phone = hash[:phone]
  end


  def self.all #read in from csv
    riders = []
    riders_master = CSV.read("support/riders.csv")
    riders_master.delete_at(0)
    riders_master.each do |line|
      rider_hash = {}
      rider_hash[:rider_id] = line[0].to_i
      rider_hash[:name] = line[1]
      rider_hash[:phone] = line[2]
      riders << Rider.new(rider_hash)
    end
    return riders
  end

  def self.find(rider_id)
    all_riders = Rider.all
    find_rider = nil
    all_riders.each do |rider|
      find_rider = rider if rider.rider_id == rider_id
    end
    raise ArgumentError.new("Riders don't match") if find_rider == nil
    return find_rider
    #remember above loop as searching to reset from nil
    # FIND a specific rider using their numeric ID
  end


  def rider_trips(rider_id)
    rider_trips = []
    rider_trips = Rider.trips_by_rider(@rider_id)
    #find all previous trip instances for this rider instance
  end

  # retrieve the list of all previous driver instances (through the trips functionality built above) #DRIVERS(TRIPS)

  def drivers_per_rider(rider_id)
    rider_drivers = []
    trips_by_rider
    #^returns all trips for single rider instance "rider_trips"
    rider_trips.each do |driver_id|
      rider_drivers << driver_id
    end
  end


end#class end
