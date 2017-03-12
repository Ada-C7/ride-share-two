
require 'csv'
require 'pry'

class Rider

  attr_accessor :rider_id, :name, :phone

  def initialize(hash)
    @rider_id = hash[:rider_id]
    @name = hash[:name]
    @phone = hash[:phone]
  end


  def self.all
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
    all_riders.map do |rider|
      find_rider = rider if rider.rider_id == rider_id
    end
    raise ArgumentError.new("Riders don't match") if find_rider == nil
    return find_rider
  end


  def rider_trips(rider_id)
    rider_trips = []
    rider_trips = Rider.trips_by_rider(@rider_id)
  end


  def drivers_per_rider(rider_id)
    rider_drivers = []
    rider_trips = []
    trips_by_rider
    rider_trips.each do |driver_id|
      rider_drivers << driver_id
    end
  end

end#class end
