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
    # returns a list of all driver instances
  end

  def self.find(rider_id)
    # searches .all for rider matching the parameter
    # returns a driver instance
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
