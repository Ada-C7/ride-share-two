require 'csv'

class Rider

  attr_reader :id

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @phone_number = hash[:phone_number]
    # has a valid length to check for
  end

  def get_trips
    # calls Trip.all_with_rider and passes in rider id
    return Trip.all_with_rider(@id)
  end

  def get_all_prev_drivers
    # use get_trips to get list of Trips this rider has taken
    # iterate over the list and use Driver.find(id) with each of the driver_id params from the trip to generate a list of drivers that correspond to the trips
    trips = get_trips
    drivers = []
    trips.each do |trip|
      driver = Driver.find(trip.driver_id)
      drivers << driver
    end
    return drivers
  end

  def self.all
    # read in csv file to create master list of all riders
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
    # locates a rider in the all list given a rider id
    all_riders = Rider.all
    found_rider = nil
    all_riders.each do |rider|
      found_rider = rider if rider.id == id
    end
    raise ArgumentError.new("No rider found") if found_rider == nil
    return found_rider
  end

end
