require 'csv'

class Rider

  attr_reader :id

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @phone_number = hash[:phone_number]
  end

  def get_trips
    return Trip.all_with_rider(@id)
  end

  def get_all_prev_drivers
    trips = get_trips
    drivers = []
    trips.each do |trip|
      driver = Driver.find(trip.driver_id)
      drivers << driver
    end
    return drivers
  end

  def self.all
    my_file = CSV.open("support/riders.csv")
    all_rider_info = []
    my_file.each do |line|
      rider_hash = {}
      rider_hash[:id] = line[0].to_i
      rider_hash[:name] = line[1]
      rider_hash[:phone_number] = line[2]

      all_rider_info << rider_hash
    end
    all_riders = []
    all_rider_info.delete_at(0)
    all_rider_info.each do |rider|
      new_rider = Rider.new(rider)
      all_riders << new_rider
    end

    return all_riders
  end

  def self.find(id)
    all_riders = Rider.all
    found_rider = nil
    all_riders.each do |rider|
      found_rider = rider if rider.id == id
    end
    raise ArgumentError.new("No rider found") if found_rider == nil
    return found_rider
  end

end
