class Driver

  attr_reader :id

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @vehicle_id = hash[:vehicle_id]
    # has a valid length to check for
  end

  def get_trips
    # calls Trip.all_with_driver and passes in Driver id
  end

  def average_rating
    # average rating for driver based on all trips taken
    # calls get_trips, adds the rating and divides by how many
  end

  def self.all
    # read in csv file to create master list of all drivers
  end

  def self.find(id)
    # locates a driver in the all list given a driver id
  end

end
