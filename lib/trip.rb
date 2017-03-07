class Trip

  attr_reader

  def initialize(hash)
    @id = hash[:id]
    @rider_id = hash[:rider_id]
    @driver_id = hash[:driver_id]
    @date = hash[:date]
    @rating = hash[:rating]
    # must be between 1 and 5
  end

  def get_driver
    # uses Driver.find(id) to retrieve the Driver object for that Trip
  end

  def get_rider
    # uses Rider.find(id) to retrieve the Rider object for that Trip
  end

  def self.all_with_driver(id)
    list_of_trips = []
    all_trips = Trip.all
    all_trips.each do |trip|
      list_of_trips << trip if trip.driver_id == id
    end
    return list_of_trips
    # locates all trips in the all list given a driver id
  end

  def self.all_with_rider(id)
    list_of_trips = []
    all_trips = Trip.all
    all_trips.each do |trip|
      list_of_trips << trip if trip.rider_id == id
    end
    return list_of_trips
    # locates all trips in the all list given a rider id
  end

  def self.all
    # read in CSV file to creat list of all trip instances
  end

end
