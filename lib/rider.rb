class Rider

  attr_reader

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
    # call get_trips
    # iterate through list and make list of all the driver ids
    # use Driver.find to create list of Driver instances relating to trips previously taken by the rider
  end

  def self.all
    # read in csv file to create master list of all riders
  end

  def self.find(id)
    # locates a rider in the all list given a rider id
  end

end
