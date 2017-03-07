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
  end

  def get_all_prev_drivers
    # use get_trips to get list of Trips this rider has taken
    # iterate over the list and use Driver.find(id) with each of the driver_id params from the trip to generate a list of drivers that correspond to the trips
  end

  def self.all
    # read in csv file to create master list of all riders
  end

  def self.find(id)
    # locates a rider in the all list given a rider id
  end

end
