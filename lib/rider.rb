require 'csv'

class Rider
  attr_reader :id, :name, :phone_num

  def initialize(id, name, phone_num)
    @id = id
    @name = name
    @phone_num = phone_num
  end

  def self.all
    # reads CSV
    # returns a list of all rider instances
    riders = CSV.read("support/riders.csv", { :headers => true })

    riders.map { |line| Rider.new(line[0].to_i, line[1], line[2]) }

  end

  def self.find(rider_id)
    # searches .all for rider matching the parameter
    # returns a driver instance
    found_rider = Rider.all.find { |rider| rider.id == rider_id }
    return found_rider if found_rider
    # create a special NoDriver error, maybe rescue it?
    raise ArgumentError.new("rider #{rider_id} does not exist")
  end

  def list_trips
    # passes rider_id to find_trips_per_rider
    # returns a list of trip instances only this rider has taken
  end

  def list_drivers
    # accesses list of trip instances from lists_trips
    # returns lists of all previous driver instances assoicated with this rider
  end

end
