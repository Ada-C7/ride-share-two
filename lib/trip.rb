class Trip

  attr_reader 

  def initialize(hash)
    @id = hash[:id]
    @rider_id = hash[:rider_id]
    @driver_id = hash[:driver_id]
    @date = hash[:date]
    @rating = hash[:rating]
    # has a valid length to check for
  end

  def get_driver
    # uses Driver.find(id) to retrieve the Driver object for that Trip
  end

  def get_rider
    # uses Rider.find(id) to retrieve the Rider object for that Trip
  end

  def self.all_with_driver(id)
    # locates all trips in the all list given a driver id
  end

  def self.all_with_rider(id)
    # locates all trips in the all list given a rider id
  end

  def self.all
    # read in CSV file to creat list of all trip instances
  end

end
